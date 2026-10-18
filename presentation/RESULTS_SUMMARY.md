# Evidence register — October 18, 2026

**No institution-level result was reproduced from raw data in this audit.** `data/` contains only the dictionary; `EDA/simplified/` has no extracts. All four pipeline entry points were attempted and stopped at explicit missing-input checks. See `Docs/audit/pipeline_attempts.txt`.

The following values were independently checked against existing CSVs in R. They are verified as saved-artifact values, conditional on their original provenance. They are not independently verified observations from the absent raw files.

| Quantity | Value / denominator | Local evidence |
| --- | --- | --- |
| Institution audit universe | 6,273 rows, 3,308 variables | `variable_audit_institution_latest.csv` |
| Entirely empty variables | 201 / 3,308 | `n_nonmissing == 0` in that audit |
| Essentially complete variables | 26 / 3,308 (≤1% missing) | Same audit |
| Pell coverage | 5,445 / 6,273 = 86.8% | `headline_metric_quality_scores.csv` |
| Undergraduate enrollment coverage | 5,478 / 6,273 = 87.3% | Same quality table |
| Admissions coverage | 1,910 / 6,273 = 30.4% | Same quality table; applicability matters |
| Pell/loan co-missingness | 828 / 6,273 = 13.2%; Jaccard 1.000 | `missingness_cooccurrence_latest.csv`; intersection/union arithmetic checked |
| Net-price source-year coverage | Both NPT4_PUB and NPT4_PRIV have >0 coverage in 2009–2024 | `core_variable_coverage_by_year.csv`; source files unavailable; positive coverage alone is not sufficient suitability |
| Tuition source-year coverage | >0 coverage in 2000–2024 | Same coverage CSV |
| Attendance-cost coverage | COSTT4_A has >0 coverage in 2009–2024 | Same coverage CSV |
| Existing earnings/price chart sample | 1,489 = 42 for-profit + 920 nonprofit + 527 public; all 4-year | `earnings_vs_netprice_correlation.csv`; source filter was effectively 100% complete due to old tier-boundary bug |

Saved audit limitations discovered: `ALIAS` has 3,901 counted missing + 2,365 nonmissing = 6,266, seven short of 6,273. The original auditor excluded alternate missing tokens from valid values without counting them in missing totals; source inspection suggests this mechanism, but the actual seven raw tokens are unverified. The updated auditor counts all configured missing tokens.

**Do not reuse these claims:**

- “1,225 net prices exceed tuition.” The original predicate actually counted `TUITIONFEE_IN > net_price`. The corrected opposite-direction count is unknown until regeneration. Tuition and net price represent different cost concepts.
- “Zero enrollment and negative net prices prove errors.” These are review flags, not verified errors. Zero enrollment can be legitimate.
- “2009–2016 is the only usable window.” Saved observed coverage contradicts this; restore raw data and examine paired counts by year/group.
- Old `share_high_dq`: old cut intervals put exactly 90% in Medium while the label said High ≥90%. Regenerate before use.
- Old `n_unique`/`pct_unique` in headline scores: missing NA was included as a distinct value. Regenerate; coverage itself is unaffected by that defect.
- C4 raw rank shift as performance or robustness; D4 disappearance as closure; Pell/loan co-missingness as proof the substantive variables are identical or dependent.

**Real-data A/B/C/D findings and sample sizes: pending.** There are no existing stream output CSVs/figures in this checkout. After real runs, record A3 group means and n_pell; B3 paired means and n_inst; C2 sample size/overlap/correlation; D3 group sizes/boundaries and excluded count; D4 baseline/retained/absent counts. Attach each finding to its named output and run date.

Regression verification is separate: all four streams executed on 24 invented institutions in a temporary directory. The checks confirmed four groups of five valid Pell records with four missing Pell records excluded, unchanged common-set ordering, and 22 retained/2 absent synthetic IDs from 2015 to 2025. These are software checks only and must never appear as College Scorecard findings.
