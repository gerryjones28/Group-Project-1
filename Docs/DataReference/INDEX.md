# College Scorecard - Data Reference Pack

*Generated 20 September 2026. The original project files were not modified.*

## Start here

**[`CollegeScorecard_Data_Structure.pdf`](CollegeScorecard_Data_Structure.pdf)** - read this first. It explains in plain English what the dataset is, how variables are named, where time lives, what a missing cell means, and a concrete first EDA session.

## Everything in this folder

| File | What it is | Size |
|---|---|---|
| `CollegeScorecard_Data_Structure.pdf` | The explainer. Read first. | 337 KB |
| `CollegeScorecard_Data_Structure.html` | HTML source of the PDF (open in a browser to read without Acrobat). | 28 KB |
| `reference/00_readme_and_key_tabs.md` | The workbook's own README and all eight tabs, reorganised and joined up. | 12 KB |
| `reference/01_glossary.csv` | The Glossary tab as tidy CSV (AY, CY, DCY, FY, NSLDS, IPEDS, CIP...). | 3 KB |
| `reference/02_changelog.csv` | The ChangeLog tab as tidy CSV, dates filled down. | 14 KB |
| `reference/03_institution_variables.csv` | The master table: 3,308 institution variables, both naming systems, type, source, notes. | 940 KB |
| `reference/04_institution_variables_by_category.md` | The same variables grouped by category, with each coded variable's lookup table rendered inline. | 656 KB |
| `reference/05_value_labels.csv` | 277 value/label pairs for every coded variable. | 34 KB |
| `reference/06_cohort_coverage.csv` | 3,308 rows: years of data per variable, plus which cohort each year actually measures. | 3,744 KB |
| `reference/07_field_of_study_variables.csv` | 178 field-of-study variables. These are keys INSIDE the `latest.programs.cip_4_digit[]` array element, not flat API fields - the file gives the array name and the nested key separately. | 59 KB |
| `reference/07b_field_of_study_value_labels.csv` | 14 field-of-study value/label pairs. | 1 KB |
| `reference/08_api_field_paths.txt` | Copy/paste-ready API field paths grouped by category, with the raw column name and meaning under each. | 862 KB |
| `reference/09_api_path_validation.csv` | Live-API check of every generated field path (present/absent per sampled school). | 394 KB |

## Regenerating

```bash
python scripts/build_data_reference.py              # rebuild everything
python scripts/build_data_reference.py --skip-api   # offline, no API calls
python scripts/build_data_reference.py --no-pdf     # skip PDF rendering
```

The script only ever *reads* `data/CollegeScorecardDataDictionary.xlsx`.

## The one-paragraph mental model

The Scorecard is two datasets. **Institution-level** is one row per college per year, about 6,300 rows and 3,000+ columns; **field-of-study-level** is one row per college x CIP programme per year, and only starts in 2014-15. In the API a column is addressed by a dotted path with a time prefix, `<year-or-latest>.<category>.<sub-topic>.<metric>`, across 10 categories. In the raw CSV files the same column is a shouty abbreviation. The dictionary workbook gives you both names, plus the year coverage for each variable and the decodings for coded columns. Use `reference/03_institution_variables.csv` as the translation table and `reference/06_cohort_coverage.csv` as the feasibility check before you promise a time series to your group.

**One shape difference worth repeating:** the institution variables are flat API fields, but the field-of-study variables are keys inside a single nested array per institution (`latest.programs.cip_4_digit[]`). You unnest that array rather than selecting from it, and doing so changes your unit of analysis from institution to institution x program. `reference/07_field_of_study_variables.csv` gives the array name and the nested key as separate columns.
