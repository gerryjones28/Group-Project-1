# Targeted audit and completion report

Date: October 18, 2026. Scope: existing five R scripts, README, assignment PDF, assignment guide, EDA README/summary, stream plan, official XLSX dictionary and saved audit/reference tables. No repository restart, Git reset, commit or history rewrite was performed. Existing user changes to README and the previously untracked guide, plan and stream script were retained.

## What was already correct

The project has a useful pipeline: selected-column reads, shared missing-token cleaning, privacy flags before cleaning, dictionary-based decoding, institution and program extracts, a source-year panel, per-column audits, co-missingness and four distinct analysis streams. The PDF permits file aggregation as an alternative to database/API access; completing the two-line API example is optional. The four streams collectively address relationships while carrying data-quality limitations. Keep the teammate's percentile-index design and C1–C3 questions, subject to their stated observational limits.

## Confirmed defects and corrections

| Issue | Evidence / correction |
| --- | --- |
| A/C unnecessarily require panel | Original unconditional two-file preflight; latest-only streams now require only the institution file; B3/D1–D3 can also run without panel |
| Unknown MSI status treated as non-MSI | Original `!is.na(v) & ...`; preserve unknown, provide known-status denominator |
| A2 sample sizes absent | Add per-race-variable n alongside each unweighted mean |
| Pell chart wrong units | Original proportions on an axis labeled percent; multiply plotted mean by 100 |
| B2 called grant aid | Tuition and total-attendance net price have different scopes per dictionary; retain descriptive subtraction, remove aid interpretation |
| B3 temporal question with latest data | Rewrite as latest cross-sectional band differences; both means and mean gap use the same paired institutions |
| Fixed 2009–2016 window | Saved observed coverage shows net-price fields through 2024; use actual panel values to select years and export B0 counts; raw coverage verification still blocked |
| Inflation not stated | B1/B2 labeled nominal source-reported dollars; no real-dollar claim; use B3 for presentation |
| C4 incompatible raw rank positions | Compare order/ranks on common retained IDs; explain fixed-score invariance and use C2 for outcome-definition sensitivity |
| C tiny/empty top lists | Replace `1:N_TOP` with `head`; deterministic UNITID tie-breaks in C2 |
| D3 full-population denominator | Rank only valid Pell [0,1]; average ties; report n, observed ranges and excluded counts |
| D4 wrong period and exit language | Explicit 2015–2025 annual subset; endpoint comparison requires 2015 and 2025; output retained/absent counts by baseline sector/size; no inferred closures |
| Missing-token audit inconsistent with cleaner | Count all NA_LIKE_TOKENS, not only literal NA; existing ALIAS table has seven unaccounted rows |
| Text code lost leading zeros | Preserve CIPCODE (and OPEID if used) as text |
| No duplicate-key guards | Reject missing/duplicate institution keys and duplicate institution/year keys before stream joins |
| Unsafe ratio denominators | Set ratio missing for nonpositive net price/earnings denominators |
| DQ tier interval labels wrong | Use left-closed cuts: 50 Low, 70 Medium, 90 High; old cut put 90 in Medium |
| Distinct counts include missing | Exclude NA from headline numeric uniqueness and program distinct-institution counts; explicitly count programs without IDs |
| Anomaly predicate reversed | Original “net price above tuition” row counted tuition > net price; correct predicate, require regeneration, withdraw old 1,225 claim |
| Chart completeness wording fragile | Explicitly filter `pct_headline_complete == 100` rather than relying on buggy High tier; preserve intended complete-record chart definition |
| Quality score overinterpreted | Document custom suppression penalty: suppressed values already reduce completeness; score is not an accuracy probability |

Negative net price and zero enrollment remain investigation flags, not proven errors. Matching missingness patterns are not evidence that Pell and loan values are identical. Whole-universe coverage cutoffs do not establish applicability or usable historical windows.

## Stream C preservation and review

Before edits, the entire supplied stream script was copied byte-for-byte to `Docs/audit/04_streams_before_audit.R.txt`; SHA256 `7A44874F7A180B96ABD7119ABE7B75E38ABB4E6DC0D62D0271511CD08C7C3147`. No existing stream outputs were present, so none were overwritten. The original C4 formula and plot were reviewed against the common-population requirement before correction. C1–C3 core index definitions, sample selection and outputs remain; changes are the descriptive C1 chart title, safe top-list slicing, reproducible C2 tie handling, shared preflight and C4 diagnostic. The teammate should review this narrow difference before presentation. There is no claim that unchanged ordering proves robustness. The original implementation is available for comparison without a Git commit.

## Files changed or added

Changed: `EDA/scripts/00_common.R`, `02_build_simplified_data.R`, `03_eda_quality_report.R`, and supplied `04_streams.R`; README and existing EDA/guide/plan documentation have audit notices/corrections. Script 01's functioning implementation was retained. Existing generated statistical CSVs/PNGs were preserved because source data are absent; EDA_SUMMARY carries a stale-output warning rather than invented regenerated statistics.

Added: this report; `Docs/STUDENT_EXPLANATION.md` (Windows resolves requested `docs/` to existing `Docs/`); the five requested files in `presentation/`; `Docs/audit/04_streams_before_audit.R.txt`, `validate.R`, `validation_log.txt`, and `pipeline_attempts.txt`.

## What was reproduced and what remains unverified

R 4.5.2 and all five required packages are installed. All five scripts parse. Official dictionary decoding, missing-token/ID behavior and nonpositive denominator handling passed direct checks. All A/B/C/D stream code executed on isolated synthetic fixtures, including panel-free paths. Regression checks confirm valid-Pell quartile counts/boundaries, common-set rank invariance, paired income means and explicit endpoint membership. See validation_log for exact output; synthetic figures never entered EDA/figures.

Saved audit percentages, token subtotals and pairwise Jaccard arithmetic were checked. One ALIAS count partition fails; corrected code needs raw-data regeneration to resolve the actual token identities. Saved coverage refutes the narrow-window assertion but cannot replace source-file verification. Existing charts were reviewed through their source/filter/axis definitions; their point/bar values cannot be reconstructed from missing row-level data.

All four real pipeline entry points were attempted and returned missing-input errors, recorded in pipeline_attempts.txt. Raw institution/program/yearly files and simplified extracts are absent. Thus no corrected institution-level stream findings, rankings, sample sizes, quartile boundaries, disappearance rates, anomaly counts, updated quality tiers or chart values are independently reproduced. There are no local real-data stream outputs. The assignment's stated archive stops at 2023 while the saved release metadata claims files through 2025; distinguish the historical assignment wording from the group's later claimed release, and verify the latter when the source files return.

## Remaining work and run commands

See `presentation/WORK_DIVISION.md` for exact tasks: A restores/rebuilds data and presents cleaning, quality and access; B verifies recodes, paired affordability and D quality; C reviews the preserved teammate work, runs outcomes and synthesizes. Each has three slides/five minutes. No permission or confirmation is needed to continue the documented local rebuild once data are restored.

From the repository root, run Rscript scripts 01, 02, 03 and 04 in order using the full installed R path; exact PowerShell commands, chart mappings and extract-only alternatives are in `presentation/REPRODUCIBILITY.md`. Review old/new report differences and fill every pending number before presenting.

## Does this satisfy the four original goals?

| Goal | Assessment |
| --- | --- |
| 1. Read/clean | Implemented; dictionary/helpers checked; actual current raw-to-extract execution blocked |
| 2. Quality | Implemented and saved-artifact arithmetic audited; corrected full raw audit still required |
| 3. Recode | Implemented; formulas/reasons documented and targeted behavior tested; regenerate extracts |
| 4. Relationships | Four streams preserved, targeted defects repaired and synthetic execution tested; empirical findings/figures and presenter review still required |

The repository now provides a defensible implementation and presentation plan. It is **not ready to claim full empirical completion** until the missing data are restored, corrected outputs reproduced and actual findings entered.
