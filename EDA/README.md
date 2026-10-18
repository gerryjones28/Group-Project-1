# EDA / data-simplification workspace

> Audit update, October 18, 2026: this is the earlier write-up. Use
> [AUDIT_REPORT](../Docs/AUDIT_REPORT.md), [student explanation](../Docs/STUDENT_EXPLANATION.md)
> and [evidence register](../presentation/RESULTS_SUMMARY.md) for current status.
> Raw data/extracts are absent locally; existing figures/tables are not newly reproduced.
> The corrected implementation preserves all four streams. Updated DQ tier boundaries,
> distinct counts and anomaly predicates require regeneration. Ordinary missingness and
> privacy suppression differ; applicability limits whole-population coverage comparisons.

> Audit update, October 18, 2026: this is the earlier write-up. Use
> [AUDIT_REPORT](../Docs/AUDIT_REPORT.md), [student explanation](../Docs/STUDENT_EXPLANATION.md)
> and [evidence register](../presentation/RESULTS_SUMMARY.md) for current status.
> Raw data/extracts are absent locally; existing figures/tables are not newly reproduced.
> The corrected implementation preserves all four streams. Updated DQ tier boundaries,
> distinct counts and anomaly predicates require regeneration. Ordinary missingness and
> privacy suppression differ; applicability limits whole-population coverage comparisons.

**Group Project I - The College Scorecard Dataset.**
Everything in this folder was produced from `data/College_Scorecard_Raw_Data_06032026/`
by the three scripts in `scripts/`. Nothing here overwrites the raw data.

---

## 1. "It won't load - is the data too large?"  Yes.

The Scorecard is shipped as one **very wide** file per year: **3,308 variables x ~7,000 institutions**.
Google Sheets allows at most **10,000,000 cells per spreadsheet** (all tabs combined), so the files are
refused at import. Excel's shape limit is 16,384 columns x 1,048,576 rows, so it does not *reject* the
files, but a 100 MB CSV with 20-23 million cells is beyond what it can hold comfortably: it parses for
minutes and then runs out of memory on a normal laptop.

| file | rows | columns | cells | size | Google Sheets | Excel |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `Most-Recent-Cohorts-Institution.csv` | 6,273 | 3,308 | **20,751,084** | 95.5 MB | refused (>10M cells) | opens, but very slow |
| `Most-Recent-Cohorts-Field-of-Study.csv` | 227,980 | 178 | **40,580,440** | 146.4 MB | refused (>10M cells and >100 MB) | opens, but hangs in practice |
| `MERGED1996_97_PP.csv` ... `MERGED2025_26_PP.csv` (30 files) | ~6,300-7,500 | 3,308 | ~20-23 M each | 60-100 MB each | refused (>10M cells) | opens, but very slow |
| `College_Scorecard_Raw_Data_06102026.zip` | - | - | - | 447.8 MB | n/a | n/a |

Cell budget: with 6,273 rows you may keep **at most ~1,594 columns** and still fit inside the Sheets
limit (use ~800 for a sheet that stays responsive); a 228,000-row program file only takes **~43 columns**.
See `reports/size_limits_check.csv` / `.md` and `reports/column_budget_vs_cell_limits.csv`.

Two extra reasons the raw files feel broken even when they do load:

1. missing values are written as the **text** `NA` (and `PS` / `PrivacySuppressed` for suppressed
   cells), so Excel treats whole numeric columns as text - no sorting, no charts, no pivot maths;
2. thousands of the 3,308 columns are empty for a given year (see finding 3 below).

> The 447.8 MB `College_Scorecard_Raw_Data_06102026.zip` is a second download of the folder that is
> already extracted in `data/College_Scorecard_Raw_Data_06032026/` - it is redundant and can be deleted.

---

## 2. What is in this folder

```
EDA/
  README.md                      this page
  scripts/
    00_common.R                  paths, spreadsheet limits, NA/PS handling, codebook, variable groups
    01_size_limits_check.R       measures every raw file against the real Excel/Sheets limits
    02_build_simplified_data.R   builds the five small, typed, decoded extracts
    03_eda_quality_report.R      missingness audit, quality scores, figures, written summary
  simplified/                    <- the files to open in Excel / Google Sheets (git-ignored)
    institution_core_latest.csv      6,273 x 143   (5.9 MB)
    institution_core_latest.xlsx     6,273 x 143   (3.7 MB, numbers typed)
    panel_core_1996_2025.csv       208,759 x 26    (27 MB, one row per institution per source file)
    field_of_study_core_latest.csv 227,980 x 23    (42 MB, full program detail)
    field_of_study_by_cip2_latest.csv  375 x 12    (0.03 MB, CIP family x credential summary)
  reports/                       all CSV tables + EDA_SUMMARY.md + simplified_codebook.csv
  figures/                       4 PNG figures
```

### How to run it

Prerequisite: the raw files must be in `data/College_Scorecard_Raw_Data_06032026/` (3.7 GB, not
versioned - see the repo-root `README.md` for the download steps). `data/CollegeScorecardDataDictionary.xlsx`
does ship with the repo, and `load_dictionary()` will stop with a clear message if it is missing.

```bash
cd "/Users/gerryjr/Desktop/Group Project 1/Group Project 1"
Rscript EDA/scripts/01_size_limits_check.R      # ~10 s
Rscript EDA/scripts/02_build_simplified_data.R  # ~15 s
Rscript EDA/scripts/03_eda_quality_report.R     # ~60 s
```

Requires only packages that are already installed: `data.table`, `ggplot2`, `scales`, `readxl`,
`writexl`. In RStudio, set `Sys.setenv(SC_PROJECT_ROOT = "<path to Group Project 1>")` before sourcing
a script (they otherwise derive the project root from the `Rscript --file=` argument).

---

## 3. Which simplified file should you open?

| question | file | shape |
| --- | --- | --- |
| One row per college, latest data, everything decoded | `simplified/institution_core_latest.xlsx` (or `.csv`) | 6,273 x 143 |
| Trends over time (tuition, enrolment, completion, earnings) | `simplified/panel_core_1996_2025.csv` | 208,759 rows; filter `year_start` |
| What do graduates of program X earn / owe? | `simplified/field_of_study_core_latest.csv` | 227,980 x 23 |
| Same, but small enough to read at a glance | `simplified/field_of_study_by_cip2_latest.csv` | 375 x 12 |
| What does a column name mean? | `reports/simplified_codebook.csv` | 164 rows |

All five open in Google Sheets (File > Import > Upload) and in Excel (double-click; the `.xlsx` needs
no import step). Missing values are **blank cells**, not the text `NA`, and the numeric columns are
true numbers.

---

## 4. What the simplification did (and why the numbers are trustworthy)

* **Only the columns that are used are read** (`data.table::fread(select=)`), so peak memory stays in
the tens of MB even for the 150 MB program file.
* **Encodings are collapsed deliberately:** `NA` (not collected / not applicable), `PS` /
  `PrivacySuppressed` (cell count too small to publish) and blank all become real missing values.
  The privacy signal is *not* discarded: `n_headline_privacy_suppressed` records how many of the ten
  headline metrics were withheld for that institution.
* **Types are repaired:** any column whose values all parse as numbers is stored as numeric.
  `ZIP`, `OPEID6` and `ST_FIPS` are deliberately kept as text so leading zeros survive.
* **Codes are decoded from the official codebook** (`data/CollegeScorecardDataDictionary.xlsx`), not
  hard-coded: `CONTROL`, `ICLEVEL`, `REGION`, `LOCALE`, `PREDDEG`, `HIGHDEG`, `CCBASIC`. Note that the
  codebook stores one block of rows per variable and only writes the variable name on the first row of
  each block, so `00_common.R` forward-fills it before decoding.
* **Recodes built for the project** (all documented in `reports/simplified_codebook.csv`):
  * `net_price` = `NPT4_PUB` coalesced with `NPT4_PRIV` (the two are sector-specific, so neither alone
    covers the population); likewise `net_price_lowinc` / `net_price_highinc` from `NPT41_*` / `NPT45_*`;
  * `grad_rate` = `C150_4` coalesced with `C150_L4`, with `grad_rate_basis` recording which cohort it is;
  * `minority_serving` = one label collapsed from the seven HBCU/PBI/TRIBAL/HSI/ANNHI/AANAPII/NANTI flags;
  * `size_bin`, `selectivity_bin`, `dq_tier` = categorical buckets;
  * `tuition_in_out_gap`, `net_price_income_gap`, `sticker_to_net`, `grad_debt_to_earn` = ratios;
  * `net_price_pctile_group`, `grad_rate_pctile_group`, `earn_p10_pctile_group` = percentile ranks
    **within CONTROL x ICLEVEL peer groups** (normalising between categories), and
    `value_index_grad` / `value_index_earn` = outcome percentile minus price percentile;
  * `n_headline_missing`, `pct_headline_complete`, `n_headline_privacy_suppressed`, `dq_tier` =
    per-institution data-quality columns.
* **CIP families** (`cip2`, `cip2_label`) are derived from the 4-digit `CIPCODE` for the program file.

---

## 5. Headline findings (full detail and tables in `reports/EDA_SUMMARY.md`)

1. **Missingness is structural, not random.** Of the 3,308 variables in the latest institution file,
   **201 are completely empty**, 100 more are >99% empty, and only **26 are essentially complete**
   (<=1% missing).
2. **Privacy suppression is a programme-level problem.** In the Field-of-Study file, the worst columns
   are hidden in **up to 90.6%** of rows (`EARN_COUNT_HIGH_CRED_1YR`, the `DEBT_*_PP_EVAL_MDN` debt
   columns). Small programmes simply have no published earnings.
3. **Even the headline metrics are thin.** Completeness across 6,273 institutions:
   `UGDS` 87%, `PCTPELL`/`PCTFLOAN` 87%, `earn_p10` 82%, `grad_rate` 82%, `net_price` 80%,
   `grad_debt_mdn` 76% (19.6% of it withheld as `PS`), `TUITIONFEE_IN` 58%, `RET_FT4` 33%,
   `ADM_RATE` 30%.
4. **Data quality is unevenly distributed.** Public 4-year institutions average ~87% completeness,
   private for-profit less-than-2-year institutions ~60%, and completeness correlates with enrolment
   size - so any analysis of the headline metrics quietly over-represents large public 4-year schools.
5. **Missing values cluster.** `PCTPELL` and `PCTFLOAN` are missing for exactly the same institutions
   (Jaccard 1.00), `ADM_RATE` and `RET_FT4` co-miss for 63% of institutions, and `net_price`/`grad_rate`
   co-miss far more often than independence would predict. Dropping rows listwise therefore removes
   whole *types* of school, not a random sample.
6. **Year coverage is very different per variable.** 44 of the 113 core variables never reach 80%
   coverage in any year; `UGDS` is available from 1996, `PCTPELL` from 2008, `CDR3` from 2011,
   earnings measures only in recent cohorts. The 113 x 31 matrix is in
   `reports/core_variable_coverage_matrix.csv`.
7. **A few logical oddities** are documented in `reports/data_anomalies_latest.csv` (12 institutions
   with a negative net price, 11 with zero undergraduates, etc.).

Figures: `figures/missingness_core_latest.png`, `coverage_by_year.png`,
`row_completeness_by_sector.png`, `earnings_vs_netprice.png`.

---

## 6. Caveats before you write the report

* `NA` and `PS` are not the same thing. `NA` = not collected / not applicable; `PS` = collected but
  withheld because the group was too small. Treating both as "missing" is fine for modelling but is
  worth a sentence in the write-up.
* `MERGED####_##_PP.csv` names the **source file year**, not the outcome year: many measures are
  3-, 6-, 8- or 10-year lagged cohorts (e.g. `MD_EARN_WNE_P10`). Do not read `year_start` as the
  graduation year of the outcomes in that row.
* The panel is one row per institution **per source file**, so an institution present in all 30 files
  appears 30 times. It is not deduplicated, and `UNITID` is the only reliable join key.
* `simplified/field_of_study_core_latest.csv` keeps the 7,020 program rows whose `UNITID` is the
  literal **text** `NA` (778 institutions - mostly foreign and closed schools, e.g. `Aarhus
  University`, plus a few US schools such as `Judson College`). Scorecard publishes their programs
  but no institution-level ID, so they can never be joined to the institution file; filter on the
  `has_unitid` flag before joining or aggregating.
* `EDA/simplified/` is git-ignored (see the repo-root `.gitignore`, which also excludes all of
  `data/` except the 712 KB codebook). Regenerate the extracts with
  `Rscript EDA/scripts/02_build_simplified_data.R` instead of committing 42 MB CSVs; `reports/`
  and `figures/` stay tracked because they are small and partners need them as-is.
