# Understanding the College Scorecard project

Read `presentation/RESULTS_SUMMARY.md` before quoting any number. The local dictionary and saved tables exist; raw data and extracts do not. The code was checked with invented examples, which test calculations but say nothing about actual colleges. The presentation has nine slides, three per person.

## Section 1: Reading and cleaning

We turn large text files into small R `data.table` datasets. The professor wants evidence that the data we analyze have the right meaning and types. A number-looking cell is not useful if R treats it as a word, and a privacy marker must never be treated as zero.

`01_size_limits_check.R` measures file dimensions. Excel's shape limit and Google Sheets' cell budget are different questions from how fast a laptop can open a file. Being inside a shape limit does not establish usability. `02_build_simplified_data.R` reads only selected variables with `fread`, preserves privacy information, cleans cells, adds derived variables and writes CSV/XLSX extracts. The yearly panel contains one row per `UNITID` per source year. The latest institution file has one row per `UNITID`. The builder now rejects missing/duplicate institution IDs and duplicate institution/year keys.

`00_common.R` supplies the cleaning functions. Blank, `NA`, `N/A`, `NULL`, `.`, `-`, `PS` and `PrivacySuppressed` become R's real `NA`. `PS` and `PrivacySuppressed` explicitly indicate privacy withholding; ordinary missing values do not disclose their exact reason. Flags are recorded before this conversion. Numeric columns become numeric only when all their nonmissing entries parse; ZIP, OPE identifiers, state FIPS and CIP codes stay text to preserve leading zeros. `UNITID` remains numeric in this pipeline and is an exact integer identifier, not a quantity to average.

The official `data/CollegeScorecardDataDictionary.xlsx` defines variables and category codes. Its merged-cell layout requires carrying variable names forward across label rows. `load_dictionary()` does that, and `decode()` joins code values to labels such as Public. An unknown code is visible as `code: ...`. The existing reference CSVs are convenient exports, not a replacement authority.

Never join institutions on names. A program file has multiple rows per institution; joining it directly can multiply institution records. Filter out missing `UNITID`, verify institution uniqueness, aggregate programs to institution level when needed, and inspect row counts before/after any join. The existing program aggregate now excludes missing IDs from its distinct-institution count and reports program rows without IDs separately. A count of distinct institution names is only a proxy when IDs are absent.

The PDF offers aggregation, a database interface or the API as alternatives. This project uses aggregation; the unfinished API example does not mean Goal 1 fails. Do not say the most-recent file is one common graduating class: earnings, completion and prices can describe different cohorts.

## Section 2: Assessing quality

We measure what information is present before answering substantive questions. The professor wants us to notice whether dropping incomplete rows changes the population under study. Data quality is part of the analysis, not an appendix excuse.

`03_eda_quality_report.R` audits literal tokens across all columns and computes:

| Calculation | Meaning |
| --- | --- |
| missing fraction = missing cells / all rows | How often this variable lacks a usable value; includes suppressed cells |
| privacy fraction = PS cells / all rows | How often withholding is explicitly indicated |
| completeness = nonmissing / all rows | Reporting coverage, not correctness |
| Jaccard = number missing both / number missing either | Similarity between two missingness patterns |
| expected both missing = missing count A × missing count B / rows | What independent missingness would predict, a descriptive benchmark |
| custom quality score = 100 × completeness × (1 − privacy fraction) | An intentionally extra suppression penalty; not a probability that values are correct |

Suppressed cells are already missing, so the custom score penalizes suppression twice relative to a plain coverage measure. Report coverage and suppression alongside it. Do not call the score a standard validated quality index. The code's “unusable” flag below 50% is a heuristic for the whole file; an admissions rate can still be useful in its applicable subpopulation.

The missingness bar chart shows one bar per variable; a taller bar means more unavailable values. The coverage chart shows availability by source-file year, not changing values of the measure itself. The sector/level boxplot summarizes ten-metric completeness per institution. Differences can reflect applicability: `RET_FT4` is a four-year measure, so requiring it disadvantages other levels by design.

Saved Pell and loan missingness match exactly for 828 institutions, with Jaccard 1. That does not make Pell share and loan share identical measurements or prove statistical dependence between their observed values. The saved `ALIAS` count has a seven-row discrepancy and needs regeneration; this is why reports are audited too. Negative prices and zero enrollment are investigation flags, not automatically erroneous records. Net price can exceed tuition because it includes costs beyond tuition.

## Section 3: Recoding

We combine alternative fields, translate categories and form comparisons. The professor wants transformations that make relationships interpretable, with formulas we can explain. These are the transformations used by the planned presentation; the full machine-readable inventory is `EDA/reports/simplified_codebook.csv` and the builder's `DERIVED_LABELS`.

| Variable / transformation | Formula or rule | Why it is used |
| --- | --- | --- |
| control/level labels | Decode `CONTROL` and `ICLEVEL` using dictionary | Readable sector/level grouping on A/B/D slides and C peer groups |
| region/locale/degree/Carnegie labels | Decode their raw codes | Supporting A tables; not all appear on slides |
| minority_serving / is_msi | Combine HBCU/PBI/TRIBAL/HSI/ANNHI/AANAPII/NANTI flags; any positive flag identifies an MSI; all missing stays unknown | Supporting A1 analysis; overlapping missions can be retained in combined text |
| size_bin | UGDS <1,000; 1,000–4,999; 5,000–19,999; ≥20,000; missing separately | Supporting quality and D4 strata |
| selectivity_bin | ADM_RATE <.25; [.25,.50); [.50,.75); ≥.75; open admission if no rate and OPENADMP=1; otherwise not reported | Supporting A2 grouping, not a prestige score |
| net_price | First available NPT4_PUB, NPT4_PRIV | Put sector-specific total-attendance net prices in one field |
| net_price_lowinc / highinc | First available NPT41_PUB/PRIV; first available NPT45_PUB/PRIV | $0–30,000 and $110,001+ family-income comparisons |
| net_price_income_gap | highinc − lowinc, only paired observations in B3 summaries | Compare income bands within a school |
| grad_rate / grad_rate_basis | First available C150_4, C150_L4; label which source supplies it | Completion within 150% of normal program time; cohorts remain different |
| earn_p10 / grad_debt_mdn | Rename MD_EARN_WNE_P10 / GRAD_DEBT_MDN | Readable earnings and graduate federal-debt variables |
| metric_pctile_group | Average-tie rank / valid n, separately within CONTROL × ICLEVEL | Put price, completion and earnings on percentile scales |
| value_index_earn | earnings percentile − net-price percentile | Relative earnings/price position in peer group |
| value_index_grad | graduation percentile − net-price percentile | Alternative outcome definition |
| n_headline_missing | Missing count across ten named headline metrics | Report record completeness |
| pct_headline_complete | 100 × (1 − missing count / 10) | B recoding example, D outcome, C complete-record diagnostic |
| n_headline_privacy_suppressed | Count PS flags across headline source cells before cleaning | D suppression; source-cell count can differ conceptually from coalesced-metric count |
| dq_tier | <50 Very low; [50,70) Low; [70,90) Medium; ≥90 High | Descriptive quality labels, corrected interval endpoints |
| Pell plotting unit | 100 × mean PCTPELL | Raw proportion becomes percentage for A3 axis |
| pell_q | Average-tie rank of valid Pell / valid n; cut at .25, .50, .75 | D compares reporting across Pell-share groups; no missing Pell in denominator |
| C ranking comparison | Rank both lists within the same retained IDs | Avoid artificial shifts due to removing other institutions |
| year_start / file_year | Parse source filename | Coverage and optional historical comparisons; not outcome year |
| endpoint presence | 2015 UNITID belongs / does not belong to 2025 ID set | D4 endpoint retention/absence, using 2015 sector/size |

Other existing derived fields are retained for supporting outputs: `tuition_in_out_gap = TUITIONFEE_OUT − TUITIONFEE_IN`; `sticker_to_net = TUITIONFEE_IN / net_price` only for positive net price; `grad_debt_to_earn = grad_debt_mdn / earn_p10` only for positive earnings. Program fields use CIP family = floor(numeric CIPCODE / 100), a family label, `has_unitid`, and debt/earnings with a positive earnings denominator. These ratios are not grant aid or loan repayment time. The latest institutional extract still has its existing 30 derived columns; the new D3/ranking diagnostics are stream calculations rather than added extract columns.

Percentiles use ranks divided by valid n, so the smallest rank is 1/n rather than zero. Ties get average ranks. For price 10,000, 20,000, missing within one peer group, percentiles are .5, 1, missing. If earnings percentile is .8 and price percentile .3, value is .5; this is not $0.50, 50% ROI or an adjusted earnings amount. Separate missing-data patterns can also give percentile distributions slightly different means; do not compare sector means of value scores as an outcome ranking.

## Stream A: Access & equity

We ask who enrolls at different types of institution and where minority-serving institutions are located. This connects cleaning and category decoding to substantive access questions. Variables include mission flags, CONTROL, ICLEVEL, REGION, LOCALE, race/ethnicity proportions, ADM_RATE and PCTPELL.

A1 counts institutions with a known MSI status and the share identified as MSI by sector, region and locale. Unknown is not silently “not MSI.” A2 averages racial/ethnic shares within sector/selectivity cells and now reports a valid sample size for each share. A3 averages Pell shares by sector/level and reports `n_pell` alongside the whole group size. Every institution has equal weight; large colleges do not get more influence.

In slide 3's grouped bars, compare colors within a sector and bars across sectors, while checking group counts in the CSV. The corrected chart multiplies proportions by 100. A mean of .4 becomes 40%, not .4%. The finding remains pending without real extracts. Do not infer a national student share, causal sector effect, or full national MSI census from these institutional means. Partially missing mission flags also limit classification.

## Stream B: Affordability

We ask how the latest low/high-income net-price gap differs across sector/level groups. This is defensible with the existing cross-section. B3 keeps only institutions with both band values, averages each band's price and averages high minus low. The same paired sample means the mean gap equals high mean minus low mean. Its `n_inst` is the paired sample, not all institutions in the group.

The chart uses dollars on the horizontal axis; a positive bar means high-income families have higher average net prices in those institutions. It does not say the same family pays that amount or that the gap has widened. Net-price populations are first-time, full-time degree/certificate-seeking Title IV recipients; public figures use in-state recipients. Definitions come from the official dictionary and its exported notes.

Optional B1 summarizes net prices by year/sector/level and B2 summarizes tuition minus net price on complete pairs. The B0 table records observed coverage; saved tables show net price observations through 2024, so the old fixed 2009–2016 restriction was unsupported. Positive observations alone do not prove adequate coverage, cohort comparability or a balanced panel. Missing intermediate years and changing institutions must be checked.

Tuition is one cost component. Net price is attendance costs, including living expenses, minus grants. Subtracting net price from tuition mixes concepts and does not recover grant aid. Even attendance cost minus net price needs compatible populations and reference periods before interpreting it as aid. We keep B2 as a clearly labeled descriptive difference, and choose B3 for the slide.

Historical code uses nominal source-reported dollar values and explicitly limits interpretation to recorded amounts. It cannot establish purchasing-power change without a documented inflation adjustment aligned to each metric's actual reference year/dollar basis. No inflation adjustment is needed for the presentation's stated within-snapshot question.

## Stream C: Student outcomes & value

The teammate's core implementation compares earnings and completion against price using within-peer percentiles. We preserve its original file in `Docs/audit/04_streams_before_audit.R.txt` for comparison. C1–C3's research design remains intact. C1 lists high/low earnings index institutions; C2 compares top lists and Spearman correlations between two value definitions; C3 compares completion and earnings within sectors. This shows how conclusions depend on the outcome we choose.

Current C eligibility requires both value indexes, so a school with earnings/price but missing completion is excluded even from C1. Report that sample restriction. Spearman compares order rather than dollar differences; +1 indicates matching order, near zero weak monotone association, and −1 opposite order. Top-list overlap is common IDs / chosen top-list size. Small samples choose fewer than 50 and ties at the cutoff are broken reproducibly by UNITID.

C4 originally compared absolute positions in a full list with positions in a smaller complete-record list. A school can move from rank 100 to rank 20 merely because 80 other schools were removed. The corrected diagnostic compares ranks among the same retained IDs on both axes. With scores held fixed, ordering is identical by construction. It is not an independent statistical robustness test. Use C2 on slide 8 for meaningful sensitivity to outcome definition instead.

High value is not proof a college causes high earnings or offers the best choice for any student. Earnings reflect working, non-enrolled populations and lagged cohorts; price, earnings and completion do not refer to a single matched class. Cross-peer top lists compare relative positions in different distributions. The indexes do not remove selection effects, differences in fields of study or regional wages.

## Stream D: Data quality

We ask whether reporting differs by sector, level and student need. D1 summarizes completeness; D2 summarizes explicit suppression. D3 splits valid finite PCTPELL between zero and one into rank-based quartile bands, then compares average completeness. Missing Pell is excluded from the denominator and counted separately. Average ranks keep tied values together, so quartile sizes may be unequal or a band empty. The output includes actual min/max boundaries and sizes for verification.

On slide 6, the vertical scale is percent of ten headline metrics present, not percent of students receiving Pell. The four categories on the horizontal scale identify Pell-share groups. A difference is an association between need proxy and reporting coverage, not evidence that Pell causes poor data or that institutions are less trustworthy. Including PCTPELL in the ten-metric score partly builds a reporting requirement into the score; conditioning on observed Pell also excludes a distinctive missing-Pell group.

D4 uses explicit source years 2015–2025 for annual counts. Its endpoint table starts with 2015 institutions: retained means the ID also appears in 2025; absent means it does not. Baseline sector and size determine groups, and counts satisfy baseline = retained + absent. Endpoint retention permits missing intermediate years; it is not continuous presence. Entrants after 2015 are not baseline retention. A missing 2025 ID could reflect merger, reporting changes or identifiers as well as closure, so closure needs independent status/history evidence. The old script actually compared the last two available files, which did not answer its stated ten-year question.

## Reading the final conclusions

All four assignment goals are represented in the implementation. The PDF also expects actual displayed relationships, so code plus a slide outline is not empirical completion. Restore the data, run the scripts, review denominators and fill the pending findings. An honest answer distinguishes what the code does, what the saved artifacts contain and what was newly reproduced.
