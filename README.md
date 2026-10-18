# Group Project I - The College Scorecard Dataset

**October 18, 2026 audit:** Start with [AUDIT_REPORT](Docs/AUDIT_REPORT.md),
[student explanation](Docs/STUDENT_EXPLANATION.md), and the [nine-slide presentation](presentation/SLIDE_OUTLINE.md).
Raw files and extracts are absent locally. Corrected R code passed isolated synthetic checks;
real-data reproduction remains blocked. Existing generated reports/figures are legacy artifacts,
with known stale counts documented in [RESULTS_SUMMARY](presentation/RESULTS_SUMMARY.md).
The new presentation/work division supersedes the older guide's twelve-slide plan.

Shared repo for **code, EDA results and documentation**. The datasets are
deliberately **not** in this repo - see [Getting the data](#getting-the-data).

## What is in here

| path | contents | versioned? |
| --- | --- | --- |
| `EDA/scripts/` | the five R scripts: shared helpers, size check, extract builder, quality audit, **and `04_streams.R` - the Goal-4 analysis** | yes |
| `EDA/reports/` | EDA tables + `EDA_SUMMARY.md` (the written-up findings) | yes |
| `EDA/figures/` | 4 legacy quality PNG figures; stream figures regenerate with data | yes |
| `EDA/README.md` | full write-up: why the raw files won't open, what was built, caveats | yes |
| `EDA/simplified/` | the small extracts you can actually open in Excel / Sheets | **no** - regenerate |
| `data/CollegeScorecardDataDictionary.xlsx` | official 712 KB variable codebook | yes |
| `data/College_Scorecard_Raw_Data_*` | raw downloads, 60-150 MB per file, 3.7 GB total | **no** - ignored |
| `Docs/ASSIGNMENT_GUIDE.md` | earlier assignment guide; audit report and nine-slide presentation supersede its status/plan | yes |
| `EDA/reports/STREAM_PLAN.md` | one-page stream plan to paste into the group chat | yes |
| `Docs/`, `scripts/` | API walkthrough, assignment brief, API test script | yes |

## Why the raw data is not on GitHub

The Scorecard is shipped as one very wide CSV per year: **3,308 variables**, and
the most-recent snapshots alone are 95 MB (20.8 M cells) and 146 MB (40.6 M
cells). GitHub warns above 50 MB and **rejects pushes over 100 MB**, so a single
accidental `git add` of `data/` would fail the push - or, worse, permanently
bloat everyone's clone.

`.gitignore` therefore ignores `/data/*` (with one small exception, the
codebook) and `/EDA/simplified/`. The rule of thumb for this repo:

> **git is for code and small stats. Datasets go on the group drive.**

To send a big file to a teammate, use the shared drive / a Drive link - never
`git add -f`.

## Getting the data

One-time setup, ~4 GB of downloads:

1. Go to <https://collegescorecard.ed.gov/data/> and download the bulk data:
   the **"Most Recent Cohorts"** files and the **full archive** of yearly files.
2. Extract them so the layout matches what the scripts expect:

   ```
   data/College_Scorecard_Raw_Data_06032026/
       MERGED1996_97_PP.csv ... MERGED2025_26_PP.csv      (30 yearly files)
       FieldOfStudyData1415_1516_PP.csv ...               (8 program files)
       Most-Recent-Cohorts-Institution.csv
       Most-Recent-Cohorts-Field-of-Study.csv
   ```

3. `data/CollegeScorecardDataDictionary.xlsx` ships with the repo, so it should
   already be there.

The `data/College_Scorecard_Raw_Data_06102026.zip` (448 MB) in the local folder
is a duplicate download of the same release and can be deleted.

## Running the pipeline

```bash
Rscript EDA/scripts/01_size_limits_check.R       # ~10 s  : what actually fits in Sheets/Excel
Rscript EDA/scripts/02_build_simplified_data.R   # ~15 s  : writes EDA/simplified/
Rscript EDA/scripts/03_eda_quality_report.R      # ~75 s  : audits, figures, EDA_SUMMARY.md
Rscript EDA/scripts/04_streams.R                 # Goal 4: the four streams (~30-60 s)
Rscript EDA/scripts/04_streams.R A               # or one stream only: A / B / C / D
```

On Windows, `Rscript` is often **not on PATH** even when R is installed. Use the full path:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R
```

Script 04 writes `EDA/reports/stream_*.csv` and `EDA/figures/stream_*.png`. It never overwrites a
raw file or any output of scripts 01-03. See `Docs/ASSIGNMENT_GUIDE.md` for what each stream asks
and who owns it.

Requires `data.table`, `ggplot2`, `scales`, `readxl`, `writexl`. Scripts 02 and
03 create `EDA/simplified/`, `EDA/reports/` and `EDA/figures/` if missing, so a
fresh clone only needs the raw data in place. Start with `EDA/README.md` for the
finding-by-finding write-up.
