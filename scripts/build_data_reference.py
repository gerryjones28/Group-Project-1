#!/usr/bin/env python
"""Build an organised, human-readable reference pack for the College Scorecard data.

The script is READ-ONLY with respect to the input workbook: it never writes to
``data/CollegeScorecardDataDictionary.xlsx``.  Everything it produces goes into
``Docs/DataReference/``.

What it produces
----------------
Docs/DataReference/
    INDEX.md                                  index of the whole pack
    CollegeScorecard_Data_Structure.pdf       the "how is this data structured" explainer
    CollegeScorecard_Data_Structure.html      the source used to render the PDF
    reference/00_readme_and_key_tabs.md       the workbook README, tidied
    reference/01_glossary.csv                 glossary sheet -> tidy CSV
    reference/02_changelog.csv                ChangeLog sheet -> tidy CSV (dates filled down)
    reference/03_institution_variables.csv    1 row per institution variable (3308)
    reference/04_institution_variables_by_category.md
                                              the same 3308 variables, grouped by category
    reference/05_value_labels.csv             coded variables -> their value/label decoding
    reference/06_cohort_coverage.csv          which years each variable actually exists in
    reference/07_field_of_study_variables.csv 1 row per field-of-study variable
    reference/08_api_field_paths.txt          copy/paste-ready API field paths
    reference/09_api_path_validation.csv      live API check of every generated path

Usage
-----
    python scripts/build_data_reference.py                 # build everything
    python scripts/build_data_reference.py --skip-api      # no network calls
    python scripts/build_data_reference.py --no-pdf        # skip PDF rendering

The live API check is optional and needs a DATAGOV_API_KEY in ``.Renviron``
(it is read, never printed, never written anywhere).
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import html
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

try:
    import openpyxl
except ImportError:  # pragma: no cover
    sys.exit("openpyxl is required.  Install it with:  python -m pip install openpyxl")


# --------------------------------------------------------------------------------------
# Paths and constants
# --------------------------------------------------------------------------------------

ROOT = Path(__file__).resolve().parents[1]
WORKBOOK = ROOT / "data" / "CollegeScorecardDataDictionary.xlsx"
OUT_DIR = ROOT / "Docs" / "DataReference"
REF_DIR = OUT_DIR / "reference"

API_BASE = "https://api.data.gov/ed/collegescorecard/v1/schools"

# Categories, in the order they make sense to a reader (not alphabetical).
CATEGORY_ORDER = [
    "root",
    "school",
    "admissions",
    "cost",
    "aid",
    "student",
    "academics",
    "completion",
    "earnings",
    "repayment",
]

CATEGORY_BLURB = {
    "root": "Identifiers for the institution itself (Unit ID, OPE ID, lat/lon, school code). "
            "These are the join keys. Not year-specific.",
    "school": "Who the school is: name, address, sector/ownership, Carnegie classification, "
              "accreditor, minority-serving flags, Title IV status, endowment, faculty.",
    "admissions": "How hard it is to get in: admission rate and SAT/ACT score distributions.",
    "cost": "What it costs: tuition and fees, average net price overall and by family-income band.",
    "aid": "What students get and what they owe: Pell/loan take-up rates, median debt at graduation "
           "and for non-completers, PLUS loans.",
    "student": "Who is enrolled and how many: total size, race/ethnicity shares, first-generation "
               "share, family income, full-time/part-time split.",
    "academics": "What is taught: share of degrees by CIP field, programs offered, "
                 "average months to completion by program.",
    "completion": "Whether students finish: 100%/150%/200% completion and outcome rates, "
                  "broken down by Pell status, loan status, first-gen status, race and time "
                  "since entry. The single largest category.",
    "earnings": "What graduates earn: median/mean earnings and counts of working vs not working "
                "1-11 years after entry or after completion, plus earnings thresholds.",
    "repayment": "Whether loans get repaid: cohort default rates, repayment rates at 1/3/5/7 years, "
                 "and balance-based repayment rates (BBRR/DBRR) split by demographics and cohorts.",
}

YEAR_RE = re.compile(r"(?:MERGED_|FieldOfStudyData)(\d{4})[_\-]?(\d{2}|20\d{2})?")


def log(msg: str) -> None:
    print(f"[build_data_reference] {msg}", flush=True)


def clean(value) -> str:
    """Normalise a cell: None -> '', collapse newlines/extra spaces."""
    if value is None:
        return ""
    if isinstance(value, (dt.datetime, dt.date)):
        return value.strftime("%Y-%m-%d")
    text = str(value).replace("\r\n", "\n").replace("\r", "\n")
    text = re.sub(r"[ \t]+", " ", text)
    return text.strip()


def is_missing(value) -> bool:
    text = clean(value).upper()
    return text in {"", "NA", "N/A", "NULL", "NONE"}


# --------------------------------------------------------------------------------------
# Workbook readers
# --------------------------------------------------------------------------------------


def sheet_rows(workbook, name: str) -> list[tuple]:
    ws = workbook[name]
    return [tuple(row) for row in ws.iter_rows(values_only=True)]


def build_institution_variables(workbook) -> tuple[list[dict], list[dict]]:
    """Return (variables, value_labels).

    The Institution_Data_Dictionary sheet is a *sparse* layout: a row with a populated
    ``VARIABLE NAME`` starts a new variable, and the rows immediately after it that have a
    blank ``VARIABLE NAME`` but a populated ``VALUE`` hold that variable's code/label
    decoding.  (Some of those continuation rows also repeat ``dev-category``, which is why
    a naive ``Counter`` over that column over-counts the categories.)
    """
    rows = sheet_rows(workbook, "Institution_Data_Dictionary")[1:]
    variables: list[dict] = []
    labels: list[dict] = []
    current: dict | None = None

    for row in rows:
        name_of_element = clean(row[0])
        category = clean(row[1]).lower()
        dev_name = clean(row[2])
        api_type = clean(row[3])
        indexed = clean(row[4])
        variable = clean(row[5])
        value = row[6]
        label = clean(row[7])
        source = clean(row[8])
        shown = clean(row[9])
        notes = clean(row[10])

        if variable:
            api_path = dev_name if category == "root" else f"{category}.{dev_name}"
            current = {
                "variable_name": variable,
                "category": category,
                "api_path": api_path,
                "api_field_latest": f"latest.{api_path}" if category != "root" else api_path,
                "name_of_data_element": name_of_element,
                "api_data_type": api_type,
                "indexed_in_api": "yes" if indexed else "",
                "source": source,
                "shown_use_on_site": shown,
                "notes": notes,
                "n_value_labels": 0,
            }
            variables.append(current)
        elif not is_missing(value) and label:
            # Continuation row holding a value/label decoding.
            target = current
            labels.append({
                "variable_name": target["variable_name"] if target else "",
                "category": target["category"] if target else category,
                "api_field_latest": target["api_field_latest"] if target else "",
                "name_of_data_element": target["name_of_data_element"] if target else name_of_element,
                "value": clean(value),
                "label": label,
            })
            if target:
                target["n_value_labels"] += 1

    return variables, labels


def build_cohort_coverage(workbook, variables: list[dict]) -> list[dict]:
    """One row per variable: which datafile years actually carry data for it."""
    rows = sheet_rows(workbook, "Institution_Cohort_Map")
    header = [clean(h) for h in rows[0]]
    year_cols = [(i, h) for i, h in enumerate(header) if i > 0 and h]

    def label_for(col_header: str) -> str:
        m = YEAR_RE.search(col_header)
        return f"{m.group(1)}-{m.group(2)}" if m and m.group(2) else col_header

    field_by_var = {v["variable_name"]: v for v in variables}
    coverage: list[dict] = []
    for row in rows[1:]:
        var = clean(row[0])
        if not var:
            continue
        years_with_data, years_coded_na = [], []
        detail: list[str] = []
        for idx, col_header in year_cols:
            text = clean(row[idx]) if idx < len(row) else ""
            if is_missing(text):
                years_coded_na.append(label_for(col_header))
            else:
                years_with_data.append(label_for(col_header))
                detail.append(f"{label_for(col_header)} :: {text}")
        meta = field_by_var.get(var, {})
        coverage.append({
            "variable_name": var,
            "category": meta.get("category", ""),
            "api_field_latest": meta.get("api_field_latest", ""),
            "years_with_data_count": len(years_with_data),
            "first_year_with_data": years_with_data[0] if years_with_data else "",
            "last_year_with_data": years_with_data[-1] if years_with_data else "",
            "years_with_data": "; ".join(years_with_data),
            "years_reported_na": "; ".join(years_coded_na),
            "cohort_detail": " || ".join(detail),
        })
    return coverage


def build_field_of_study(workbook) -> tuple[list[dict], list[dict]]:
    """Field-of-study variables.

    These are NOT flat queryable fields.  In the API the whole field-of-study record for an
    institution is one nested array under ``latest.programs.cip_4_digit``, and each dictionary
    row names a key *inside* the array element.  So the paths here are documented as
    ``latest.programs.cip_4_digit[].<sub-key>`` rather than as a literal ``fields=`` value.
    """
    rows = sheet_rows(workbook, "FieldOfStudy_Data_Dictionary")[1:]
    variables: list[dict] = []
    labels: list[dict] = []
    current: dict | None = None
    for row in rows:
        name_of_element, category, dev_name, api_type = (clean(row[0]), clean(row[1]).lower(),
                                                        clean(row[2]), clean(row[3]))
        variable, value, label = clean(row[4]), row[5], clean(row[6])
        source, notes, indexed = clean(row[7]), clean(row[8]), clean(row[9])
        if variable:
            nested_key = dev_name[len("cip_4_digit."):] if dev_name.startswith("cip_4_digit.") \
                else dev_name
            current = {
                "variable_name": variable,
                "category": category,
                "api_path": dev_name,
                "api_field_latest": f"latest.programs.cip_4_digit[].{nested_key}",
                "array_field_latest": "latest.programs.cip_4_digit",
                "nested_key": nested_key,
                "name_of_data_element": name_of_element,
                "api_data_type": api_type,
                "source": source,
                "notes": notes,
                "indexed_in_api": indexed,
                "n_value_labels": 0,
            }
            variables.append(current)
        elif not is_missing(value) and label:
            labels.append({
                "variable_name": current["variable_name"] if current else "",
                "category": current["category"] if current else category,
                "api_field_latest": current["api_field_latest"] if current else "",
                "value": clean(value),
                "label": label,
            })
            if current:
                current["n_value_labels"] += 1
    return variables, labels


def build_glossary(workbook) -> list[dict]:
    rows = sheet_rows(workbook, "Glossary")
    header = [clean(h) or f"col{i}" for i, h in enumerate(rows[0])]
    out = []
    for row in rows[1:]:
        if not clean(row[0]):
            continue
        out.append({header[i]: clean(row[i]) for i in range(len(header))})
    return out


def build_changelog(workbook) -> list[dict]:
    """The ChangeLog uses merged-style blank cells for the Date column: fill down."""
    rows = sheet_rows(workbook, "ChangeLog")
    out: list[dict] = []
    last_date = ""
    for row in rows[1:]:
        date = clean(row[0]) or last_date
        last_date = date
        tab = clean(row[1])
        desc = clean(row[2])
        if not (tab or desc):
            continue
        out.append({"date": date, "tab": tab, "description_of_change": desc})
    return out


# --------------------------------------------------------------------------------------
# Writers
# --------------------------------------------------------------------------------------


def write_csv(path: Path, rows: list[dict], fieldnames: list[str] | None = None) -> None:
    """Write a CSV as utf-8-sig so Excel opens it without mojibake."""
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        path.write_text("", encoding="utf-8-sig")
        return
    fieldnames = fieldnames or list(rows[0].keys())
    with path.open("w", newline="", encoding="utf-8-sig") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)


def write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def md_escape(text: str) -> str:
    return text.replace("|", "\\|")


def truncate(text: str, width: int) -> str:
    text = clean(text)
    if len(text) <= width:
        return text
    return text[: width - 3].rstrip() + "..."


def write_variables_by_category(path: Path, variables: list[dict], coverage: dict[str, dict],
                                value_labels: list[dict]) -> None:
    """The workhorse human-readable document: 3308 variables, grouped by category."""
    labels_by_var: dict[str, list[dict]] = {}
    for label in value_labels:
        labels_by_var.setdefault(label["variable_name"], []).append(label)

    by_cat: dict[str, list[dict]] = {}
    for var in variables:
        by_cat.setdefault(var["category"], []).append(var)

    ordered = [c for c in CATEGORY_ORDER if c in by_cat]
    ordered += sorted(set(by_cat) - set(ordered))

    lines: list[str] = []
    lines.append("# College Scorecard - Institution Variables by Category")
    lines.append("")
    lines.append("Generated from `data/CollegeScorecardDataDictionary.xlsx` "
                 "(sheet `Institution_Data_Dictionary`). The workbook itself is unchanged.")
    lines.append("")
    lines.append(f"**{len(variables)} institution-level variables** across "
                 f"**{len(ordered)} categories**.")
    lines.append("")
    lines.append("How to read each table:")
    lines.append("")
    lines.append("- **API field path** - what you pass to `fields=` in the API and to "
                 "`sc_select()` in `rscorecard`. `latest.` means \"most recent value available\"; "
                 "replace it with a year such as `2019.` to pin a year.")
    lines.append("- **Raw column name** - the `VARIABLE NAME` used in the original "
                 "`MERGED_YYYY_YY_PP.csv` files. THIS IS A DIFFERENT STRING from the API path.")
    lines.append("- **Years** - how many of the 30 annual datafiles (1996-97 ... 2025-26) "
                 "the workbook's `Institution_Cohort_Map` says carry a value for this variable. "
                 "`30` means all years. A `1` is normal for slow-moving or identifier fields "
                 "(`LATITUDE`, `ACCREDAGENCY`, `CITY`) that the workbook only documents against "
                 "the most recent file - it does NOT mean the value is missing from the older "
                 "datafiles. Check `reference/06_cohort_coverage.csv` before treating any low "
                 "number as real absence.")
    lines.append("")
    lines.append("### Category index")
    lines.append("")
    lines.append("| # | Category | Variables | What it covers |")
    lines.append("|---|----------|-----------|----------------|")
    for i, cat in enumerate(ordered, start=1):
        lines.append(f"| {i} | `{cat}` | {len(by_cat[cat])} | {md_escape(CATEGORY_BLURB.get(cat, ''))} |")
    lines.append("")
    lines.append("---")
    lines.append("")

    for i, cat in enumerate(ordered, start=1):
        subset = by_cat[cat]
        lines.append(f"## {i}. `{cat}` - {len(subset)} variables")
        lines.append("")
        if CATEGORY_BLURB.get(cat):
            lines.append(f"> {CATEGORY_BLURB[cat]}")
            lines.append("")
        lines.append("| API field path | Raw column name | Type | Years | Variable meaning |")
        lines.append("|---|---|---|---|---|")
        for var in subset:
            cov = coverage.get(var["variable_name"], {})
            years = cov.get("years_with_data_count", "")
            lines.append(
                "| `{path}` | `{raw}` | {typ} | {yrs} | {desc} |".format(
                    path=var["api_field_latest"],
                    raw=var["variable_name"],
                    typ=var["api_data_type"] or "-",
                    yrs=years if years != "" else "-",
                    desc=md_escape(truncate(var["name_of_data_element"], 110)),
                )
            )
        lines.append("")

        coded = [v for v in subset if v["n_value_labels"]]
        if coded:
            lines.append(f"### {i}.1 Coded variables in `{cat}` "
                         f"({len(coded)} of {len(subset)} need a value/label lookup)")
            lines.append("")
            for var in coded:
                lines.append(f"**`{var['api_field_latest']}`** (raw `{var['variable_name']}`) "
                             f"- {var['name_of_data_element']}")
                lines.append("")
                lines.append("| Value | Meaning |")
                lines.append("|---|---|")
                for label in labels_by_var.get(var["variable_name"], []):
                    lines.append(f"| `{label['value']}` | {md_escape(label['label'])} |")
                lines.append("")
        lines.append("---")
        lines.append("")

    lines.append("## Where these numbers came from")
    lines.append("")
    lines.append("Everything in this file is a straight reshape of the workbook - no external "
                 "data, no estimates. Regenerate with:")
    lines.append("")
    lines.append("```bash")
    lines.append("python scripts/build_data_reference.py")
    lines.append("```")
    lines.append("")
    write_text(path, "\n".join(lines))


def write_api_field_paths(path: Path, variables: list[dict], coverage: dict[str, dict]) -> None:
    """Plain text, copy/paste-ready field paths, grouped by category."""
    by_cat: dict[str, list[dict]] = {}
    for var in variables:
        by_cat.setdefault(var["category"], []).append(var)
    ordered = [c for c in CATEGORY_ORDER if c in by_cat]
    ordered += sorted(set(by_cat) - set(ordered))

    lines: list[str] = []
    lines.append("COLLEGE SCORECARD API - INSTITUTION-LEVEL FIELD PATHS")
    lines.append("=" * 70)
    lines.append("")
    lines.append("Every path below uses the `latest.` prefix (most recent value available).")
    lines.append("Swap `latest` for a 4-digit year to pin a specific datafile, e.g.")
    lines.append("    2019.student.size      instead of     latest.student.size")
    lines.append("")
    lines.append("Rate limit: 1000 requests / IP / hour.  Max per_page = 100.")
    lines.append("")
    for cat in ordered:
        subset = by_cat[cat]
        lines.append("")
        lines.append("=" * 70)
        lines.append(f"CATEGORY: {cat}   ({len(subset)} variables)")
        lines.append("=" * 70)
        for var in subset:
            cov = coverage.get(var["variable_name"], {})
            years = cov.get("years_with_data_count", 0)
            lines.append(f"{var['api_field_latest']}")
            lines.append(f"    raw column : {var['variable_name']}")
            lines.append(f"    type       : {var['api_data_type'] or 'n/a'}"
                         f"    years with data: {years}/30")
            lines.append(f"    meaning    : {truncate(var['name_of_data_element'], 150)}")
        lines.append("")
    write_text(path, "\n".join(lines))


def write_readme_doc(path: Path, workbook, glossary: list[dict], changelog: list[dict],
                     n_inst_vars: int, n_fos_vars: int, n_labels: int) -> None:
    sheets = []
    for name in workbook.sheetnames:
        ws = workbook[name]
        sheets.append((name, ws.max_row, ws.max_column))

    lines: list[str] = []
    lines.append("# The Data Dictionary Workbook, Explained")
    lines.append("")
    lines.append("Source file: `data/CollegeScorecardDataDictionary.xlsx` "
                 "(**not modified** by this pack).")
    lines.append("")
    total_rows = sum(ws.max_row for ws in (workbook[name] for name in workbook.sheetnames))
    lines.append(f"This document reorganises the workbook so you can find things without "
                 f"scrolling through {total_rows:,} spreadsheet rows.")
    lines.append("")
    lines.append("## 1. The workbook README")
    lines.append("")
    readme = sheet_rows(workbook, "README")
    readme_headings = {
        "background on the data", "key tabs", "important data quality notes",
        "data documentation report links:", "contacts",
    }
    for row in readme:
        text = clean(row[0]) if row else ""
        if not text:
            continue
        if text == "COLLEGE SCORECARD":
            lines.append(f"**{text}**")
        elif text.startswith("Released"):
            lines.append(f"*{text}*")
        elif text.lower() in readme_headings:
            lines.append(f"#### {text}")
        elif text.startswith("http"):
            lines.append(f"<{text}>")
        elif "@" in text and " " not in text:
            lines.append(f"`{text}`")
        else:
            lines.append(text)
        lines.append("")
    lines.append("> Note: the workbook is a snapshot. The `Released` date above is the release "
                 "of the dictionary file, not of the underlying datafiles.")
    lines.append("")
    lines.append("> The workbook's README contains one truncated sentence "
                 "(\"Attached is the descriptions for each data element provided in "
                 "College Scorecard, including .\") and one empty section "
                 "(\"Important Data Quality Notes\"). That is how it ships - it is not "
                 "a transcription error in this pack.")
    lines.append("")
    lines.append("## 2. What is in each tab")
    lines.append("")
    lines.append("| Tab | Rows x Cols | What it is | Why you care |")
    lines.append("|---|---|---|---|")
    tab_notes = {
        "README": ("Orientation text plus links to the two long-form PDF documentation reports.",
                   "Start here once; then never open it again."),
        "ChangeLog": ("Dated list of every change ever made to the dictionary.",
                      "Tells you when a variable was added, renamed or re-typed - critical before "
                      "you trust a time series."),
        "Glossary": ("Definitions of the abbreviations used in the cohort map "
                     "(AY, CY, DCY, FY, NSLDS, IPEDS ...).",
                     "Without this the cohort map is unreadable."),
        "Institution_Data_Dictionary": ("1 row per institution variable, plus extra rows that "
                                        "SPELL OUT the codes for encoded variables.",
                                        "The master list. This is what `03_` and `04_` in "
                                        "`reference/` flatten for you."),
        "Institution_Cohort_Map": ("Variable x 30 annual datafiles; each cell says which year/"
                                   "cohort that variable describes in that file.",
                                   "Answers \"can I even do a time series with this column?\""),
        "Most_Recent_Inst_Cohort_Map": ("Variable x 3: the cohort it describes in the single "
                                        "\"most recent\" datafile, and which merged file it came "
                                        "from.",
                                        "Explains why `latest.*` fields are NOT all the same year."),
        "FieldOfStudy_Data_Dictionary": ("1 row per field-of-study (CIP code) variable.",
                                         "Use when you want program-level, not school-level, data."),
        "FieldOfStudy_Cohort_Map": ("Variable x 9 field-of-study datafiles.",
                                    "Field-of-study data starts much later (2014-15) than "
                                    "institution data (1996-97)."),
    }
    for name, rows, cols in sheets:
        what, why = tab_notes.get(name, ("", ""))
        lines.append(f"| `{name}` | {rows:,} x {cols} | {what} | {why} |")
    lines.append("")
    lines.append("## 3. Which tabs join to which")
    lines.append("")
    lines.append("The relationship is a strict one-to-many, keyed on the *raw* column name:")
    lines.append("")
    lines.append("```")
    lines.append("Institution_Data_Dictionary.VARIABLE NAME   (1 row per variable)")
    lines.append("        |")
    lines.append("        +--> Institution_Cohort_Map.Variable Name          (1 row per variable, 30 year cols)")
    lines.append("        +--> Most_Recent_Inst_Cohort_Map.Variable Name      (1 row per variable, 1 description)")
    lines.append("        +--> continuation rows in the dictionary itself      (N rows, the VALUE/LABEL codes)")
    lines.append("```")
    lines.append("")
    lines.append("Both cohort maps are keyed on the **raw CSV column name** (`ADM_RATE`), not on "
                 "the dotted API path (`latest.admissions.admission_rate.overall`). "
                 "`reference/03_institution_variables.csv` carries both, so use it as the join table.")
    lines.append("")
    lines.append("## 4. Glossary (from the workbook)")
    lines.append("")
    lines.append("| Term | Meaning | Notes |")
    lines.append("|---|---|---|")
    for entry in glossary:
        keys = list(entry.keys())
        lines.append("| `{}` | {} | {} |".format(
            entry.get(keys[0], ""),
            md_escape(entry.get(keys[1], "") if len(keys) > 1 else ""),
            md_escape(entry.get(keys[2], "") if len(keys) > 2 else "")))
    lines.append("")
    lines.append("## 5. ChangeLog - the entries that actually matter for a class project")
    lines.append("")
    interesting = [c for c in changelog
                   if re.search(r"renamed|changed data type|added tab|replace|corrected",
                                c["description_of_change"], re.IGNORECASE)]
    lines.append(f"The sheet has {len(changelog)} entries. The "
                 f"{len(interesting)} below are the ones that change how you code:")
    lines.append("")
    lines.append("| Date | Tab | Change |")
    lines.append("|---|---|---|")
    for entry in interesting:
        lines.append(f"| {entry['date']} | `{entry['tab']}` | "
                     f"{md_escape(truncate(entry['description_of_change'], 220))} |")
    lines.append("")
    lines.append(f"Everything else in the sheet is `Updated entries with new values due to data "
                 f"refresh` style housekeeping. The complete list is in "
                 f"`reference/02_changelog.csv`.")
    lines.append("")
    lines.append("## 6. Scale, in numbers")
    lines.append("")
    lines.append("| Thing | Count |")
    lines.append("|---|---|")
    lines.append(f"| Institution-level variables | {n_inst_vars:,} |")
    lines.append(f"| Field-of-study variables | {n_fos_vars:,} |")
    lines.append(f"| Encoded variables with a value/label lookup | {n_labels:,} label rows |")
    lines.append("| Annual institution datafiles | 30 (1996-97 ... 2025-26) |")
    lines.append("| Field-of-study datafiles | 9 (2014-15 ... most recent) |")
    lines.append("| Institutions in the API | 6,273 (all) / 6,243 with `school.operating = 1` |")
    lines.append("| API rate limit | 1,000 requests per hour per IP |")
    lines.append("")
    write_text(path, "\n".join(lines))


# --------------------------------------------------------------------------------------
# Live API validation (optional, needs DATAGOV_API_KEY)
# --------------------------------------------------------------------------------------


def _fetch_json(url: str, attempts: int = 4, timeout: int = 120) -> dict | None:
    """GET a URL and parse JSON, retrying transient network failures.

    data.gov drops connections under load (WinError 10054 / HTTP 429).  Retrying matters:
    without it a dropped batch would be reported as "these paths do not exist", which is a
    false negative and would send the reader chasing a non-problem.
    """
    import time
    import urllib.error
    import urllib.request

    delay = 3.0
    for attempt in range(1, attempts + 1):
        try:
            with urllib.request.urlopen(url, timeout=timeout) as response:
                return json.loads(response.read().decode("utf-8"))
        except Exception as exc:  # noqa: BLE001
            if attempt == attempts:
                log(f"    giving up after {attempts} attempts: {exc}")
                return None
            log(f"    transient failure ({exc}); retrying in {delay:.0f}s "
                f"[{attempt}/{attempts - 1}]")
            time.sleep(delay)
            delay *= 2
    return None


def find_api_key() -> str | None:
    """Look for DATAGOV_API_KEY in .Renviron or the environment. Never printed."""
    candidates = [ROOT / ".Renviron", Path.home() / ".Renviron",
                  Path.home() / "OneDrive" / "Documents" / ".Renviron",
                  Path.home() / "Documents" / ".Renviron"]
    pattern = re.compile(r"^\s*DATAGOV_API_KEY\s*=\s*(.+?)\s*$", re.MULTILINE)
    for candidate in candidates:
        try:
            if candidate.is_file():
                match = pattern.search(candidate.read_text(encoding="utf-8-sig", errors="replace"))
                if match:
                    return match.group(1).strip().strip('"').strip("'")
        except OSError:
            continue
    return os.environ.get("DATAGOV_API_KEY") or None


def _dig(obj, dotted: str):
    """Walk a dotted path through nested dicts, returning None if any hop is missing."""
    node = obj
    for part in dotted.split("."):
        if not isinstance(node, dict) or part not in node:
            return None
        node = node[part]
    return node


def _key_paths(obj, prefix: str = "") -> set[str]:
    """Every dotted key path present in a nested dict.  Values are irrelevant, only shape."""
    found: set[str] = set()
    if isinstance(obj, dict):
        for key, value in obj.items():
            path = f"{prefix}.{key}" if prefix else key
            found.add(path)
            found |= _key_paths(value, path)
    return found


def validate_api_paths(variables: list[dict], fos_variables: list[dict],
                       sample_size: int = 5) -> list[dict]:
    """Ask the live API about every generated field path.

    The API silently ignores field names it does not recognise, but it *does* echo a
    recognised field key even when the value is null.  So "key present in the response" is
    a reliable signal that the path is real.
    """
    import urllib.parse
    import urllib.request

    key = find_api_key()
    if not key:
        log("no API key found - skipping live path validation")
        return []

    # Two different mechanisms are needed, because the two datasets are shaped differently.
    #   * institution variables are flat:  fields=latest.student.size
    #   * field-of-study variables are keys inside one nested array:
    #     fields=latest.programs.cip_4_digit  ->  [{ "counts": {...}, "debt": {...} }, ...]
    paths: list[str] = []
    seen: set[str] = set()
    for var in variables:
        path = var["api_field_latest"]
        if path not in seen:
            seen.add(path)
            paths.append(path)

    # Keep each request URL comfortably short.
    batches: list[list[str]] = []
    current: list[str] = []
    budget = 0
    for path in paths:
        if budget + len(path) + 1 > 3500:
            batches.append(current)
            current, budget = [], 0
        current.append(path)
        budget += len(path) + 1
    if current:
        batches.append(current)

    total_present: dict[str, int] = {p: 0 for p in paths}
    failed_paths: set[str] = set()
    samples = 0
    for i, batch in enumerate(batches, start=1):
        query = urllib.parse.urlencode({
            "api_key": key,
            "per_page": sample_size,
            "fields": "id," + ",".join(batch),
            "page": 0,
        })
        url = f"{API_BASE}?{query}"
        log(f"  batch {i}/{len(batches)} ({len(batch)} fields) ...")
        payload = _fetch_json(url)
        if payload is None:
            # Be explicit: these were never answered, so we cannot say anything about them.
            failed_paths.update(batch)
            log(f"  batch {i}/{len(batches)} UNANSWERED - fields marked not_checked")
            continue
        results = payload.get("results", [])
        samples = max(samples, len(results))
        for record in results:
            for path in batch:
                if path in record:
                    total_present[path] += 1
        log(f"  batch {i}/{len(batches)} ok ({len(batch)} fields x {len(results)} schools)")

    rows: list[dict] = []
    for path in paths:
        raw = next(v["variable_name"] for v in variables if v["api_field_latest"] == path)
        hits = total_present[path]
        if path in failed_paths:
            status = "not_checked"
        elif hits >= max(1, samples) * 0.5:
            status = "verified"
        elif hits > 0:
            status = "valid_but_sparse"
        elif samples == 0:
            status = "not_checked"
        else:
            status = "not_returned"
        rows.append({
            "scope": "institution_field",
            "api_field_latest": path,
            "raw_column_name": raw,
            "schools_with_key": hits,
            "schools_sampled": 0 if path in failed_paths else samples,
            "status": status,
            "note": "",
        })

    # ---- nested array pass ------------------------------------------------------------
    if fos_variables:
        array_field = fos_variables[0]["array_field_latest"]
        nested_keys = [v["nested_key"] for v in fos_variables]
        observed: set[str] = set()
        array_samples = 0
        query = urllib.parse.urlencode({
            "api_key": key,
            "per_page": 25,
            "fields": f"id,{array_field}",
            "page": 0,
        })
        log("  nested array pass: pulling the field-of-study array ...")
        payload = _fetch_json(f"{API_BASE}?{query}")
        if payload is None:
            log("  nested array pass UNANSWERED - field-of-study keys marked not_checked")
        else:
            for record in payload.get("results", []):
                # Surprising but true: when you ask for a nested array field, the service
                # echoes it back under a LITERAL dotted key, e.g. results[0]
                # ["latest.programs.cip_4_digit"], not as nested {"latest": {"programs": ...}}.
                # Try the literal key first, then fall back to walking the path.
                elements = record.get(array_field)
                if elements is None:
                    elements = _dig(record, array_field)
                if not isinstance(elements, list):
                    continue
                array_samples += 1
                for element in elements:
                    observed |= _key_paths(element)
            log(f"  nested array pass ok ({array_samples} schools, "
                f"{len(observed)} distinct key paths inside the array elements)")

        for var in fos_variables:
            key = var["nested_key"]
            if key in observed:
                status = "verified"
            elif array_samples == 0:
                status = "not_checked"
            elif key.split(".")[0] in observed:
                status = "parent_present_leaf_not_seen"
            else:
                status = "not_returned"
            rows.append({
                "scope": "field_of_study_nested_key",
                "api_field_latest": var["api_field_latest"],
                "raw_column_name": var["variable_name"],
                "schools_with_key": array_samples if key in observed else 0,
                "schools_sampled": array_samples,
                "status": status,
                "note": f"key inside each element of the {array_field} array",
            })
    return rows


# --------------------------------------------------------------------------------------
# The explainer document (HTML -> PDF)
# --------------------------------------------------------------------------------------

CSS = """
@page { size: Letter; margin: 16mm 14mm 14mm 14mm; }
* { box-sizing: border-box; }
body {
  font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
  font-size: 10.2pt; line-height: 1.45; color: #1b1f24; margin: 0;
}
h1 { font-size: 22pt; margin: 0 0 4px 0; letter-spacing: -0.4px; }
h2 {
  font-size: 13.5pt; margin: 26px 0 8px 0; padding-bottom: 4px;
  border-bottom: 2px solid #0b5fa5; color: #0b3f6e;
  break-after: avoid; page-break-after: avoid;
}
h3 { font-size: 11pt; margin: 16px 0 6px 0; color: #0b3f6e;
     break-after: avoid; page-break-after: avoid; }
p { margin: 6px 0; }
code, .mono { font-family: Consolas, "Cascadia Mono", monospace; font-size: 9pt; }
code { background: #eef3f8; padding: 1px 4px; border-radius: 3px; }
table { width: 100%; border-collapse: collapse; margin: 8px 0 12px 0; font-size: 9.2pt; }
th, td { border: 1px solid #ccd6e0; padding: 4px 6px; text-align: left; vertical-align: top; }
th { background: #0b5fa5; color: #fff; font-weight: 600; }
tr:nth-child(even) td { background: #f6f9fc; }
thead { display: table-header-group; }
tr { break-inside: avoid; page-break-inside: avoid; }
.cover { border-left: 6px solid #0b5fa5; padding: 2px 0 2px 14px; margin-bottom: 14px; }
.sub { color: #55636f; font-size: 11pt; margin-top: 2px; }
.meta { color: #7a8794; font-size: 9pt; margin-top: 8px; }
.box { background: #f2f8ff; border: 1px solid #b6d4ef; border-radius: 6px;
       padding: 10px 14px; margin: 10px 0 14px 0; }
.box h3 { margin-top: 0; }
.warn { background: #fff5ef; border-color: #f0b892; }
.warn h3 { color: #a2470a; }
.tip { background: #f2fbf3; border-color: #a9d9ae; }
.tip h3 { color: #1c6b2a; }
ul, ol { margin: 6px 0 6px 0; padding-left: 20px; }
li { margin: 3px 0; }
.nobreak { break-inside: avoid; page-break-inside: avoid; }
.pagebreak { break-before: page; page-break-before: always; }
.pill { display: inline-block; background: #0b5fa5; color: #fff; border-radius: 10px;
        padding: 0 8px; font-size: 8.5pt; margin-right: 6px; }
.small { font-size: 8.8pt; color: #55636f; }
pre { background: #f4f6f8; border: 1px solid #d8dee4; border-radius: 5px;
      padding: 8px 10px; font-size: 8.6pt; overflow-wrap: anywhere; white-space: pre-wrap; }
.kpi { display: flex; gap: 10px; margin: 10px 0 4px 0; }
.kpi div { flex: 1; background: #0b3f6e; color: #fff; border-radius: 6px;
           padding: 8px 10px; }
.kpi b { display: block; font-size: 16pt; line-height: 1.1; }
.kpi span { font-size: 8.5pt; opacity: 0.92; }
footer { margin-top: 22px; border-top: 1px solid #ccd6e0; padding-top: 8px;
         font-size: 8.5pt; color: #7a8794; }
"""


def _table(headers: list[str], rows: list[list[str]], cls: str = "") -> str:
    out = [f'<table class="{cls}">', "<thead><tr>"]
    out += [f"<th>{html.escape(h)}</th>" for h in headers]
    out.append("</tr></thead><tbody>")
    for row in rows:
        out.append("<tr>" + "".join(f"<td>{cell}</td>" for cell in row) + "</tr>")
    out.append("</tbody></table>")
    return "\n".join(out)


def render_html(variables: list[dict], coverage: dict[str, dict], labels: list[dict],
                fos_variables: list[dict], glossary: list[dict], validation: list[dict],
                today: str) -> str:
    by_cat: dict[str, list[dict]] = {}
    for var in variables:
        by_cat.setdefault(var["category"], []).append(var)
    ordered = [c for c in CATEGORY_ORDER if c in by_cat]
    ordered += sorted(set(by_cat) - set(ordered))

    n_coded = sum(1 for v in variables if v["n_value_labels"])
    n_label_rows = len(labels)
    total = len(variables)

    verified = sum(1 for r in validation if r["status"] in {"verified", "valid_but_sparse"})
    validation_line = ""
    if validation:
        inst_rows = [r for r in validation if r.get("scope") == "institution_field"]
        fos_rows = [r for r in validation if r.get("scope") == "field_of_study_nested_key"]
        inst_ok = sum(1 for r in inst_rows if r["status"] == "verified")
        fos_ok = sum(1 for r in fos_rows if r["status"] == "verified")
        not_returned = [r for r in validation if r["status"] == "not_returned"]
        validation_line = (
            f"Every API field path printed in this document was checked against the live "
            f"API on {today}: <b>{verified:,} of {len(validation):,}</b> came back from the "
            f"service. "
        )
        if inst_rows:
            validation_line += (
                f"For the flat institution fields, <b>{inst_ok:,} of {len(inst_rows):,}</b> were "
                f"echoed back by the API. "
            )
        if fos_rows:
            validation_line += (
                f"The {len(fos_rows):,} field-of-study keys were checked by pulling the "
                f"<code>latest.programs.cip_4_digit</code> array and confirming the key exists "
                f"inside an array element: <b>{fos_ok:,} of {len(fos_rows):,}</b> confirmed. "
                f"These are <i>not</i> valid <code>fields=</code> values - see section 1. "
            )
        if not_returned:
            validation_line += (f"{len(not_returned)} did not appear in the sampled schools "
                                f"(almost always because the metric only exists for a subset of "
                                f"institutions). The full result is in "
                                f"<code>reference/09_api_path_validation.csv</code>.")
        else:
            validation_line += ("Full result, with the status of every single path, in "
                                "<code>reference/09_api_path_validation.csv</code>.")

    # --- Section: category table -------------------------------------------------------
    cat_rows = []
    for cat in ordered:
        subset = by_cat[cat]
        coded = sum(1 for v in subset if v["n_value_labels"])
        cat_rows.append([
            f"<code>&lt;year&gt;.{html.escape(cat)}.*</code>" if cat != "root" else "<code>id, location.*</code>",
            html.escape(cat),
            f"{len(subset):,}",
            f"{coded}",
            html.escape(CATEGORY_BLURB.get(cat, "")),
        ])

    # --- Section: three names for one number ------------------------------------------
    examples = [
        ("admissions", "admission_rate.overall"),
        ("cost", "net_price.public.by_income_level.0-30000"),
        ("aid", "median_debt.completers.overall"),
        ("student", "size"),
        ("completion", "completion_rate_4yr_150nt"),
        ("earnings", "10_yrs_after_entry.median"),
        ("repayment", "3_yr_default_rate"),
        ("school", "ownership"),
    ]
    lookup = {v["api_path"]: v for v in variables}
    name_rows = []
    for cat, dev in examples:
        var = lookup.get(f"{cat}.{dev}")
        if not var:
            continue
        cov = coverage.get(var["variable_name"], {})
        coded = "yes" if var["n_value_labels"] else "no"
        name_rows.append([
            f"<code>{html.escape(var['api_field_latest'])}</code>",
            f"<code>{html.escape(var['variable_name'])}</code>",
            html.escape(truncate(var["name_of_data_element"], 78)),
            html.escape(var["api_data_type"] or "-"),
            f"{cov.get('years_with_data_count', '-')}/30",
            coded,
        ])

    # --- Section: coverage extremes ----------------------------------------------------
    cov_values = [coverage.get(v["variable_name"], {}).get("years_with_data_count")
                  for v in variables]
    cov_values = [c for c in cov_values if isinstance(c, int)]
    always = sum(1 for c in cov_values if c == 30)
    sometimes = sum(1 for c in cov_values if 0 < c < 30)
    never = sum(1 for c in cov_values if c == 0)

    # --- Section: glossary table -------------------------------------------------------
    glossary_rows = []
    for entry in glossary:
        keys = list(entry.keys())
        glossary_rows.append([
            f"<code>{html.escape(entry.get(keys[0], ''))}</code>",
            html.escape(entry.get(keys[1], "") if len(keys) > 1 else ""),
            html.escape(truncate(entry.get(keys[2], "") if len(keys) > 2 else "", 150)),
        ])

    # --- Section: first-EDA recipe -----------------------------------------------------
    sample_field_block = "\n".join([
        "id, school.name, school.state, school.ownership, latest.student.size,",
        "latest.admissions.admission_rate.overall, latest.cost.tuition.in_state,",
        "latest.cost.net_price.consumer.by_income_level.0-30000,",
        "latest.aid.pell_grant_rate, latest.aid.median_debt.completers.overall,",
        "latest.completion.completion_rate_4yr_150nt,",
        "latest.earnings.10_yrs_after_entry.median,",
        "latest.repayment.3_yr_default_rate",
    ])

    parts: list[str] = []
    add = parts.append

    add('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">')
    add("<title>College Scorecard - How the Data Is Structured</title>")
    add(f"<style>{CSS}</style></head><body>")

    # ---- cover ------------------------------------------------------------------------
    add('<div class="cover">')
    add("<h1>The College Scorecard Dataset</h1>")
    add('<div class="sub">How the data is actually structured - a plain-English orientation '
        "before you start EDA</div>")
    add(f'<div class="meta">Generated {today} from '
        f"<code>data/CollegeScorecardDataDictionary.xlsx</code> (unmodified) and the live "
        f"College Scorecard API. Group Project I - The College Scorecard Dataset.</div>")
    add("</div>")

    add('<div class="kpi">')
    add(f"<div><b>{total:,}</b><span>institution-level variables</span></div>")
    add(f"<div><b>{len(fos_variables):,}</b><span>field-of-study variables</span></div>")
    add("<div><b>30</b><span>annual datafiles, 1996-97 to 2025-26</span></div>")
    add("<div><b>6,273</b><span>institutions in the API</span></div>")
    add("</div>")

    # ---- 0. 60 second version ---------------------------------------------------------
    add('<div class="box">')
    add("<h3>The 60-second version</h3>")
    add("<ol>")
    add("<li><b>It is not one table.</b> There are two separate datasets that share a key: "
        "<b>institution-level</b> (one row per college per year) and "
        "<b>field-of-study-level</b> (one row per college x CIP program per year).</li>")
    add(f"<li><b>It is wide, not long.</b> Institution-level data has roughly <b>{total:,} "
        f"columns</b> in the API and ~3,000+ in the annual CSV files, for ~6,300 rows.</li>")
    add("<li><b>Every column has three names.</b> The raw CSV name (<code>ADM_RATE</code>), the "
        "dotted API path (<code>latest.admissions.admission_rate.overall</code>), and a human "
        "description. Only the dotted path works in the API; only the raw name works in the "
        "CSV files. Confusing these two is the #1 source of wasted hours.</li>")
    add("<li><b>Time is attached to the column, not the row.</b> The API stacks all years into "
        "the column name: <code>2019.student.size</code>. <code>latest.*</code> means "
        "&ldquo;most recent value we have for this specific metric&rdquo; - and that is "
        "<i>not</i> the same year for every metric.</li>")
    add("<li><b>Missing is normal and comes in flavours.</b> Blank, <code>null</code>, "
        "privacy-suppressed, and not-applicable-to-this-school all look similar downstream. "
        "Treating them all as plain <code>NA</code> is fine to start, but it is a real "
        "data-quality finding in its own right.</li>")
    add("<li><b>About 4 in 10 variables are coded integers.</b> A <code>1</code> in "
        "<code>school.ownership</code> means &ldquo;Public&rdquo;, not the number 1. "
        "The workbook's continuation rows hold those decodings; they are flattened for you in "
        "<code>reference/05_value_labels.csv</code>.</li>")
    add("<li><b>The two datasets have different shapes.</b> Institution variables are flat "
        "(one path = one number). Field-of-study variables are keys inside one nested array per "
        "institution, so they are unnested rather than selected. See the end of section 1.</li>")
    add("</ol>")
    add("</div>")

    # ---- 1. Two datasets --------------------------------------------------------------
    add("<h2>1. There are two datasets, not one</h2>")
    add("<p>Everything in the Scorecard belongs to exactly one of these. Deciding which one you "
        "need is the first decision of the project.</p>")
    add(_table(
        ["", "Institution-level", "Field-of-study-level"],
        [
            ["Grain", "One row per institution per year", "One row per institution x CIP program per year"],
            ["What it answers", "How does this college do overall?", "How does <i>this major at "
             "this college</i> do?"],
            ["API fields", f"{total:,} (<code>&lt;year&gt;.&lt;category&gt;.&lt;metric&gt;</code>)",
             f"{len(fos_variables):,} (<code>&lt;year&gt;.programs.cip_4_digit.*</code>)"],
            ["CSV files", "<code>MERGED_YYYY_YY_PP.csv</code> plus a "
             "<code>Most-Recent-Cohort</code> file",
             "<code>FieldOfStudyDataYYYY_YY.csv</code> plus a most-recent file"],
            ["Years available", "30 files, 1996-97 through 2025-26",
             "9 files, 2014-15 through the most recent"],
            ["Workbook tabs", "<code>Institution_Data_Dictionary</code>, "
             "<code>Institution_Cohort_Map</code>, <code>Most_Recent_Inst_Cohort_Map</code>",
             "<code>FieldOfStudy_Data_Dictionary</code>, <code>FieldOfStudy_Cohort_Map</code>"],
        ]))
    add('<div class="box tip"><h3>Practical consequence</h3>'
        "If your question is about <i>access, affordability or overall student outcomes</i>, "
        "use the institution-level data. The field-of-study data only starts in 2014-15, so a "
        "field-of-study time series over the full history is impossible. "
        "See the assignment's Goal 4: outcomes can cover access, affordability, student "
        "outcomes &ldquo;or other categories&rdquo; - you get to pick, and the pick is largely "
        "a data-availability question.</div>")
    add("<h3>The one shape difference you must know about</h3>")
    add("<p>The institution data is <b>flat</b>: one field path is one number. The field-of-study "
        "data is <b>nested</b>. Each institution is a single object, and inside it there is an "
        "array - one element per CIP program - and the 178 field-of-study dictionary variables "
        "are the keys <i>inside</i> those elements:</p>")
    add('<pre>latest.programs.cip_4_digit   --&gt;  [                    &lt;-- array, one element '
        'per program\n'
        "    { unit_id: 100654, code: '01.0101', title: 'Agricultural Business...',\n"
        "      credential: { level: 3, title: 'Bachelor Degree' },\n"
        "      counts:  { ipeds_awards1: ..., ipeds_awards2: ... },\n"
        "      debt: {...}, earnings: {...}, repayment: {...}, distance: ... },\n"
        "    { ...next program... }\n"
        "]</pre>")
    add("<p>So <code>latest.programs.cip_4_digit[].earnings.4_yr.overall_median_earnings</code> "
        "is <b>not</b> something you can put in <code>fields=</code>. You request the array and "
        "then unnest it. In R that is <code>tidyr::unnest_longer()</code> or "
        "<code>jsonlite::fromJSON(..., simplifyVector = TRUE)</code>; in pandas it is "
        "<code>json_normalize(record_to_explode = 'latest.programs.cip_4_digit')</code>. "
        "The exact key list is enumerated in "
        "<code>reference/07_field_of_study_variables.csv</code>.</p>")
    add('<div class="box warn"><h3>API quirk you will hit in the first five minutes</h3>'
        "When you request that array, the JSON response does <b>not</b> nest it. It comes back "
        "under a single key whose name is the literal dotted string <code>"
        "latest.programs.cip_4_digit</code>, as a sibling of <code>id</code> - not under "
        "<code>latest</code> &gt; <code>programs</code>. So <code>result$latest$programs</code> "
        "is <code>NULL</code> and it looks like there is no data. Read "
        "<code>result[['latest.programs.cip_4_digit']]</code> instead.</div>")
    add('<div class="box warn"><h3>Why this matters for your EDA</h3>'
        "If you unnest the array, your unit of analysis silently changes from "
        "<i>institution</i> to <i>institution x program</i>. Row counts explode, one school "
        "contributes dozens of rows, and any average you compute is now weighted by how many "
        "programs a school happens to offer. Aggregate back to institution level with an "
        "explicit weighting decision, or state clearly that the analysis is at program level."
        "</div>")

    # ---- 2. Three ways in -------------------------------------------------------------
    add("<h2>2. Three ways to get the same numbers</h2>")
    add(_table(
        ["Route", "How", "Use it when"],
        [
            ["Annual CSV files", "<code>MERGED_1996_97_PP.csv</code> ... "
             "<code>MERGED_2025_26_PP.csv</code>, plus <code>Most-Recent-Cohort-*.csv</code>",
             "You want the full 3,000+ column firehose, or an offline reproducible snapshot. "
             "One file per year means 30 imports and a lot of RAM."],
            ["REST API (direct)", f"<code>GET {API_BASE}?api_key=...&amp;fields=...</code>",
             "You want a subset of columns, one year, or a live/refreshable pull. "
             "Max <code>per_page=100</code>, rate limit 1,000 requests/hour."],
            ["<code>rscorecard</code> in R", "<code>sc_init() |&gt; sc_filter(...) |&gt; "
             "sc_select(...) |&gt; sc_get()</code>",
             "It is the same API with R-friendly verbs and automatic pagination. "
             "This is what the project's <code>APIWalkthrough.md</code> sets up."],
        ]))
    add("<p class=\"small\">The API is the API. <code>rscorecard</code> does not have its own "
        "copy of the data - it calls the same URL and returns a tibble. So whatever you learn "
        "about field paths and missingness applies either way.</p>")

    # ---- 3. Namespace -----------------------------------------------------------------
    add('<div class="pagebreak"></div>')
    add("<h2>3. The variable namespace: 10 categories</h2>")
    add("<p>A working API field path is a dotted path with a time prefix:</p>")
    add('<pre>&lt;time&gt; . &lt;category&gt; . &lt;sub-topic&gt; . &lt;metric&gt;\n'
        "   2019  . admissions . admission_rate     . overall\n"
        "  latest  . cost       . net_price         . consumer.by_income_level.0-30000</pre>")
    add(_table(["Prefix", "Category", "Variables", "Coded", "What it covers"],
               cat_rows))
    add('<div class="box warn"><h3>Two exceptions to remember</h3><ul>'
        "<li>The identifiers are <b>not</b> inside a category. Use <code>id</code>, "
        "<code>ope8_id</code>, <code>ope6_id</code>, <code>location.lat</code>, "
        "<code>location.lon</code> - never <code>root.id</code>.</li>"
        "<li>Scores of variables are <b>variants of the same metric</b>. For example "
        "<code>completion.completion_rate_4yr_150nt</code> (individual cohort) vs "
        "<code>completion.completion_rate_4yr_150nt_pooled</code> (two years pooled to reduce "
        "volatility). Read the trailing word before you trust a number.</li>"
        "</ul></div>")

    # ---- 4. Three names ---------------------------------------------------------------
    add("<h2>4. One number, three names - the thing that wastes the most time</h2>")
    add("<p>The dictionary gives you <b>both</b> naming systems side by side. Here is what the "
        "gap looks like for real variables:</p>")
    add(_table(
        ["API path (use in the API / rscorecard)",
         "Raw column (use in the CSV files)",
         "What it means", "Type", "Years", "Coded?"],
        name_rows))
    add('<div class="box warn"><h3>Rule of thumb</h3><ul>'
        "<li>If it is <b>lowercase with dots</b>, it is an API path. "
        "Pattern: <code>latest.category.metric</code>.</li>"
        "<li>If it is <b>SHOUTY_UPPER_SNAKE</b>, it is a raw CSV column. "
        "Pattern: <code>ADM_RATE</code>, <code>C150_4</code>, <code>MD_EARN_WNE_P10</code>.</li>"
        "<li>The cohort-map tabs are keyed on the <b>raw</b> name. The API only knows the "
        "<b>dotted</b> name. <code>reference/03_institution_variables.csv</code> holds both "
        "in one row so you can translate either way.</li>"
        "</ul></div>")

    # ---- 5. Time ----------------------------------------------------------------------
    add("<h2>5. Time lives in the column name, and it is ragged</h2>")
    add("<p>This is the part that surprises everyone. In the API there is no "
        "<code>year</code> column - the year is baked into the field name:</p>")
    add('<pre>latest.student.size      -&gt; most recent value available for THIS metric\n'
        "2019.student.size        -&gt; the value as it stood in the 2019-20 datafile\n"
        "2019.cost.tuition.in_state\n"
        "2019.earnings.10_yrs_after_entry.median</pre>")
    add(_table(
        ["Question", "Where the answer is"],
        [
            ["Which years exist for a given variable?",
             "<code>Institution_Cohort_Map</code> - variable rows x 30 year columns. "
             "A cell of <code>NA</code> means &ldquo;this metric does not exist in that "
             "datafile&rdquo;."],
            ["What exactly is being measured in that year?",
             "Same tab - the cell text names the cohort, e.g. &ldquo;AcadYr 2019-20, reported in "
             "IPEDS DCY2019-20 <i>-or-</i> NSLDS pooled AY2017-18, AY2018-19 cohort&rdquo;. "
             "The <code>-or-</code> means the metric has two different sources/definitions "
             "across the years."],
            ["Why is <code>latest.*</code> a different year in every column?",
             "<code>Most_Recent_Inst_Cohort_Map</code> - one row per variable naming the cohort "
             "it uses in the most-recent file. The API documentation says this explicitly: data "
             "are published at different times during the year."],
            ["Is a variable available for all 30 files?",
             "<code>reference/06_cohort_coverage.csv</code> - a single row per variable with "
             "<code>years_with_data_count</code>, <code>first_year_with_data</code>, "
             "<code>last_year_with_data</code>."],
        ]))
    add(f'<div class="box"><h3>The shape of the coverage, in numbers</h3><p>Of the {total:,} '
        f"institution variables:</p><ul>"
        f"<li><b>{always:,}</b> have a value somewhere in all 30 annual files (mostly "
        f"identifiers and slow-moving school characteristics).</li>"
        f"<li><b>{sometimes:,}</b> exist in some years only - the classic case, and the reason "
        f"a naive <code>read.csv</code> of every year will not line up column-wise.</li>"
        f"<li><b>{never:,}</b> are coded <code>NA</code> in every one of the 30 files. They "
        f"still exist in the API. Do not build a time series on these without checking first."
        f"</li></ul><p class=\"small\">Caveat: a low count is not always absence. Identifiers "
        f"and slow-moving fields (<code>LATITUDE</code>, <code>ACCREDAGENCY</code>, "
        f"<code>CITY</code>) show <code>1</code> because the workbook only documents them "
        f"against the most recent datafile. The cohort map records what the publisher bothered "
        f"to document, not always what the file contains.</p></div>")

    # ---- 6. Values --------------------------------------------------------------------
    add('<div class="pagebreak"></div>')
    add("<h2>6. What a cell can actually contain</h2>")
    add(_table(
        ["Situation", "What you see", "What to do"],
        [
            ["Ordinarily missing", "<code>null</code> in JSON, empty in the CSV",
             "R reads it as <code>NA</code>. Count it; it is usually the largest "
             "&ldquo;value&rdquo; in the column."],
            ["Privacy suppressed",
             "Historically the literal string <code>PrivacySuppressed</code> in the datafiles. "
             "The API's job is to give you <code>null</code> instead.",
             "Keep it distinct from ordinary missing if you can - suppression tells you the "
             "cell is small and non-zero, which is information. Watch for variables whose name "
             "contains <code>_supp</code> / <code>suppressed</code>."],
            ["Not applicable to this school",
             "<code>null</code>. E.g. an admission rate for an open-admissions or "
             "graduate-only school.",
             "This is structural, not random. Missingness patterns are themselves a finding - "
             "the assignment explicitly invites you to look at relationships in missingness."],
            ["Coded / factored",
             f"An integer whose meaning is a lookup. <b>{n_coded:,} of {total:,}</b> variables "
             f"have this, covering <b>{n_label_rows:,}</b> value/label pairs.",
             "Decode before summarising. All decodings are flattened into "
             "<code>reference/05_value_labels.csv</code>."],
            ["Pooled / moving average",
             "A separate column with <code>_pooled</code>, <code>_PP</code>, "
             "<code>_POOLED_SUPP</code>, <code>POOLYRS</code> in the name.",
             "It is a two-year average, not a single year. Never mix pooled and unpooled in "
             "the same time series."],
            ["Denominator, not a rate",
             "Names like <code>completion_cohort_*</code>, <code>*_DENOM</code>, "
             "<code>COUNT_*</code>, <code>outcome_cohort*</code>.",
             "A rate with a tiny denominator is noise. Always carry the count column next to "
             "the rate column so you can filter on it."],
        ]))

    # ---- 7. Gotchas -------------------------------------------------------------------
    add("<h2>7. The nine things that will bite you</h2>")
    add("<ol>")
    add("<li><b>Raw name vs API path.</b> <code>ADM_RATE</code> is not a valid API field; "
        "<code>admissions.admission_rate.overall</code> is not a CSV column. "
        "(See section 4.)</li>")
    add("<li><b><code>latest</code> is not a year.</b> It is a per-column &ldquo;newest "
        "available&rdquo; rule. Cross-sectional analysis across different <code>latest</code> "
        "columns mixes datafiles.</li>")
    add("<li><b>3,000+ columns will not fit comfortably in memory or on a plot.</b> "
        "Select by category first, then by cohort coverage.</li>")
    add("<li><b>~2,200 of the variables come from NSLDS, not IPEDS.</b> Loan and earnings "
        "variables have very different coverage and lags from enrolment variables. The "
        "<code>SOURCE</code> column in <code>reference/03_institution_variables.csv</code> "
        "tells you which.</li>")
    add("<li><b>Suppressed and pooled variants are separate columns.</b> A blank in the main "
        "rate column plus a value in the <code>*_pooled</code> column is a normal combination, "
        "not a bug.</li>")
    add("<li><b>OPE ID is not Unit ID.</b> <code>ope8_id</code>/<code>ope6_id</code> identify "
        "the OPE institution and can group multiple campuses. Aggregations that use the wrong "
        "key silently double-count or drop campuses.</li>")
    add("<li><b>Rows are institutions, and the institution list changes over time.</b> "
        "Schools open, close and merge. 6,273 records exist today; a 1997 file has far fewer. "
        "Any year-over-year join leaks missingness.</li>")
    add("<li><b>The dictionary is dated and versioned.</b> The workbook in "
        "<code>data/</code> is the June 2026 release. If you pull from the API later, new "
        "columns may appear that are not in this dictionary. "
        "Check <code>reference/02_changelog.csv</code>.</li>")
    add("<li><b>Field-of-study variables are nested, not flat.</b> "
        "<code>latest.programs.cip_4_digit[].*</code> paths cannot be passed to "
        "<code>fields=</code>; you request the array and unnest it, which changes your unit of "
        "analysis. (See section 1.)</li>")
    add("</ol>")

    # ---- 8. First EDA session ---------------------------------------------------------
    add('<div class="pagebreak"></div>')
    add("<h2>8. A concrete first EDA session</h2>")
    add("<p>The goal of session one is <i>not</i> to find a finding. It is to answer "
        "&ldquo;what do I actually have?&rdquo; in about an hour.</p>")

    add("<h3>Step 1 - pull a small, named sample through the API</h3>")
    add('<pre>library(rscorecard)\n\n'
        "sc_init() |&gt;\n"
        "  sc_filter(stabbr == \"FL\") |&gt;\n"
        "  sc_select(" + sample_field_block.replace("\n", "\n              ") + ") |&gt;\n"
        "  sc_get() |&gt;\n"
        "  as_tibble()</pre>")
    add("<p class=\"small\">Every path in that block is in "
        "<code>reference/08_api_field_paths.txt</code>. Keep <code>per_page</code> modest; "
        "do not try to pull 3,000 fields at once.</p>")

    add("<h3>Step 2 - measure the shape before you plot anything</h3>")
    add("<pre>dim(df)\n"
        "names(df)\n"
        "sapply(df, class)\n\n"
        "# how much is missing, per column, worst first\n"
        "sort(colMeans(is.na(df)), decreasing = TRUE) |&gt; head(30)</pre>")
    add("<p>That <code>sort(colMeans(is.na(df)))</code> line is the single highest-value "
        "command in the whole project. Compare its output against the "
        "<code>years_with_data_count</code> column in "
        "<code>reference/06_cohort_coverage.csv</code> - if a variable is missing 90% of the "
        "time in your sample but has 30/30 years of coverage, your sample is the problem, "
        "not the data.</p>")

    add("<h3>Step 3 - pick the universe on purpose</h3>")
    add('<pre># 6,273 records exist; 6,243 report that they are operating.\n'
        "# Most published analyses also restrict to Title IV, degree-granting, US-only:\n"
        "sc_init() |&gt;\n"
        "  sc_filter(school.operating == 1,\n"
        "            school.degrees_awarded.predominant != 0) |&gt;\n"
        "  sc_select(id) |&gt; sc_get() |&gt; nrow()</pre>")
    add("<p>Write down the number you get and put it in your report. Every later count is "
        "relative to this decision, and it is the kind of choice a grader will ask about.</p>")

    add("<h3>Step 4 - decode before you describe</h3>")
    add('<pre># WRONG: this looks like a numeric summary\n'
        "summary(df$school.ownership)\n\n"
        "# RIGHT: join the lookup, then summarise\n"
        "labels &lt;- readr::read_csv(\"Docs/DataReference/reference/05_value_labels.csv\")\n"
        "labels |&gt; dplyr::filter(variable_name == \"CONTROL\")</pre>")

    add("<h3>Step 5 - then, and only then, do the usual</h3>")
    add("<ul>"
        "<li>Distribution of each continuous variable you selected "
        "(<code>hist</code>/<code>boxplot</code>), with the count column beside it.</li>"
        "<li>Missingness map - <code>naniar::vis_miss()</code> or "
        "<code>VIM::aggr()</code> - on a subset of ~40 columns.</li>"
        "<li>Correlation matrix across the numeric subset, to find clusters of "
        "near-duplicate columns.</li>"
        "<li>A data-quality score per column, using the completeness and free-of-error "
        "formulas from the assignment.</li>"
        "</ul>")

    # ---- 9. File map ------------------------------------------------------------------
    add("<h2>9. Where to look things up</h2>")
    add(_table(
        ["You want to know...", "Open this"],
        [
            ["Every variable in one flat table, with both names",
             "<code>reference/03_institution_variables.csv</code>"],
            ["The same thing, readable in a browser or on GitHub",
             "<code>reference/04_institution_variables_by_category.md</code>"],
            ["Which API fields to paste into <code>sc_select()</code>",
             "<code>reference/08_api_field_paths.txt</code>"],
            ["What a code like <code>ownership = 1</code> means",
             "<code>reference/05_value_labels.csv</code>"],
            ["Whether a variable exists in 1997 or 2023",
             "<code>reference/06_cohort_coverage.csv</code>"],
            ["What an abbreviation in the cohort map means",
             "<code>reference/01_glossary.csv</code>"],
            ["When a variable was added, renamed or re-typed",
             "<code>reference/02_changelog.csv</code>"],
            ["Whether these API paths still work",
             "<code>reference/09_api_path_validation.csv</code>"],
            ["What the eight workbook tabs are",
             "<code>reference/00_readme_and_key_tabs.md</code>"],
            ["The long-form statistical methodology",
             "The two PDFs linked in the workbook README "
             "(<code>InstitutionDataDocumentation.pdf</code> and "
             "<code>FieldOfStudyDataDocumentation.pdf</code>)"],
        ]))

    if validation_line:
        add('<div class="box tip"><h3>Live-API check</h3>' + validation_line + "</div>")

    add("<footer>")
    add(f"Built by <code>scripts/build_data_reference.py</code> on {today}. "
        f"Source workbook <code>data/CollegeScorecardDataDictionary.xlsx</code> was read only - "
        f"nothing in this pack modifies the original project files. "
        f"Counts reflect a total of {total:,} institution variables and "
        f"{len(fos_variables):,} field-of-study variables.")
    add("</footer>")
    add("</body></html>")
    document = "\n".join(parts)
    # Chrome's print-to-pdf pipeline does not round-trip typographic punctuation
    # reliably (curly quotes and ellipses come out as replacement glyphs), so
    # downgrade everything to plain ASCII. The rendered PDF must be byte-clean.
    for fancy, plain in (
        ("&ldquo;", '"'), ("&rdquo;", '"'), ("&lsquo;", "'"), ("&rsquo;", "'"),
        ("&mdash;", " - "), ("&ndash;", "-"), ("&hellip;", "..."),
        ("\u201c", '"'), ("\u201d", '"'), ("\u2018", "'"), ("\u2019", "'"),
        ("\u2014", " - "), ("\u2013", "-"), ("\u2026", "..."),
    ):
        document = document.replace(fancy, plain)
    return document


CHROME_CANDIDATES = [
    r"C:\Program Files\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
    r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "/usr/bin/google-chrome",
    "/usr/bin/chromium",
    "/usr/bin/chromium-browser",
]


def find_chrome() -> str | None:
    for candidate in CHROME_CANDIDATES:
        if Path(candidate).is_file():
            return candidate
    for name in ("chrome", "google-chrome", "chromium", "msedge"):
        found = shutil.which(name)
        if found:
            return found
    return None


def render_pdf(html_path: Path, pdf_path: Path) -> bool:
    browser = find_chrome()
    if not browser:
        log("no Chrome/Edge found - wrote HTML only, skipped the PDF")
        return False
    with tempfile.TemporaryDirectory(prefix="cs_pdf_") as profile:
        cmd = [
            browser,
            "--headless=new",
            "--disable-gpu",
            "--no-sandbox",
            "--no-pdf-header-footer",
            "--run-all-compositor-stages-before-draw",
            "--virtual-time-budget=8000",
            f"--user-data-dir={profile}",
            f"--print-to-pdf={pdf_path}",
            html_path.resolve().as_uri(),
        ]
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=180)
        except subprocess.TimeoutExpired:
            log("PDF rendering timed out")
            return False
    if pdf_path.is_file() and pdf_path.stat().st_size > 5000:
        log(f"wrote {pdf_path.relative_to(ROOT)} ({pdf_path.stat().st_size / 1024:.0f} KB)")
        return True
    log("PDF rendering failed. Browser output:")
    log((result.stdout or "")[-800:])
    log((result.stderr or "")[-800:])
    return False


def write_index(path: Path, today: str, stats: dict[str, object]) -> None:
    lines = [
        "# College Scorecard - Data Reference Pack",
        "",
        f"*Generated {today}. The original project files were not modified.*",
        "",
        "## Start here",
        "",
        "**[`CollegeScorecard_Data_Structure.pdf`](CollegeScorecard_Data_Structure.pdf)** - "
        "read this first. It explains in plain English what the dataset is, how variables are "
        "named, where time lives, what a missing cell means, and a concrete first EDA session.",
        "",
        "## Everything in this folder",
        "",
        "| File | What it is | Size |",
        "|---|---|---|",
    ]
    # `[label, description, count]`
    for row in stats["index_rows"]:
        lines.append(f"| `{row[0]}` | {row[1]} | {row[2]} |")
    lines += [
        "",
        "## Regenerating",
        "",
        "```bash",
        "python scripts/build_data_reference.py              # rebuild everything",
        "python scripts/build_data_reference.py --skip-api   # offline, no API calls",
        "python scripts/build_data_reference.py --no-pdf     # skip PDF rendering",
        "```",
        "",
        "The script only ever *reads* "
        "`data/CollegeScorecardDataDictionary.xlsx`.",
        "",
        "## The one-paragraph mental model",
        "",
        "The Scorecard is two datasets. **Institution-level** is one row per college per year, "
        "about 6,300 rows and 3,000+ columns; **field-of-study-level** is one row per college x "
        "CIP programme per year, and only starts in 2014-15. In the API a column is addressed by "
        "a dotted path with a time prefix, `<year-or-latest>.<category>.<sub-topic>.<metric>`, "
        f"across {stats['n_categories']} categories. In the raw CSV files the same column is a "
        "shouty abbreviation. The dictionary workbook gives you both names, plus the year "
        "coverage for each variable and the decodings for coded columns. Use "
        "`reference/03_institution_variables.csv` as the translation table and "
        "`reference/06_cohort_coverage.csv` as the feasibility check before you promise a "
        "time series to your group.",
        "",
        "**One shape difference worth repeating:** the institution variables are flat API "
        "fields, but the field-of-study variables are keys inside a single nested array per "
        "institution (`latest.programs.cip_4_digit[]`). You unnest that array rather than "
        "selecting from it, and doing so changes your unit of analysis from institution to "
        "institution x program. `reference/07_field_of_study_variables.csv` gives the array "
        "name and the nested key as separate columns.",
        "",
    ]
    write_text(path, "\n".join(lines))


# --------------------------------------------------------------------------------------
# main
# --------------------------------------------------------------------------------------


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--skip-api", action="store_true",
                        help="do not call the live API to validate field paths")
    parser.add_argument("--no-pdf", action="store_true", help="skip PDF rendering")
    parser.add_argument("--api-sample", type=int, default=5,
                        help="how many institutions to sample per API validation request")
    args = parser.parse_args()

    if not WORKBOOK.is_file():
        log(f"workbook not found: {WORKBOOK}")
        return 1

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    REF_DIR.mkdir(parents=True, exist_ok=True)
    today = dt.date.today().strftime("%d %B %Y")

    log(f"reading {WORKBOOK.relative_to(ROOT)} (read-only)")
    workbook = openpyxl.load_workbook(WORKBOOK, read_only=True, data_only=True)

    variables, value_labels = build_institution_variables(workbook)
    log(f"  institution variables : {len(variables):,}")
    log(f"  value/label rows      : {len(value_labels):,}")

    coverage_rows = build_cohort_coverage(workbook, variables)
    coverage = {row["variable_name"]: row for row in coverage_rows}

    fos_variables, fos_labels = build_field_of_study(workbook)
    log(f"  field-of-study vars   : {len(fos_variables):,}")

    glossary = build_glossary(workbook)
    changelog = build_changelog(workbook)

    # ---- CSVs ------------------------------------------------------------------------
    write_csv(REF_DIR / "01_glossary.csv", glossary)

    write_csv(REF_DIR / "02_changelog.csv", changelog,
              ["date", "tab", "description_of_change"])

    write_csv(REF_DIR / "03_institution_variables.csv", variables, [
        "variable_name", "category", "api_path", "api_field_latest",
        "name_of_data_element", "api_data_type", "indexed_in_api", "source",
        "shown_use_on_site", "notes", "n_value_labels",
    ])

    write_csv(REF_DIR / "05_value_labels.csv", value_labels, [
        "variable_name", "category", "api_field_latest", "name_of_data_element", "value", "label",
    ])

    write_csv(REF_DIR / "06_cohort_coverage.csv", coverage_rows, [
        "variable_name", "category", "api_field_latest",
        "years_with_data_count", "first_year_with_data", "last_year_with_data",
        "years_with_data", "years_reported_na", "cohort_detail",
    ])

    write_csv(REF_DIR / "07_field_of_study_variables.csv", fos_variables, [
        "variable_name", "category", "api_path", "api_field_latest",
        "array_field_latest", "nested_key", "name_of_data_element",
        "api_data_type", "source", "notes", "indexed_in_api", "n_value_labels",
    ])
    write_csv(REF_DIR / "07b_field_of_study_value_labels.csv", fos_labels, [
        "variable_name", "category", "api_field_latest", "value", "label",
    ])

    # ---- Markdown / text -------------------------------------------------------------
    write_variables_by_category(REF_DIR / "04_institution_variables_by_category.md",
                                variables, coverage, value_labels)
    write_api_field_paths(REF_DIR / "08_api_field_paths.txt", variables, coverage)
    write_readme_doc(REF_DIR / "00_readme_and_key_tabs.md", workbook, glossary, changelog,
                     len(variables), len(fos_variables), len(value_labels))
    log("wrote reference/ CSV + Markdown files")

    # ---- Live API validation ---------------------------------------------------------
    validation: list[dict] = []
    if args.skip_api:
        # Remove a stale file from an earlier run rather than leaving a lie on disk.
        stale = REF_DIR / "09_api_path_validation.csv"
        if stale.is_file():
            stale.unlink()
            log("--skip-api set: removed the previously generated 09_api_path_validation.csv")
        log("--skip-api set: not contacting the API")
    else:
        log("validating generated field paths against the live API ...")
        validation = validate_api_paths(variables, fos_variables, sample_size=args.api_sample)
        if validation:
            write_csv(REF_DIR / "09_api_path_validation.csv", validation, [
                "scope", "api_field_latest", "raw_column_name", "schools_with_key",
                "schools_sampled", "status", "note",
            ])
            counts = {}
            for row in validation:
                counts[row["status"]] = counts.get(row["status"], 0) + 1
            log("  validation result: " + ", ".join(f"{k}={v}" for k, v in sorted(counts.items())))

    # ---- The explainer ---------------------------------------------------------------
    html_path = OUT_DIR / "CollegeScorecard_Data_Structure.html"
    pdf_path = OUT_DIR / "CollegeScorecard_Data_Structure.pdf"
    write_text(html_path, render_html(variables, coverage, value_labels, fos_variables,
                                      glossary, validation, today))
    log(f"wrote {html_path.relative_to(ROOT)}")
    if not args.no_pdf:
        render_pdf(html_path, pdf_path)

    # ---- INDEX -----------------------------------------------------------------------
    def size_of(rel: str) -> str:
        target = OUT_DIR / rel
        if not target.is_file():
            return "-"
        kb = target.stat().st_size / 1024
        return f"{kb:,.0f} KB" if kb >= 1 else f"{target.stat().st_size:,} B"

    index_rows = [
        ["CollegeScorecard_Data_Structure.pdf",
         "The explainer. Read first.", size_of("CollegeScorecard_Data_Structure.pdf")],
        ["CollegeScorecard_Data_Structure.html",
         "HTML source of the PDF (open in a browser to read without Acrobat).",
         size_of("CollegeScorecard_Data_Structure.html")],
        ["reference/00_readme_and_key_tabs.md",
         "The workbook's own README and all eight tabs, reorganised and joined up.",
         size_of("reference/00_readme_and_key_tabs.md")],
        ["reference/01_glossary.csv",
         "The Glossary tab as tidy CSV (AY, CY, DCY, FY, NSLDS, IPEDS, CIP...).",
         size_of("reference/01_glossary.csv")],
        ["reference/02_changelog.csv",
         "The ChangeLog tab as tidy CSV, dates filled down.",
         size_of("reference/02_changelog.csv")],
        ["reference/03_institution_variables.csv",
         f"The master table: {len(variables):,} institution variables, both naming systems, "
         "type, source, notes.",
         size_of("reference/03_institution_variables.csv")],
        ["reference/04_institution_variables_by_category.md",
         "The same variables grouped by category, with each coded variable's lookup table "
         "rendered inline.",
         size_of("reference/04_institution_variables_by_category.md")],
        ["reference/05_value_labels.csv",
         f"{len(value_labels):,} value/label pairs for every coded variable.",
         size_of("reference/05_value_labels.csv")],
        ["reference/06_cohort_coverage.csv",
         f"{len(coverage_rows):,} rows: years of data per variable, plus which cohort each year "
         "actually measures.",
         size_of("reference/06_cohort_coverage.csv")],
        ["reference/07_field_of_study_variables.csv",
         f"{len(fos_variables):,} field-of-study variables. These are keys INSIDE the "
         "`latest.programs.cip_4_digit[]` array element, not flat API fields - the file gives "
         "the array name and the nested key separately.",
         size_of("reference/07_field_of_study_variables.csv")],
        ["reference/07b_field_of_study_value_labels.csv",
         f"{len(fos_labels):,} field-of-study value/label pairs.",
         size_of("reference/07b_field_of_study_value_labels.csv")],
        ["reference/08_api_field_paths.txt",
         "Copy/paste-ready API field paths grouped by category, with the raw column name and "
         "meaning under each.",
         size_of("reference/08_api_field_paths.txt")],
        ["reference/09_api_path_validation.csv",
         "Live-API check of every generated field path (present/absent per sampled school)."
         if validation else "Live-API check - not run (use without --skip-api).",
         size_of("reference/09_api_path_validation.csv")],
    ]
    write_index(OUT_DIR / "INDEX.md", today,
                {"index_rows": index_rows, "n_categories": len(
                    {v["category"] for v in variables})})
    log(f"wrote {OUT_DIR.relative_to(ROOT)}\\INDEX.md")
    log("done.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())