# STREAM PLAN - Group Project I (Goal 4)

> Superseded plan, retained for history. Use ../../presentation/WORK_DIVISION.md and
> SLIDE_OUTLINE.md (nine slides, three people, fifteen minutes). See ../../Docs/AUDIT_REPORT.md.
> Earlier “finished” statements are implementation claims, not verified current reproduction.
> B3 now asks about latest income-band differences, not widening; B1 uses observed coverage
> and nominal source dollars. C4 compares common-set ordering and is mechanical with fixed
> scores. D3 excludes missing/invalid Pell; D4 uses explicit 2015/2025 endpoints and measures
> file absence, not closure. Net price above tuition is not evidence of grants exceeding tuition.

**One page. Paste this into the group chat.**

---

## The thing that was confusing everyone

There are **two different things both called "3"**:

| Name | What it is | Status |
|---|---|---|
| **Prep 3** | PDF Goal 3 - *"Recode any variables of interest"* | ✅ done in the repo |
| **Stream C** | Our Stream 3 - *"Student Outcomes & Value"* | Gerry's slice of Goal 4 |

**Preps 1, 2 and 3 are all finished and committed.** The four streams are the four sub-parts of
**Goal 4**, not four separate assignment sections. Proof, from the PDF:

> 4. Identify and display any relationships of interest.
> a. … use some of the recoded variables above, **consider effects of data quality**, and answer
> **a series of defined questions**.
> b. Outcomes might cover **access, affordability, student outcomes, or other categories**.

| Our stream | PDF wording |
| --- | --- |
| A - Access | "access" |
| B - Affordability | "affordability" |
| C - Outcomes & Value | "student outcomes" |
| D - Data Quality | "consider effects of data quality" + "other categories" |

From now on: say **"Prep 1/2/3"** for the goals and **"Stream A/B/C/D"** for the slices.

---

## Who owns what

| Stream | Owner | Questions | Outputs |
| --- | --- | --- | --- |
| **A - Access** | ____________ | Where are minority-serving institutions concentrated by sector/region/locale? Does enrolment composition differ by sector and selectivity? Is Pell access concentrated? | `stream_a*.csv`, `stream_a*.png` |
| **B - Affordability** | ____________ | How did net price move 2009-2016 by sector and level? Did the sticker↔net gap widen? Is the low/high-income price gap widening? | `stream_b*.csv`, `stream_b*.png` |
| **C - Outcomes & Value** | Gerry | Which schools are best value on `value_index_earn`? Does it flip on `value_index_grad`? Do completion and earnings agree? | `stream_c*.csv`, `stream_c*.png` |
| **D - Data Quality + assembly** | ____________ | Who reports least, and does it track student need? Where is suppression concentrated? Who exits the panel 2015→2025? | `stream_d*.csv`, `stream_d*.png` |

Everyone writes a **data-quality paragraph** for their own stream. Stream D's owner **curates**
those into one section - they do not rewrite them.

---

## Blocker to clear before any code runs

The extracts and the raw data are **not on this machine** (`data/` holds only the codebook;
`EDA/simplified/` does not exist). Both are git-ignored on purpose, so `git pull` will not fix it.

Either:
1. download the bulk data into `data/College_Scorecard_Raw_Data_06032026/`, then
   `Rscript EDA/scripts/02_build_simplified_data.R` (~15 s, rebuilds all five extracts), **or**
2. get `institution_core_latest.csv` + `panel_core_1996_2025.csv` from whoever still has them.

**R is installed but not on PATH.** Use the full path on Windows:

```powershell
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/02_build_simplified_data.R
& "C:\Program Files\R\R-4.5.2\bin\Rscript.exe" EDA/scripts/04_streams.R C    # one stream
```

---

## Two decisions that must be made on day one

1. **Stream B, income bands.** `net_price_lowinc` / `net_price_highinc` exist only in the
   cross-section, not the panel. So "is the low-vs-high-income gap widening?" is a
   **latest-year** statement unless we add `NPT41_PUB/PRIV` + `NPT45_PUB/PRIV` to the panel
   column list in `02_build_simplified_data.R` and rebuild. Decide: latest-year only, or rebuild.
2. **Stream D, attrition by quality.** The panel has no `dq_tier` / `pct_headline_complete`
   column. Sector and size exits work today; "by DQ" needs a per-year completeness measure added.
   Decide: drop the DQ cut, or add it.

Both are ~30-minute edits. Discovering them on day five costs a day.

---

## Definition of done (per stream)

A stream is finished when it has **all four**:

- [ ] a table in `EDA/reports/stream_<letter>*.csv`
- [ ] a figure in `EDA/figures/stream_<letter>*.png`
- [ ] **one paragraph** of interpretation (what it shows, and what it does *not* show)
- [ ] **one data-quality sentence** (how many institutions had the data, and what that hides)

Six-to-eight questions answered to that standard *is* Goal 4. It asks for "a series of defined
questions", not one headline.

---

## Traps (each of these has already cost someone time)

1. **Never compare group means of `value_index_earn`.** It is a percentile within
   `control × level` peer groups, so every group mean is ≈ 0 **by construction**. Compare raw
   `earn_p10 / net_price`, or within-group spread.
2. **`PCTPELL` and `PCTFLOAN` are the same 828 institutions** (Jaccard 1.00). Not two predictors.
3. **Never write "all colleges."** The universe is 6,273 reporting institutions, and only
   **23.7%** have all ten headline metrics.
4. **`PS` ≠ `NA`.** `NA` = not collected; `PS` = collected but withheld because the group was too
   small. `PS` carries information.
5. **`MERGED####_##` is the source-file year**, not the outcome year - many metrics are 6-, 8- or
   10-year lagged cohorts.
6. **Net price above sticker is not a bug** (19.5% of institutions; grants exceed tuition). Only
   the 12 negative net prices and 11 zero-enrolment rows are real errors.
7. **Two-year rolling averages** (`*_POOLED`, `RPY_3YR_RT`) blunt single-year moves. Don't
   over-read a one-year change.
