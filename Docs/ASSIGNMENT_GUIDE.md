# Group Project I - The College Scorecard Dataset

> October 18, 2026: this earlier guide is retained for context. Its completion claims and
> twelve-slide plan are superseded by [AUDIT_REPORT.md](AUDIT_REPORT.md) and
> [the nine-slide presentation](../presentation/SLIDE_OUTLINE.md). Raw-data reproduction is
> blocked locally. Do not quote legacy counts without checking RESULTS_SUMMARY.md.
> Corrections: net price covers attendance costs, not tuition alone; tuition minus net price
> is not grant aid; the 1,225 anomaly count used the opposite predicate. Missing Pell must
> be excluded from quartile denominators. B3 is cross-sectional. C4 fixed-score ordering
> is mechanical. Missing IDs in later files do not establish closure. The saved coverage
> table records net-price observations through 2024, contradicting the narrow-window claim.

**The complete guide: what the assignment asks, what is already done, who does what, and how to
present it.**

Written for the three-person group. Every number in this document was read out of the repository
on 2026-09-20 (`EDA/reports/`, `EDA/figures/`, `Docs/`), not estimated.

> **Read this first if you are lost:** [Section 1](#1-what-the-assignment-actually-asks) explains
> the assignment in plain English. [Section 2](#2-the-trap-two-different-things-are-both-called-3)
> explains the naming mix-up that made the group think it was further behind than it is.

---

## Contents

| § | Section | Who should read it |
| --- | --- | --- |
| 1 | What the assignment actually asks | everyone |
| 2 | The trap: two different things are both called "3" | everyone, **first** |
| 3 | The dataset, in numbers | everyone |
| 4 | Prep 1 - getting the data into R | Gerry |
| 5 | Prep 2 - measuring data quality | Gerry |
| 6 | Prep 3 - the 30 recoded columns | Gerry |
| 7 | **Goal 4 = our four streams** | everyone, this is the work |
| 8 | Blockers and decisions | everyone, **day one** |
| 9 | Who does what | everyone |
| 10 | How to run everything | everyone |
| 11 | **Presentation kit** - 12 slides, speaker notes | everyone |
| 12 | Q&A prep - 14 likely questions | everyone |
| 13 | File map | reference |
| 14 | Honest status table | reference |

---

# 1. What the assignment actually asks

Ignore the policy language. The assignment is:

> **Here is a huge, messy, public dataset about US colleges. Get it into R, work out how
> trustworthy each part of it is, build the few columns you actually need, then answer a short
> list of questions with charts - and write it up.**

`Group Project I.pdf` calls these **Goals 1-4**. They are **four stages of one pipeline**, not
four separate essays.

| # | PDF wording | Plain English | Deliverable |
| --- | --- | --- | --- |
| **1** | "Read the data into a language-native format… properly treating NAs and other encoded variables" | Get it into R. It is 30 spreadsheets of 60-150 MB. Excel and Sheets both choke. Convert `NA` / `PS` / `PrivacySuppressed` / blank into real missing values. | Scripts + a note on which route was used |
| **2** | "Assess the quality… missing values… relationships in missingness… numeric quality scores" | Measure how good the data is. How much is missing? Does it go missing at random? Score each metric. | Missingness tables, quality scores, co-missingness |
| **3** | "Recode any variables of interest… combined categories… normalise between categories" | Build the columns you need. Turn `1` into "Public". Coalesce two grad-rate columns. Rank schools against *peers*. | The 30 derived columns |
| **4** | "Identify and display any relationships… use the recoded variables… **consider effects of data quality**… answer **a series of defined questions**" | Ask questions, show the answers, and account for the quality problems from Goal 2. | Findings + figures + write-up |

### The one thing to understand about how this is marked

**The four goals are a chain, not four boxes.** Goal 4 is explicitly marked on whether it *uses*
the recoded variables from Goal 3 and *considers* the data-quality findings from Goal 2. A report
that treats them as four disconnected sections loses marks even if each section is correct.

---

# 2. The trap: two different things are both called "3"

This is almost certainly why the group felt stuck.

| | What it is | Status |
| --- | --- | --- |
| **Prep 3** | PDF **Goal 3**: *"Recode any variables of interest"* - build the derived columns. | ✅ **Done**, committed |
| **Stream C** | The group's **Stream 3**: *"Student Outcomes & Value"* - one of four Goal-4 slices. | Gerry's |

When someone says *"Gerry did part 3,"* it sounds like the assignment's Goal 3 is handled - which
makes Goals 1 and 2 look unstarted, and makes it look like two people need to build them. **They
are already built.**

**Fix the vocabulary today:**

- **"Prep 1 / Prep 2 / Prep 3"** = the PDF's Goals 1, 2, 3. All done.
- **"Stream A / B / C / D"** = the four Goal-4 slices. This is the remaining work.

Also note the group's original four "separate things" are **not** four assignment sections. They
are the four sub-parts of Goal 4 - confirmed in section 7.

---

# 3. The dataset, in numbers

| Fact | Value |
| --- | --- |
| Institution-level variables | **3,308** |
| Institutions in the most-recent snapshot | **6,273** |
| Cells in that one file | **20,751,084** |
| File size | **95.5 MB** |
| Yearly files | **30**, 1996-97 → 2025-26 |
| Field-of-study file | 227,980 rows × 178 columns, **146.4 MB** |
| Google Sheets limit | 10,000,000 cells per spreadsheet |
| Excel limit | 1,048,576 rows × 16,384 columns |

### Why nobody can open it

- **Google Sheets refuses it.** 20.7 M cells against a 10 M cap. The field-of-study file also
  exceeds Drive's ~100 MB conversion limit.
- **Excel opens it, then dies.** It is inside the shape limits but 20 M cells is beyond what a
  normal laptop handles; it parses for minutes and then runs out of memory.
- **Even if it opened, it would look broken.** Missing values are the *text* `NA`, so entire
  numeric columns become text - no sorting, no charts, no pivot maths.

**The column budget this implies** (from `EDA/reports/column_budget_vs_cell_limits.csv`):

| Scenario | Max columns for Sheets | Comfortable |
| --- | ---: | ---: |
| 6,273 rows (all institutions) | 1,594 | 797 |
| 228,000 rows (program file) | 43 | 21 |
| 210,000 rows (30-year panel) | 47 | 23 |

That is why the project ships **five small extracts** instead of the raw files.

---

# 4. Prep 1 - getting the data into R

**Status: done, via the brief's option (a) - aggregating the yearly files in R.**

| Script | Size | What it does |
| --- | ---: | --- |
| `EDA/scripts/00_common.R` | 443 lines | Shared toolkit: paths, real spreadsheet limits, the `NA`/`PS` cleaning rules, codebook reader, the `CORE_*` variable groups |
| `EDA/scripts/01_size_limits_check.R` | 5.9 KB | Measures every raw file against the true Excel/Sheets limits |
| `EDA/scripts/02_build_simplified_data.R` | 18 KB | Builds the five clean extracts below |

### What it produced (`EDA/simplified/`, git-ignored - rebuild with script 02)

| Output | Shape | Purpose |
| --- | --- | --- |
| `institution_core_latest.csv` | 6,273 × 143 | **Cross-section used by Streams A, C, D** |
| `institution_core_latest.xlsx` | 6,273 × 143 | Same, typed so Excel sorts and charts |
| `panel_core_1996_2025.csv` | 208,759 × 26 | One row per institution per year - **Stream B** |
| `field_of_study_core_latest.csv` | 227,980 × 23 | Program-level detail |
| `field_of_study_by_cip2_latest.csv` | 375 × 12 | CIP family × credential summary |

**143 columns = 113 raw Scorecard variables + 30 derived columns.** That is **3.4% of the raw
3,308** - a caveat that belongs in the write-up, because every finding is about those 113
variables, not the whole dataset.

### The cleaning that satisfies "properly treating NAs and encoded variables"

- `NA`, `PS`, `PrivacySuppressed` and blank all become **real missing values**;
- anything that parses as a number is stored as a **number**;
- coded columns are decoded from the **official codebook**, not hard-coded.

### The one gap in Prep 1

The brief offers three routes in: (a) aggregate yearly files, (b) database interface, (c) the API.
Route **(a) is done thoroughly**. Route **(c) is started, not finished**:
`scripts/APIEndpointTest.R` is currently two lines.

Closing it is a small, bounded task (~2-3 h) and it buys a second, independent path to the same
numbers - the best possible answer to *"how do you know the data is right?"*
`Docs/DataReference/reference/08_api_field_paths.txt` and `09_api_path_validation.csv` already
support it (all 3,486 generated API paths were verified live).

---

# 5. Prep 2 - measuring data quality

**Status: done.** `EDA/scripts/03_eda_quality_report.R` (~75 s) writes 11 tables, 4 figures and
`EDA/reports/EDA_SUMMARY.md`.

## 5.1 Almost everything is missing

Of the **3,308 institution columns**:

| Tier | Columns |
| --- | ---: |
| 0-1% missing ("essentially complete") | **26** |
| 1-25% missing | 539 |
| 25-75% missing | 1,802 |
| 75-99% missing | 640 |
| (almost) empty | 301 |

**201 columns are completely empty.** 301 are >99% empty. Only 26 are usable as-is.

## 5.2 Numeric quality scores (`headline_metric_quality_scores.csv`)

`quality_score = 100 × (share of institutions with a value) × (1 − share withheld as PS)`

| Metric | % complete | % privacy-suppressed | **Quality** | Flag |
| --- | ---: | ---: | ---: | --- |
| `UGDS` (enrolment) | 87.3 | 0.0 | **87.3** | thin |
| `PCTPELL` | 86.8 | 0.0 | **86.8** | thin |
| `PCTFLOAN` | 86.8 | 0.0 | **86.8** | thin |
| `earn_p10` | 81.7 | 0.0 | **81.7** | thin |
| `grad_rate` | 81.5 | 0.0 | **81.5** | thin |
| `net_price` | 80.3 | 0.0 | **80.3** | thin |
| `grad_debt_mdn` | 76.2 | **19.6** | **61.2** | thin |
| `TUITIONFEE_IN` | 57.6 | 0.0 | **57.6** | thin |
| `RET_FT4` | 32.8 | 0.0 | **32.8** | unusable |
| `ADM_RATE` | 30.4 | 0.0 | **30.4** | unusable |

Two headline metrics are effectively unusable at institution level. Note `grad_debt_mdn`: it looks
76% complete but **19.6% of it is withheld on purpose**, which knocks its score down to 61.2.

## 5.3 Quality is distributed unevenly - and it tracks money

`row_completeness_by_group.csv`:

| Sector | Level | Institutions | Mean % complete | % high-DQ | Mean privacy-suppressed |
| --- | --- | ---: | ---: | ---: | ---: |
| Public | 4-year | 917 | **87.1** | 57.5 | 0.05 |
| Private nonprofit | 4-year | 1,705 | 74.4 | 54.0 | 0.23 |
| Public | 2-year | 891 | 72.4 | 0.0 | 0.25 |
| Private nonprofit | 2-year | 134 | 66.3 | 0.0 | 0.30 |
| Private for-profit | 2-year | 526 | 64.9 | 0.0 | 0.06 |
| Private for-profit | 4-year | 388 | 62.5 | 10.8 | 0.11 |
| Private for-profit | Less-than-2-year | 1,411 | 60.0 | 0.0 | 0.20 |
| Public | Less-than-2-year | 239 | 57.0 | 0.0 | **0.62** |
| Private nonprofit | Less-than-2-year | 62 | **54.0** | 0.0 | 0.40 |

**Completeness rises with size** (`completeness_vs_size.csv`):

| Size band | Institutions | Mean % complete |
| --- | ---: | ---: |
| Under 1,000 | 3,295 | 70.7 |
| 1,000-4,999 | 1,432 | 88.9 |
| 5,000-19,999 | 618 | 89.9 |
| 20,000 or more | 133 | **95.0** |
| Not reported | 795 | **14.7** |

Correlation with log₁₀(undergraduate enrolment) = **0.64**.

**Only 23.7% of institutions have all ten headline metrics populated** (30.1% have at least nine).
Any analysis on the headline metrics silently over-represents large public 4-year schools.

## 5.4 Missingness clusters - it is not random

`missingness_cooccurrence_latest.csv` (Jaccard = both missing ÷ either missing):

| Metric pair | Both missing | % of institutions | Jaccard | Expected if independent |
| --- | ---: | ---: | ---: | ---: |
| `PCTPELL` ↔ `PCTFLOAN` | 828 | 13.2 | **1.00** | 109.3 |
| `UGDS` ↔ `PCTPELL` | 795 | 12.7 | 0.96 | 104.9 |
| `ADM_RATE` ↔ `RET_FT4` | 3,967 | 63.2 | 0.86 | 2,931.6 |
| `net_price` ↔ `grad_rate` | 1,031 | 16.4 | 0.755 | 228.7 |
| `PCTPELL` ↔ `grad_rate` | 821 | 13.1 | 0.704 | 153.0 |

**Jaccard 1.00 means `PCTPELL` and `PCTFLOAN` are missing for exactly the same 828 institutions.**
They are not two independent variables. The `ADM_RATE`/`RET_FT4` pair co-misses for 63.2% of
institutions - 3,967, against the ~2,932 that independence would predict.

Consequence: **dropping rows listwise does not remove a random sample. It removes whole types of
school.**

## 5.5 A few genuine errors, and one thing that only looks like an error

`data_anomalies_latest.csv`:

| Check | Institutions | % |
| --- | ---: | ---: |
| Net price below zero | 12 | 0.19 |
| Zero undergraduate enrolment (`UGDS == 0`) | 11 | 0.18 |
| Graduation rate above 1 | 0 | 0.00 |
| Retention rate above 1 | 0 | 0.00 |
| **Net price above sticker tuition** | **1,225** | **19.53** |

That last row is **not a bug**. It happens legitimately when grants exceed tuition. Only the 12
negative net prices and the 11 zero-enrolment rows are real errors (~0.2% each).

---

# 6. Prep 3 - the 30 recoded columns

**Status: done.** These are the columns Goal 4 must "use". They live in
`institution_core_latest.csv` (the `derived = TRUE` rows of `simplified_codebook.csv`).

| Group | Columns | What it does |
| --- | --- | --- |
| **Label decodes** (7) | `control_label`, `level_label`, `carnegie_label`, `preddeg_label`, `highest_degree_label`, `region_label`, `locale_label` | Turns codes into words: `CONTROL = 1` → "Public" |
| **Buckets** (3) | `size_bin`, `selectivity_bin`, `dq_tier` | Grouping columns for tables and facets |
| **Combined categories** (6) | `net_price` (`NPT4_PUB`+`NPT4_PRIV`), `grad_rate` (`C150_4`+`C150_L4`), `earn_p10`, `grad_debt_mdn`, `minority_serving` (7 flags), `grad_rate_basis` | "Create combined categories from several columns" - the brief's Goal 3a |
| **Peer-group percentiles** (3) | `earn_p10_pctile_group`, `grad_rate_pctile_group`, `net_price_pctile_group` | Percentile **within `CONTROL × ICLEVEL`** - "normalise data between categories" (Goal 3c) |
| **Value indices** (2) | `value_index_earn`, `value_index_grad` | Earnings percentile − price percentile. High = expensive relative to outcomes |
| **Ratios / gaps** (5) | `sticker_to_net`, `net_price_income_gap`, `tuition_in_out_gap`, `grad_debt_to_earn`, `net_price_lowinc` / `highinc` | Relative rather than absolute comparisons |
| **Quality counters** (3) | `n_headline_missing`, `n_headline_privacy_suppressed`, `pct_headline_complete` | Carries Goal 2 forward into every Goal 4 table |

> **The one technical fact everyone on the team must know.** `value_index_earn` is
> `earn_p10_pctile_group − net_price_pctile_group`, and *both* percentiles are computed **within
> `CONTROL` × `ICLEVEL` peer groups**. So the **mean value index in every sector is ≈ 0 by
> construction**. If someone writes "compare the average value index of public vs private
> schools," they will get zero versus zero and conclude the data is broken. It isn't - that is how
> the ruler is built. Compare raw `earn_p10 / net_price`, or within-group spread.

---

# 7. Goal 4 = our four streams (this is the work)

## 7.1 Confirmed: the four "separate things" are all inside Goal 4

`Group Project I.pdf` says:

> **4. Identify and display any relationships of interest.**
> a. Ideally, these will use some of the recoded variables above, **consider effects of data
> quality**, and answer **a series of defined questions**.
> b. Outcomes might cover **access, affordability, student outcomes, or other categories**.

Three named categories plus a catch-all. The streams map onto it exactly:

| Our stream | PDF wording | Axis |
| --- | --- | --- |
| **A** - who is enrolled, and where | "**access**" | cross-section |
| **B** - affordability | "**affordability**" | time |
| **C** - student outcomes & value | "**student outcomes**" | value ranking |
| **D** - data quality | "**consider effects of data quality**" (4a) + "other categories" | reported vs reality |

So the four streams are **not** four assignment sections. They are the four sub-parts of **Goal 4**,
and Preps 1-3 are the prep work underneath them. That is why the group's earlier split felt wrong.

## 7.2 The three rules that apply to every stream

1. **Every table shows `n`.** Not just the percentage - the count of institutions that had the
   data. `ADM_RATE` is 30.4% complete; a selectivity statement is about ~1,910 schools, not 6,273.
2. **Every finding gets a data-quality sentence.** Goal 4a marks you on "consider effects of data
   quality". One sentence per finding is enough.
3. **Never write "all colleges."** The universe is 6,273 reporting institutions, and only 23.7%
   have all ten headline metrics.

## 7.3 Stream A - Access: who is enrolled, and where?

**Owner: ____________  |  Status: PENDING (needs the extract)  |  Script block: `A`**

| # | Question | Columns | Output |
| --- | --- | --- | --- |
| A1 | Where are minority-serving institutions concentrated, by sector / region / locale? | `minority_serving`, `HBCU`, `PBI`, `TRIBAL`, `HSI`, `ANNHI`, `AANAPII`, `NANTI`, `control_label`, `region_label`, `locale_label` | `stream_a1_*.csv`, `stream_a1_msi_by_sector.png` |
| A2 | Does enrolment composition differ by sector and selectivity? | `UGDS_WHITE/BLACK/HISP/ASIAN/AIAN/NHPI/2MOR/NRA/UNKN`, `UGDS_MEN/WOMEN`, `UG25ABV`, `selectivity_bin` | `stream_a2_*.csv` |
| A3 | Is Pell / low-income access concentrated in particular sectors? | `PCTPELL`, `INC_PCT_LO`, `MD_FAMINC`, `control_label`, `level_label` | `stream_a3_*.csv`, `stream_a3_pell_by_sector_level.png` |

**Method:** grouping and averaging (`mean()` / `.N` by group). No modelling needed. This is the
lightest stream and the easiest place to start.

**Data-quality caveat to carry:** `ADM_RATE` is only 30.4% complete, so `selectivity_bin` puts
~4,363 institutions in "Not reported". Any selectivity claim is about the schools that publish an
admission rate - which are disproportionately large and public.

**Likely finding:** minority-serving status and Pell share cluster in specific sectors and
locales, not uniformly across regions. Confirm with A1/A3 before asserting it.

## 7.4 Stream B - Affordability: did price move, and who paid more?

**Owner: ____________  |  Status: PENDING (needs the extract)  |  Script block: `B`**

| # | Question | Columns | Output |
| --- | --- | --- | --- |
| B1 | How did net price move 2009→2016, by sector and level? | `net_price`, `TUITIONFEE_IN`, `TUITIONFEE_OUT`, `COSTT4_A`, `PCTPELL`, `PCTFLOAN`, `MD_FAMINC` (panel) | `stream_b1_*.csv`, `stream_b1_net_price_trend.png` |
| B2 | Did the sticker ↔ net gap widen? | `sticker_to_net`, `tuition_in_out_gap`, plus `TUITIONFEE_IN − net_price` (panel) | `stream_b2_*.csv`, `stream_b2_sticker_net_gap.png` |
| B3 | Is the low-income vs high-income net-price gap narrowing or widening? | `net_price_lowinc`, `net_price_highinc`, `net_price_income_gap`, `INC_PCT_LO/M1/M2/H1/H2` (cross-section) | `stream_b3_*.csv`, `stream_b3_income_band_gap.png` |

**Why 2009-2016:** it is the only window where the cost variables overlap across the yearly files.
State that explicitly rather than implying the whole 30-year history is available.

**The limitation you must state out loud:** `net_price_lowinc` and `net_price_highinc` exist **only
in the cross-section**. So B3 is a **latest-year** statement, not a trend - unless someone adds
`NPT41_PUB/PRIV` and `NPT45_PUB/PRIV` to the panel column list in `02_build_simplified_data.R`
and rebuilds (~15 s). **Decide this on day one** (see §8).

**Data-quality caveat to carry:** the panel loses institutions every year (§7.6), so a rising
average net price could partly be a *changing mix* of schools rather than rising prices. Print `n`
next to every mean and say so.

## 7.5 Stream C - Outcomes & Value: which schools are "best value"?

**Owner: Gerry  |  Status: instruments built, findings PENDING  |  Script block: `C`**

The brief's own opening line says the data "can be summarized to highlight schools providing the
**best value** in education." That is why this stream is the natural spine.

| # | Question | Columns | Output |
| --- | --- | --- | --- |
| C1 | Which institutions are best value on `value_index_earn`? | `value_index_earn`, `net_price`, `earn_p10`, `control_label`, `level_label` | `stream_c1a_value_top25.csv`, `stream_c1b_value_bottom25.csv`, `stream_c1_value_top25.png` |
| C2 | Does the answer flip on `value_index_grad`? | `value_index_grad`, `grad_rate` | `stream_c2_index_agreement.csv` |
| C3 | Do completion and earnings agree, or rank schools differently? | `grad_rate`, `earn_p10`, `C200_4`, `RET_FT4`, `grad_debt_to_earn` | `stream_c3_completion_vs_earnings.csv` |
| C4 | **Does the ranking survive if you keep only well-reported schools?** | `pct_headline_complete`, `dq_tier` | `stream_c4_dq_sensitivity.csv`, `stream_c4_rank_stability.png` |

**C4 is the question that earns the most marks.** Goal 4a explicitly asks you to "consider effects
of data quality". Re-ranking on the 23.7% of institutions with all ten headline metrics and
reporting the rank correlation + the top-50 overlap is a direct, quantified answer. If the ranking
holds, that is a robustness result. If it collapses, *that* is the finding.

> **The trap, repeated because it will bite someone:** the mean of `value_index_earn` per sector is
> **≈ 0 by construction** (both percentiles are within `CONTROL` × `ICLEVEL`). Never compare sector
> means of the index. Compare raw `earn_p10 / net_price`, or within-group dispersion.

**Note on Gerry's status:** the repo contains the *instruments* (the two value indices, the three
percentile groups) plus one exploratory `earnings_vs_netprice.png` and its correlation CSV. There
is **no written Stream C analysis** in `EDA/reports/`. Ask Gerry directly whether a write-up exists
outside the repo; if not, C1-C4 still need running.

## 7.6 Stream D - Data Quality: reported vs reality

**Owner: ____________  |  Status: largely computable NOW from existing audit tables  |  Script block: `D`**

| # | Question | Answer lives in |
| --- | --- | --- |
| D1 | Which institutions report least, by sector and level? | `row_completeness_by_group.csv` ✅ |
| D2 | Where is privacy suppression concentrated, and what does it hide? | `headline_metric_quality_scores.csv` + `row_completeness_by_group.csv` ✅ |
| D3 | Does low reporting track student need (Pell)? | needs the extract (quartile test) ⏳ |
| D4 | Panel attrition 2015→2025: who exits, by sector and size? | `CONTEXT.txt` yearly counts ✅ / exit breakdown needs the panel ⏳ |

### D1-D2: the established findings (safe to present today)

**Reporting tracks sector and level.** Public 4-year institutions average **87.1%** completeness;
private nonprofit less-than-2-year average **54.0%**. The full gradient:

| Group | Mean % complete | Mean metrics withheld (of 10) |
| --- | ---: | ---: |
| Public, 4-year | **87.1** | 0.05 |
| Private nonprofit, 4-year | 74.4 | 0.23 |
| Public, 2-year | 72.4 | 0.25 |
| Private nonprofit, 2-year | 66.3 | 0.30 |
| Private for-profit, 2-year | 64.9 | 0.06 |
| Private for-profit, 4-year | 62.5 | 0.11 |
| Private for-profit, Less-than-2-year | 60.0 | 0.20 |
| Public, Less-than-2-year | 57.0 | **0.62** |
| Private nonprofit, Less-than-2-year | **54.0** | 0.40 |

**Suppression is not spread evenly.** Public less-than-2-year institutions have on average
**0.62 of the ten headline metrics withheld** - twelve times the rate for public 4-year schools
(0.05). Short-program and for-profit institutions lose the most to privacy suppression, and they
are also the least complete.

**Only 23.7% of institutions have all ten headline metrics** (30.1% have at least nine).

### D4: attrition is a finding in its own right

Institutions present in each yearly file:

| Year | 2015 | 2016 | 2017 | 2018 | 2019 | 2020 | 2021 | 2022 | 2023 | 2024 | 2025 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Institutions | 7,666 | 7,238 | 7,112 | 6,807 | 6,694 | 6,681 | 6,543 | 6,484 | 6,430 | 6,322 | **6,273** |

**−1,393 institutions (−18.2%) in ten years.** `CURROPER` is ~100% populated, so *who exits* is
testable - by sector, size and quality tier. That answers "why does the panel shrink," which also
protects Stream B's trend from being misread.

### The headline this stream can carry

> **The institutions serving the neediest students are the ones whose outcomes are most withheld.**

The sector half of that sentence is already supported by D1/D2 above. The "neediest students" half
is what **D3** tests (Pell-quartile vs completeness). Run `04_streams.R D` and confirm it before
putting the sentence on a slide - do not assert it from sector alone.

---

# 8. Blockers and decisions

## 8.1 Blocker A - the data is not on this machine

Verified on 2026-09-20:

```
data/College_Scorecard_Raw_Data_06032026   does not exist
EDA/simplified/                            does not exist
data/                                      contains only CollegeScorecardDataDictionary.xlsx
```

Both are excluded by `.gitignore` **on purpose** (`/data/*` with one exception, and
`/EDA/simplified/`). So `git pull` will never bring them.

**Nothing in any stream can run until this is fixed.** Two options:

1. Download the bulk data into `data/College_Scorecard_Raw_Data_06032026/`, then rebuild with
   `02_build_simplified_data.R` (~15 s, writes all five extracts).
2. Get `institution_core_latest.csv` and `panel_core_1996_2025.csv` from whoever still has them.
   **Ask Gerry first** - these were produced on this repo before the folder was cleared.

If you run `04_streams.R` without the data it fails with a clear message rather than a cryptic
error: it names both missing files and tells you to run script 02 first. That is intentional.

## 8.2 Blocker B - R is installed but not on PATH

`Rscript` is not recognised in a plain terminal. It is here:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" --version
# R version 4.5.2 (2025-10-31 ucrt)
```

All required packages are present: `data.table`, `ggplot2`, `scales`, `readxl`, `writexl`,
`rscorecard`. Use the full path in every command below, or add it to PATH once.

## 8.3 Decision 1 - Stream B and the income bands (decide day one)

`net_price_lowinc` / `net_price_highinc` are **cross-section only**. Question B3 as originally
written ("is the gap narrowing or widening?") cannot be answered over time with the current panel.

- **Option A (no rebuild):** make B3 a **latest-year** statement, and say explicitly that the panel
  does not carry income-band prices so no trend is possible. Costs nothing, is honest, still
  answers a question.
- **Option B (rebuild):** add `NPT41_PUB`, `NPT41_PRIV`, `NPT45_PUB`, `NPT45_PRIV` to the panel
  column list in `02_build_simplified_data.R` and re-run it (~15 s). B3 then becomes a real trend.

## 8.4 Decision 2 - Stream D and attrition by quality tier (decide day one)

The panel (26 columns) has **no `dq_tier` or `pct_headline_complete`**. Sector and size exits work
today; "who exits **by data-quality tier**" needs a per-year completeness measure added.

- **Option A:** drop the DQ cut, do sector and size only.
- **Option B:** compute headline completeness per year in script 02 and add it to the panel.

## 8.5 Decision 3 - the extract's column set

The extract carries **113 of 3,308 raw variables (3.4%)**. If a stream needs a variable that is not
in it - `D150_4`, `C200_4`, `OMACHT6_FTFT`, `STUFACR`, `AVGFACSAL`, extra demographics - that means
editing the `CORE_*` sets in `00_common.R` (~lines 331-370), plus the panel list in script 02 if it
is a time-series variable, then re-running script 02. Small job, but it changes what is available.
**Settle it before anyone writes analysis code.**

Check availability first in:
`Docs/DataReference/reference/03_institution_variables.csv` ·
`06_cohort_coverage.csv` · `EDA/reports/variable_audit_institution_latest.csv`

---

# 9. Who does what

Three people, four streams. Gerry has Stream C, so the other two split A, B and D - one person
takes two.

| Who | Owns | Why this pairing | Est. |
| --- | --- | --- | --- |
| **Gerry** | **Stream C** - Outcomes & Value | Built the value indices and percentile groups; the instruments are already his | ~8 h |
| **Emily** | **Stream B** - Affordability | Heaviest single stream: panel semantics, 2009-2016 window, changing `n`, rolling averages | ~8 h |
| **You** | **Stream A** - Access **+ Stream D** - Data Quality **+ final assembly** | A is lightest (crosstabs); D is mostly re-framing tables that already exist; assembly balances the load | ~9 h |

**Swap condition:** if you would rather do the time-series work, swap B and A with Emily - she then
takes A + D + assembly. The only real constraint is that **whoever takes Stream B is comfortable
with the panel**, because that is where the subtle errors live.

**Non-negotiable, for everyone:** write the data-quality sentence for your own stream. Stream D's
owner **curates** them into one section; they do not rewrite other people's findings.

### Weekly sequence

| When | What |
| --- | --- |
| **Day 1 (45 min, all three)** | Clear Blocker A. Confirm §8.3 / §8.4. Rename "Prep 1/2/3" vs "Stream A/B/C/D". Fill in the owner blanks. |
| **Days 2-4** | Everyone runs their own block (`04_streams.R A` etc.), then writes their paragraph + DQ sentence. |
| **Days 5-6** | Assembly. Each person independently re-runs someone else's block and checks the numbers - cheap, and it catches most errors. |
| **Day 7** | All three read the whole report aloud. Fix anything that sounds wrong. Submit. |

---

# 10. How to run everything

```powershell
# 0. confirm R (it is NOT on PATH - use the full path)
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" --version

# 1. rebuild the five extracts (needs the raw data, ~15 s)
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/02_build_simplified_data.R

# 2. run all four streams (~30-60 s once the data is there)
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R

# 3. or just your own stream
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R A
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R B
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R C
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R D
```

**Outputs:** tables → `EDA/reports/stream_*.csv`, figures → `EDA/figures/stream_*.png`.
Nothing overwrites a raw file or any Prep 1-3 output.

| Script | Purpose | Needs |
| --- | --- | --- |
| `00_common.R` | Shared helpers | - |
| `01_size_limits_check.R` | Spreadsheet limits | raw data |
| `02_build_simplified_data.R` | Builds the 5 extracts | raw data |
| `03_eda_quality_report.R` | Prep 2 audit + figures | raw data + extracts |
| **`04_streams.R`** | **Goal 4 - all four streams** | extracts |

---

# 11. Presentation kit

**Target: 8 minutes, 12 slides.** Each row is one slide. The "say this" column is written to be read
out loud - trim it, don't improvise the numbers.

| # | Slide | On the slide | Say this | Who | Time |
| --- | --- | --- | --- | --- | --- |
| 1 | Title | "The College Scorecard: what's in it, how good is it, and what does it tell us?" | "Every US college files a public report card. We took that dataset, worked out how far it can be trusted, and asked four questions of it." | You | 0:20 |
| 2 | The dataset | 3,308 variables × 6,273 institutions = **20,751,084 cells**, 95.5 MB, one file per year for 30 years | "This is one file. Twenty million cells. Google Sheets caps at ten million, so it refuses it outright. Excel opens it and runs out of memory. That's the first problem to solve." | You | 0:45 |
| 3 | Prep 1 - into R | The 5 extracts table; "143 columns = 113 raw + 30 derived = **3.4%** of 3,308" | "We loaded 30 yearly files in R and cut them down to five small extracts. `NA`, `PS` and blanks became real missing values, and coded columns got decoded from the official codebook. One honest caveat: we work with 113 of the 3,308 variables." | Gerry | 0:45 |
| 4 | Prep 2 - the data is mostly empty | Tier table: 26 essentially complete · 301 (almost) empty · **201 completely empty** | "Only 26 of the 3,308 columns are essentially complete. Two hundred and one columns are completely empty. That is not a bug in our code - it is what is published." | Gerry | 0:45 |
| 5 | Prep 2 - missingness clusters | Jaccard table: PCTPELL↔PCTFLOAN 1.00 · ADM_RATE↔RET_FT4 0.86 | "Missingness is not random. Pell share and loan share are missing for *exactly the same 828 institutions* - Jaccard 1.00. So dropping incomplete rows does not give a random sample; it removes whole types of school." | Gerry | 0:45 |
| 6 | Prep 3 - the recodes | The 30 derived columns, grouped; the `value_index_earn` formula | "We built 30 derived columns. The key one is the value index: a school's earnings percentile minus its price percentile, both computed **inside its own sector and level** - so we are not just ranking rich schools above poor ones." | Gerry | 0:45 |
| 7 | Where the four questions come from | The PDF quote + mapping table (access / affordability / student outcomes / data quality) | "The brief asks for a series of questions covering access, affordability, student outcomes, and the effect of data quality. That is exactly our four streams - so we are covering the brief's own categories, not inventing our own." | You | 0:30 |
| 8 | **Stream A - Access** | `stream_a1_msi_by_sector.png` + the A3 Pell chart | [FILL after run] "Minority-serving institutions are concentrated in … . Pell access is highest in … . Caveat: admission rate is only 30% complete, so selectivity claims cover roughly 1,900 schools." | You | 0:45 |
| 9 | **Stream B - Affordability** | `stream_b1_net_price_trend.png` + `stream_b2_sticker_net_gap.png` | [FILL after run] "Net price moved … between 2009 and 2016. Caveat: the panel sheds institutions every year, so part of any rise may be a changing mix of schools rather than rising prices." | Emily | 0:45 |
| 10 | **Stream C - Value** | `stream_c1_value_top25.png` + `stream_c4_rank_stability.png` | [FILL after run] "On the earnings-based value index the top institutions are … . Re-ranking on completion changes … of the top 50. And when we keep only the 23.7% of schools with all ten headline metrics, the ranking …" | Gerry | 1:00 |
| 11 | **Stream D - who is missing** | `stream_d1_completeness_by_sector.png` + `stream_d3_reporting_vs_pell.png` + the attrition line | "This is the finding we would lead with. Public 4-year colleges report 87% of the headline metrics; private nonprofit two-year colleges report 54%. Public short-program institutions have **0.62 of ten metrics withheld** for privacy - twelve times the rate of public 4-year schools. And only 23.7% of institutions have all ten. The schools serving the neediest students are the ones whose outcomes are hardest to see." | You | 1:00 |
| 12 | Conclusion | Three bullets: what we built · what we found · what it cannot tell you | "We turned 30 unreadable files into five usable extracts, measured the quality of all 3,308 columns, built 30 recodes, and answered four questions. The honest limit: we are describing 6,273 reporting institutions, not every college, and only a quarter of them are complete enough for the full comparison." | You | 0:45 |

### Presentation rules

- **Say the caveat before the audience asks.** Every stream has one; §7 lists them. Volunteering it
  reads as competence. Being caught by it reads as an error.
- **Never say "all colleges."** Say "the 6,273 institutions in the latest file."
- **Never compare sector averages of `value_index_earn`.** It is ≈ 0 by construction.
- **Lead with Stream D.** "The data about poor students is the worst data" is the most memorable
  result, and it justifies the entire quality section.
- **Slides 8-11 need numbers.** Until the data is restored they stay `[FILL]` - do not present a
  placeholder slide.

---

# 12. Q&A prep - 14 likely questions

| Question | Answer |
| --- | --- |
| "Why not just use Excel?" | One file is 20,751,084 cells. Google Sheets caps at 10,000,000 per spreadsheet and Excel runs out of memory. Excel also cannot clean the `NA`/`PS`/`PrivacySuppressed` tokens, so whole numeric columns become text. |
| "Why only 113 variables out of 3,308?" | Deliberate scope. 201 columns are completely empty and only 26 are essentially complete. The 113 are the ones with usable coverage. The extract is 3.4% of the columns by design, and we say so out loud. |
| "Isn't missing data random?" | No. `PCTPELL` and `PCTFLOAN` are missing for exactly the same 828 institutions (Jaccard 1.00). `ADM_RATE` and `RET_FT4` co-miss for 63.2%. Missingness is structural. |
| "What is the difference between `NA` and `PS`?" | `NA` = not collected or not applicable. `PS` = collected but withheld because the group was too small to publish. `PS` carries information: it tells you the cohort is small and non-zero. |
| "Why 6,273 institutions and not 7,000?" | 6,273 is the most-recent reporting universe. The 2015 file had 7,666, and institutions have closed or merged since (-18.2%). We never claim to cover every college. |
| "Why is net price sometimes above sticker price?" | 19.5% of institutions. It is legitimate when grant aid exceeds tuition. Only 12 negative net prices and 11 zero-enrolment rows are genuine errors (~0.2% each). |
| "Why can't you compare public and private on the value index?" | The index is a percentile *within* sector × level, so each sector's mean is ≈ 0 by construction. Cross-sector comparison must use raw earnings ÷ net price. |
| "How do you know the data is right?" | Two independent routes: the aggregated yearly CSV files (done) and the API (started). Plus 3,486 API field paths verified live, and a documented cross-check plan against ~20 institutions. |
| "Which finding matters most?" | That data quality tracks disadvantage. Public 4-year institutions report 87% of headline metrics; private nonprofit two-year institutions report 54%; public short-program institutions have 0.62 of ten metrics withheld for privacy. |
| "Why 2009-2016 for affordability?" | It is the only window where the cost variables overlap across the yearly files. Outside it, those columns are `NA` in the cohort map. |
| "What do the two-year moving averages do to your trends?" | `*_POOLED` and `RPY_3YR_RT` smooth single-year moves and induce autocorrelation, so we do not over-read one-year changes. |
| "Can you join the program file to the institution file?" | Mostly. 7,020 program rows (778 institutions, mostly foreign or closed) carry the literal text `NA` as their `UNITID`, so they can never join. We filter on `has_unitid`. |
| "What would you do with more time?" | Finish the API route for a second independent data path; rebuild the panel with income-band prices so Stream B can trend the low/high-income gap; add a per-year completeness measure so Stream D can test exits by quality tier. |
| "What is the single biggest limitation?" | We describe 6,273 reporting institutions using 113 of 3,308 variables, and only 23.7% of those institutions have all ten headline metrics. Every conclusion is conditional on that. |

---

# 13. File map

```
Group Project 1/
├── Docs/
│   ├── Group Project I.pdf              the assignment brief
│   ├── APIWalkthrough.md                how to get an API key (each member needs their own)
│   ├── ASSIGNMENT_GUIDE.md              THIS DOCUMENT
│   └── DataReference/                   the data dictionary, decoded
│       ├── CollegeScorecard_Data_Structure.pdf   10-page explainer
│       ├── INDEX.md                              index of the pack
│       └── reference/
│           ├── 00_readme_and_key_tabs.md   the 8 workbook tabs, explained
│           ├── 01_glossary.csv             AY / CY / DCY / FY / NSLDS / IPEDS / CIP
│           ├── 02_changelog.csv            when each variable appeared or changed
│           ├── 03_institution_variables.csv  all 3,308 vars, BOTH naming systems
│           ├── 04_institution_variables_by_category.md  the same, readable
│           ├── 05_value_labels.csv          what code 1 means (277 pairs)
│           ├── 06_cohort_coverage.csv      which years each variable exists
│           ├── 07_field_of_study_variables.csv  178 program vars (nested)
│           ├── 08_api_field_paths.txt      copy/paste API paths
│           └── 09_api_path_validation.csv  live check of all 3,486 paths
├── EDA/
│   ├── README.md                        the long-form write-up of Preps 1-2
│   ├── scripts/
│   │   ├── 00_common.R                  shared helpers
│   │   ├── 01_size_limits_check.R       why the files will not open
│   │   ├── 02_build_simplified_data.R   builds the 5 extracts
│   │   ├── 03_eda_quality_report.R      Prep 2 audit + figures
│   │   └── 04_streams.R                 ← GOAL 4: the four streams
│   ├── reports/
│   │   ├── STREAM_PLAN.md               one-page plan for the group chat
│   │   ├── EDA_SUMMARY.md               Prep 2 findings, written up
│   │   ├── headline_metric_quality_scores.csv
│   │   ├── row_completeness_by_group.csv
│   │   ├── completeness_vs_size.csv
│   │   ├── missingness_cooccurrence_latest.csv
│   │   ├── missingness_jaccard_matrix_latest.csv
│   │   ├── variable_audit_institution_latest.csv   all 3,308 columns
│   │   ├── core_variable_coverage_matrix.csv       what exists in which year
│   │   ├── data_anomalies_latest.csv
│   │   └── simplified_codebook.csv      every column of the extract
│   ├── figures/                         4 Prep-2 figures (PNG)
│   └── simplified/                      ← git-ignored, regenerate with script 02
└── data/
    └── CollegeScorecardDataDictionary.xlsx   the official codebook (the only data file in git)
```

---

# 14. Honest status table

| Item | State | Where | What is left |
| --- | --- | --- | --- |
| **Prep 1** - data into R | ✅ **done** (route a) | `02_build_simplified_data.R` | Route c (API) started, not finished |
| **Prep 2a** - missingness | ✅ **done** | `03_eda_quality_report.R` | nothing |
| **Prep 2b** - quality scores | ✅ **done** (10 metrics) | `headline_metric_quality_scores.csv` | nothing |
| **Prep 3** - 30 recodes | ✅ **done** | `simplified_codebook.csv` | nothing |
| **Stream A** - Access | ⏳ pending | `04_streams.R` block A | run + write up |
| **Stream B** - Affordability | ⏳ pending | `04_streams.R` block B | decide §8.3, run, write up |
| **Stream C** - Value | ⏳ pending | `04_streams.R` block C | confirm with Gerry, run, write up |
| **Stream D** - Data quality | 🟡 **partly done** | audit tables + §7.6 | run `04_streams.R D` for D3/D4, then write up |
| **Report assembly** | ⏳ not started | - | after the streams |
| **Presentation** | 🟡 **outline ready** | §11 | fill slides 8-11 |

### The three things that are actually blocking you

1. **The data is not on this machine** (§8.1). Nothing runs until this is fixed.
2. **Two column decisions** (§8.3, §8.4) - both ~30 minutes, both must be settled on day one.
3. **Stream C's write-up** may not exist. Ask Gerry before assuming it is done.

Everything else is execution.









