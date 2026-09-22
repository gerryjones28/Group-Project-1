# The Data Dictionary Workbook, Explained

Source file: `data/CollegeScorecardDataDictionary.xlsx` (**not modified** by this pack).

This document reorganises the workbook so you can find things without scrolling through 12,381 spreadsheet rows.

## 1. The workbook README

**COLLEGE SCORECARD**

*Released June 10, 2026*

#### Background on the data

Attached is the descriptions for each data element provided in College Scorecard, including . Please note that datafiles available in the “All Data Files” provide more data elements and represent a larger universe of institutions than what is presented in the Scorecard consumer page here: collegescorecard.ed.gov. For more information on College Scorecard data, goto https://collegescorecard.ed.gov/data/documentation/

#### Key Tabs

ChangeLog - describes major changes that have been made to the Data Dictionary.

Glossary - provides definitions for terms and acronyms used in this file.

Institution_Data_Dictionary - describes each data element in the institution-level files.

Institution_Cohort_Map - describes which years of data are described for each variable in each institution-level datafiles.

Most_Recent_Inst_Cohort_Map - descrbes which years of data are described for each variable in the "most recent" institution-level data file.

FieldOfStudy_Data_Dictionary - provides descriptions of each data element in the field-of-study-level data files.

FieldOfStudy_Cohort_Map - provides descriptions of which years of data are covered for each variable in the field-of-study-level data files.

#### Important Data Quality Notes

#### Data documentation report links:

<https://collegescorecard.ed.gov/assets/InstitutionDataDocumentation.pdf>

<https://collegescorecard.ed.gov/assets/FieldOfStudyDataDocumentation.pdf>

#### Contacts

For questions, please contact

The College Scorecard Help Desk

`scorecarddata@rti.org`

Office of the Chief Data Officer

> Note: the workbook is a snapshot. The `Released` date above is the release of the dictionary file, not of the underlying datafiles.

> The workbook's README contains one truncated sentence ("Attached is the descriptions for each data element provided in College Scorecard, including .") and one empty section ("Important Data Quality Notes"). That is how it ships - it is not a transcription error in this pack.

## 2. What is in each tab

| Tab | Rows x Cols | What it is | Why you care |
|---|---|---|---|
| `README` | 28 x 1 | Orientation text plus links to the two long-form PDF documentation reports. | Start here once; then never open it again. |
| `ChangeLog` | 140 x 7 | Dated list of every change ever made to the dictionary. | Tells you when a variable was added, renamed or re-typed - critical before you trust a time series. |
| `Glossary` | 17 x 3 | Definitions of the abbreviations used in the cohort map (AY, CY, DCY, FY, NSLDS, IPEDS ...). | Without this the cohort map is unreadable. |
| `Institution_Data_Dictionary` | 3,587 x 14 | 1 row per institution variable, plus extra rows that SPELL OUT the codes for encoded variables. | The master list. This is what `03_` and `04_` in `reference/` flatten for you. |
| `Institution_Cohort_Map` | 3,309 x 31 | Variable x 30 annual datafiles; each cell says which year/cohort that variable describes in that file. | Answers "can I even do a time series with this column?" |
| `Most_Recent_Inst_Cohort_Map` | 3,309 x 5 | Variable x 3: the cohort it describes in the single "most recent" datafile, and which merged file it came from. | Explains why `latest.*` fields are NOT all the same year. |
| `FieldOfStudy_Data_Dictionary` | 193 x 10 | 1 row per field-of-study (CIP code) variable. | Use when you want program-level, not school-level, data. |
| `FieldOfStudy_Cohort_Map` | 1,798 x 20 | Variable x 9 field-of-study datafiles. | Field-of-study data starts much later (2014-15) than institution data (1996-97). |

## 3. Which tabs join to which

The relationship is a strict one-to-many, keyed on the *raw* column name:

```
Institution_Data_Dictionary.VARIABLE NAME   (1 row per variable)
        |
        +--> Institution_Cohort_Map.Variable Name          (1 row per variable, 30 year cols)
        +--> Most_Recent_Inst_Cohort_Map.Variable Name      (1 row per variable, 1 description)
        +--> continuation rows in the dictionary itself      (N rows, the VALUE/LABEL codes)
```

Both cohort maps are keyed on the **raw CSV column name** (`ADM_RATE`), not on the dotted API path (`latest.admissions.admission_rate.overall`). `reference/03_institution_variables.csv` carries both, so use it as the join table.

## 4. Glossary (from the workbook)

| Term | Meaning | Notes |
|---|---|---|
| `Acad yr` | Academic Year; differs by institution, but generally the period from September to June (e.g., AcadYr 2013-14 = 9/1/2013 - 5/31/2014) | Referenced in the data cohort map |
| `AY` | Award Year (e.g. AY 2013-14 = 7/1/2013-6/30/2014) | Referenced in the data cohort map |
| `CY` | Calendar Year (e.g. CY 2014 = 1/1/14-12/31/14) | Referenced in the data cohort map |
| `DCY` | IPEDS Data Collection Year (e.g., DCY2013-14 = the 2013-14 IPEDS collection) | Referenced in the data cohort map |
| `FSA` | Federal Student Aid | In the data dictionary, an "FSA" value in the “Source” field indicates that the data element described is derived from the FSA Data Center (https://studentaid.ed.gov/sa/data-center) or FSA Postsecondary Education Participant System (https://www2.ed.gov/offices/OSFAP/PEPS/dataextracts.html) |
| `FY` | Fiscal Year (e.g. FY 2014= 10/1/13-9/30/14) | Referenced in the data cohort map |
| `IPEDS` | Integrated Postsecondary Education Data System | An "IPEDS" value in the "Source" field indicates that the data element described is derived from IPEDS (http://nces.ed.gov/ipeds/Home/UseTheData) or taken from the College Navigator (http://nces.ed.gov/collegenavigator/) |
| `NA` | Not available | Used in the *_Cohort_Map tabs of this document. Data for this metric are unavailable for all institutions in the indicated data file. |
| `NSLDS` | National Student Loan Data System | NSLDS is the U.S. Department of Education's central database for student aid, a value of “NSLDS” in the “Source” field of the data dictionary indicates that the data element described is derived from NSLDS |
| `OPE` | Office of Postsecondary Education | In the data dictionary, a value of "OPE" in the "Source" field indicates that the data element described is derived from the Department's Office of Postsecondary Education Eligibility Matrix (https://www2.ed.gov/about/offices/list/ope/idues/eligibility.html#tips. ) |
| `Treasury` | U. S. Department of Treasury | A value of "Treasury" in the "Source" field of the data dictionary indicates that the data element described was calculated by the Department of Treasury with data derived from NSLDS combined with data from IRS tax records or data from the U.S. Census Bureau |
| `ED` | U.S. Department of Education | In the data dictionary, a value of "ED" in the "Source" field indicates that the data element described is derived from http://sites.ed.gov/whhbcu/one-hundred-and-five-historically-black-colleges-and-universities/ |
| `PEPS` | FSA Postsecondary Education Participant System | Referenced in the data cohort map |
| `CIP` | Classification of Instructional Programs | Referenced in the data cohort map. |
| `DOL` | Department of Labor | In the data dictionary, a value of "DOL" in the "Source" field indicates that the data element described is derived from the Department of Labor Workforce Innovation and Opportunity Act approved training provider list. |
| `ACS` | Census American Community Survey | Referenced in the data cohort map |

## 5. ChangeLog - the entries that actually matter for a class project

The sheet has 106 entries. The 29 below are the ones that change how you code:

| Date | Tab | Change |
|---|---|---|
| May 6, 2024 | `Institution_Cohort_Map` | Updated entries with new values due to IPEDS, PEPS, and FSA data refresh and to replace NULL with NA; added entries for PCTPELL_DCS, PCTFLOAN_DCS, DCS_PELL_LOAN, PCTPELL_DCS_POOLED_SUPP, PCTFLOAN_DCS_POOLED_SUPP, DCS_... |
| May 6, 2024 | `FieldOfStudy_Cohort_Map` | Updated entries with new values due to PEPS data refresh and to replace NULL with NA |
| February 7, 2022 | `Institution_Data_Dictionary` | Added entries for MDCOST, MDCOMP, MDEARN, OM*_PELL_* metrics, BBRR*_FED_IND metrics, BBRR*_FED_DEP metrics, BBRR*_FED_PELL metrics, BBRR*_FED_NOPELL metrics, BBRR*_FED_MALE metrics, BBRR*_FED_NOMALE metrics, BBRR3* me... |
| February 7, 2022 | `FieldOfStudy_Data_Dictionary` | Added entries for BBRR3* metrics. Changed data type for BBRR2* metrics from 'float' to 'string'. |
| January 12, 2021 | `Institution_Data_Dictionary` | Added entries for DBRR* and BBRR* metrics, changed data type for PLUS_DEBT_INST_COMP_MDPAY10* and PLUS_DEBT_ALL_COMP_MDPAY10* from 'int' to 'float' |
| January 12, 2021 | `FieldOfStudy_Data_Dictionary` | Changed data type for DEBT_ALL_PP_ANY_MDN10YRPAY, DEBT_ALL_PP_EVAL_MDN10YRPAY, DEBT_ALL_STGP_ANY_MDN10YRPAY, and DEBT_ALL_STGP_EVAL_MDN10YRPAY from 'int' to 'float' |
| November 2020 | `FieldOfStudy_Data_Dictionary` | Replaced prior version with new version of tab |
| November 2020 | `FieldOfStudy_Cohort_Map` | Replaced prior version with new version of tab |
| November 2019 | `Data_Dictionary` | Renamed tab to institution_data_dictionary |
| November 2019 | `Cohort_Map` | Renamed tab to institution_cohort_map |
| November 2019 | `Most_Recent_Cohort_Map` | Renamed tab to most_recent_inst_cohort_map |
| November 2019 | `FieldOfStudy_Data_Dictionary` | Added tab |
| November 2019 | `FieldOfStudy_Cohort_Map` | Added tab |
| October 2018 | `Cohort_Map` | Corrected cohort year of earnings 7- and 9-years post-entry (*_P7, *_P9) |
| December 2017 | `Cohort_Map` | Corrected inflation adjustment period for earnings metrics prior to 2011-12 |
| September 2017 | `Cohort_Map` | Corrected entry for UGDS_MEN and UGDS_WOMEN to NULL for 2000-01 |
| June 2017 | `ChangeLog` | added tab |
| June 2017 | `Cohort_Map` | Corrected the entries for all cumulative debt-related metrics to reflect Fiscal Year instead of Award Year cohorts. |
| June 2017 | `Cohort_Map` | Corrected the entries for all 6- and 8-year earnings metrics to reflect cohorts established 1 year earlier than previously indicated. |
| June 2017 | `Cohort_Map` | Corrected entry for SCH_DEG to reflect AY2012-13 for all files. |
| January 2017 | `Data_Dictionary` | Corrected description of completion rates for less-than-4-year institutions to remove the reference to "6 years" |
| January 2017 | `Data_Dictionary` | Corrected developer-friendly name for repayment rate metrics to include "_rate" at the end |
| January 2017 | `Data_Dictionary` | Corrected developer-friendly name for INC_PCT_M2 to share_middleincome.48001_75000 |
| October 2016 | `Cohort_Map` | Corrected the entries for all repayment rate-related metrics to reflect Fiscal Year instead of Award Year cohorts. |
| October 2016 | `Cohort_Map` | Corrected entries related to CDR3 and CDR3_DEN by shifting 1 year earlier. |
| September 2016 | `README` | added tab |
| September 2016 | `Glossary` | added tab |
| September 2016 | `Cohort_Map` | added tab |
| September 2016 | `Most_Recent_Cohort_Map` | added tab |

Everything else in the sheet is `Updated entries with new values due to data refresh` style housekeeping. The complete list is in `reference/02_changelog.csv`.

## 6. Scale, in numbers

| Thing | Count |
|---|---|
| Institution-level variables | 3,308 |
| Field-of-study variables | 178 |
| Encoded variables with a value/label lookup | 277 label rows |
| Annual institution datafiles | 30 (1996-97 ... 2025-26) |
| Field-of-study datafiles | 9 (2014-15 ... most recent) |
| Institutions in the API | 6,273 (all) / 6,243 with `school.operating = 1` |
| API rate limit | 1,000 requests per hour per IP |
