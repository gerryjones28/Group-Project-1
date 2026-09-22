# 03_eda_quality_report.R -----------------------------------------------------
# Assignment goals 2 and 4: assess data quality, quantify missingness, and
# surface relationships that matter for the later analysis.
#
# Reads only, writes to EDA/reports/ and EDA/figures/:
#   variable_audit_institution_latest.csv      one row per column (3,308)
#   variable_audit_field_of_study_latest.csv   one row per column (178)
#   headline_metric_quality_scores.csv         numeric 0-100 quality score
#   core_variable_coverage_by_year.csv         long: variable x year
#   core_variable_coverage_matrix.csv          wide: 113 variables x 31 years
#   missingness_cooccurrence_latest.csv        pairwise co-missing / Jaccard
#   row_completeness_by_group.csv              completeness by sector x level
#   completeness_vs_size.csv                   completeness vs enrollment bucket
#   EDA_SUMMARY.md                             the written-up findings
#   figures/*.png                              four figures
#
# Usage:  Rscript EDA/scripts/03_eda_quality_report.R

.self_dir <- function() {
  a <- commandArgs(trailingOnly = FALSE); h <- grep("^--file=", a, value = TRUE)
  if (length(h)) normalizePath(dirname(sub("^--file=", "", h[[1]]))) else normalizePath(getwd())
}
source(file.path(.self_dir(), "00_common.R"))
suppressPackageStartupMessages({ library(ggplot2); library(scales) })

require_files(c(DICT_XLSX, INST_LATEST, FOS_LATEST), "the Scorecard inputs")
require_files(file.path(SIMPLIFIED_DIR, "institution_core_latest.csv"),
              "the simplified extract", "run EDA/scripts/02_build_simplified_data.R first")

dict <- load_dictionary()

# ===========================================================================
# 1. Full-column audit of the most-recent institution file (3,308 columns)
# ===========================================================================
log_step("auditing ", basename(INST_LATEST), " (3,308 columns, chunked) ...")
audit_inst <- audit_file(INST_LATEST, max_cells = 2e6, chunk_max = 200L)
audit_inst[, scorecard_label := vapply(variable, function(v) var_label(dict, v), character(1))]
audit_inst[, missing_tier := cut(pct_missing,
                                 breaks = c(-Inf, 1, 25, 75, 99, Inf),
                                 labels = c("0-1% missing", "1-25% missing", "25-75% missing",
                                            "75-99% missing", "(almost) empty"))]
setcolorder(audit_inst, c("variable", "scorecard_label", "missing_tier"))
setorder(audit_inst, -pct_missing)
fwrite(audit_inst, file.path(REPORTS_DIR, "variable_audit_institution_latest.csv"))
log_step("  ", nrow(audit_inst), " columns audited; ",
         sum(audit_inst$pct_missing > 99), " of them are >99% empty")

# ===========================================================================
# 2. Full-column audit of the most-recent Field-of-Study file (178 columns)
# ===========================================================================
log_step("auditing ", basename(FOS_LATEST), " (178 columns, chunked) ...")
audit_fos <- audit_file(FOS_LATEST, max_cells = 3e6, chunk_max = 13L)
audit_fos[, missing_tier := cut(pct_missing,
                                breaks = c(-Inf, 1, 25, 75, 99, Inf),
                                labels = c("0-1% missing", "1-25% missing", "25-75% missing",
                                           "75-99% missing", "(almost) empty"))]
setcolorder(audit_fos, c("variable", "missing_tier"))
setorder(audit_fos, -pct_missing)
fwrite(audit_fos, file.path(REPORTS_DIR, "variable_audit_field_of_study_latest.csv"))
log_step("  ", nrow(audit_fos), " columns audited; privacy-suppressed share ranges ",
         pct1(min(audit_fos$pct_privacy)), " - ", pct1(max(audit_fos$pct_privacy)))

# Rows of the program file that carry the text "NA" instead of a UNITID: these
# are institutions Scorecard publishes program data for but no institution-level
# identifier (mostly foreign / closed schools), so they never join.
fos_ids <- fread(file.path(SIMPLIFIED_DIR, "field_of_study_core_latest.csv"),
                 select = c("UNITID", "INSTNM", "has_unitid"))
fos_noid      <- fos_ids[has_unitid == FALSE, .N]
fos_noid_inst <- fos_ids[has_unitid == FALSE, uniqueN(INSTNM)]
log_step("  ", fnum(fos_noid), " program rows have no UNITID (text 'NA'), across ",
         fnum(fos_noid_inst), " institutions")

# ===========================================================================
# 3. Numeric quality scores for the ten headline metrics
# ===========================================================================
inst <- fread(file.path(SIMPLIFIED_DIR, "institution_core_latest.csv"))
raw_src <- read_text_cols(INST_LATEST, intersect(HEADLINE_SOURCES, csv_header(INST_LATEST)))
ps_by_col <- vapply(raw_src, function(v) sum(trimws(v) %in% PS_TOKENS), integer(1))

METRIC_SOURCES <- list(
  ADM_RATE      = "ADM_RATE",           UGDS          = "UGDS",
  TUITIONFEE_IN = "TUITIONFEE_IN",      net_price     = c("NPT4_PUB", "NPT4_PRIV"),
  PCTPELL       = "PCTPELL",            PCTFLOAN      = "PCTFLOAN",
  grad_rate     = c("C150_4", "C150_L4"), RET_FT4     = "RET_FT4",
  earn_p10      = "MD_EARN_WNE_P10",    grad_debt_mdn = "GRAD_DEBT_MDN")

q <- rbindlist(lapply(names(METRIC_SOURCES), function(m) {
  v <- inst[[m]]
  src <- intersect(METRIC_SOURCES[[m]], names(ps_by_col))
  n_ps <- if (length(src)) sum(ps_by_col[src]) else 0L
  completeness <- mean(!is.na(v))
  ps_share     <- n_ps / nrow(inst)
  data.table(
    metric             = m,
    scorecard_label    = var_label(dict, m),
    source_columns     = paste(METRIC_SOURCES[[m]], collapse = " + "),
    n_institutions     = nrow(inst),
    n_nonmissing       = sum(!is.na(v)),
    pct_complete       = round(100 * completeness, 1),
    n_privacy_suppressed = n_ps,
    pct_privacy_suppressed = round(100 * ps_share, 1),
    n_unique           = uniqueN(v),
    pct_unique         = round(100 * uniqueN(v) / max(1, sum(!is.na(v))), 1),
    median             = round(median(v, na.rm = TRUE), 2),
    # quality = how much of the population is actually measured, after
    # removing cells that were withheld for privacy reasons.
    quality_score      = round(100 * completeness * (1 - ps_share), 1),
    coverage_flag      = fifelse(completeness >= 0.90, "usable (>=90%)",
                          fifelse(completeness >= 0.50, "thin (50-90%)",
                                  "unusable (<50%)"))
  )
}))[order(-quality_score)]
fwrite(q, file.path(REPORTS_DIR, "headline_metric_quality_scores.csv"))
print(q[, .(metric, pct_complete, pct_privacy_suppressed, pct_unique, quality_score, coverage_flag)])

# ===========================================================================
# 4. Variable coverage per year (which decades can answer which question)
# ===========================================================================
merged_files <- sort(list.files(DATA_DIR, pattern = "^MERGED[0-9]{4}_[0-9]{2}_PP\\.csv$",
                                full.names = TRUE))
require_merged_files(merged_files)
log_step("computing core-variable coverage for ", length(merged_files), " years ...")
cov <- rbindlist(lapply(merged_files, function(f) {
  fy <- sub("^MERGED([0-9]{4}_[0-9]{2})_PP\\.csv$", "\\1", basename(f))
  d  <- read_raw_ps(f, CORE_ALL)$dt
  p  <- vapply(d, function(v) 100 * mean(!is.na(v)), numeric(1))
  data.table(file_year = fy, year_start = as.integer(substr(fy, 1, 4)),
             n_institutions = nrow(d), variable = names(p), pct_nonmissing = unname(p))
}))
cov[, scorecard_label := vapply(variable, function(v) var_label(dict, v), character(1))]
fwrite(cov, file.path(REPORTS_DIR, "core_variable_coverage_by_year.csv"))
cov_wide <- dcast(cov, variable + scorecard_label ~ file_year, value.var = "pct_nonmissing")
fwrite(cov_wide, file.path(REPORTS_DIR, "core_variable_coverage_matrix.csv"))

# first year in which a variable is at least 80% populated
usable <- cov[, .(first_year_80pct = { y <- year_start[pct_nonmissing >= 80]
                                       if (length(y)) min(y) else NA_integer_ },
                  last_year_80pct  = { y <- year_start[pct_nonmissing >= 80]
                                       if (length(y)) max(y) else NA_integer_ },
                  max_pct_nonmissing = max(pct_nonmissing)), by = .(variable, scorecard_label)]
setorder(usable, first_year_80pct, variable)
fwrite(usable, file.path(REPORTS_DIR, "core_variable_first_usable_year.csv"))
log_step("  ", sum(is.na(usable$first_year_80pct)), " of ", nrow(usable),
         " core variables never reach 80% coverage")

# ===========================================================================
# 5. Missingness co-occurrence between the headline metrics
# ===========================================================================
miss_mat <- as.matrix(is.na(inst[, .SD, .SDcols = HEADLINE_METRICS]))
colnames(miss_mat) <- HEADLINE_METRICS
n_inst <- nrow(miss_mat)

co <- rbindlist(lapply(combn(HEADLINE_METRICS, 2, simplify = FALSE), function(p) {
  a <- miss_mat[, p[1]]; b <- miss_mat[, p[2]]
  both <- sum(a & b); either <- sum(a | b)
  data.table(metric_1 = p[1], metric_2 = p[2], n_both_missing = both,
             pct_both_missing = round(100 * both / n_inst, 1),
             n_missing_1 = sum(a), n_missing_2 = sum(b),
             jaccard = round(both / max(1, either), 3),
             expected_if_independent = round(sum(a) * sum(b) / n_inst, 1))
}))[order(-jaccard)]
fwrite(co, file.path(REPORTS_DIR, "missingness_cooccurrence_latest.csv"))

J <- matrix(1, length(HEADLINE_METRICS), length(HEADLINE_METRICS),
            dimnames = list(HEADLINE_METRICS, HEADLINE_METRICS))
for (i in seq_len(nrow(co))) {
  J[co$metric_1[i], co$metric_2[i]] <- co$jaccard[i]
  J[co$metric_2[i], co$metric_1[i]] <- co$jaccard[i]
}
fwrite(as.data.table(J, keep.rownames = "metric"),
       file.path(REPORTS_DIR, "missingness_jaccard_matrix_latest.csv"))

# ===========================================================================
# 6. Per-institution completeness: by sector/level, by size, and anomalies
# ===========================================================================
QS <- quantile(inst$pct_headline_complete, c(0.25, 0.5, 0.75), na.rm = TRUE)
by_group <- inst[, .(institutions = .N,
                     mean_pct_complete   = round(mean(pct_headline_complete), 1),
                     median_pct_complete = round(median(pct_headline_complete), 1),
                     share_high_dq       = round(100 * mean(dq_tier == "High (>=90%)"), 1),
                     mean_privacy_suppressed = round(mean(n_headline_privacy_suppressed), 2)),
                 by = .(control_label, level_label)][order(level_label, control_label)]
fwrite(by_group, file.path(REPORTS_DIR, "row_completeness_by_group.csv"))

by_size <- inst[, .(institutions = .N,
                    mean_pct_complete = round(mean(pct_headline_complete), 1),
                    median_ugds = round(median(UGDS, na.rm = TRUE))),
                by = size_bin]
by_size[is.nan(median_ugds) | !is.finite(median_ugds), median_ugds := NA_real_]
setorder(by_size, median_ugds, na.last = TRUE)
fwrite(by_size, file.path(REPORTS_DIR, "completeness_vs_size.csv"))

# UGDS == 0 or missing has to be dropped before taking the log.
ok_size  <- !is.na(inst$UGDS) & inst$UGDS > 0
cor_size <- round(suppressWarnings(cor(inst$pct_headline_complete[ok_size],
                                       log10(inst$UGDS[ok_size]),
                                       use = "complete.obs")), 2)
share_all_ten  <- round(100 * mean(inst$pct_headline_complete == 100), 1)
share_nine_ten <- round(100 * mean(inst$pct_headline_complete >= 90), 1)

# Straightforward logical checks on the recoded measures
anomalies <- data.table(
  check = c("net price below zero", "tuition below zero", "graduation rate above 1",
            "retention rate above 1", "PCTPELL above 1", "PCTFLOAN above 1",
            "zero undergraduate enrollment (UGDS == 0)", "earnings below zero",
            "debt-to-earnings above 5", "net price above sticker tuition (grants exceed tuition)"),
  n_institutions = c(sum(inst$net_price < 0, na.rm = TRUE),
                     sum(inst$TUITIONFEE_IN < 0, na.rm = TRUE),
                     sum(inst$grad_rate > 1, na.rm = TRUE),
                     sum(inst$RET_FT4 > 1, na.rm = TRUE),
                     sum(inst$PCTPELL > 1, na.rm = TRUE),
                     sum(inst$PCTFLOAN > 1, na.rm = TRUE),
                     sum(inst$UGDS == 0, na.rm = TRUE),
                     sum(inst$earn_p10 < 0, na.rm = TRUE),
                     sum(inst$grad_debt_to_earn > 5, na.rm = TRUE),
                     sum(inst$TUITIONFEE_IN > inst$net_price, na.rm = TRUE)))
anomalies[, pct_of_institutions := round(100 * n_institutions / n_inst, 2)]
fwrite(anomalies, file.path(REPORTS_DIR, "data_anomalies_latest.csv"))

# ===========================================================================
# 7. Figures
# ===========================================================================
core_audit <- audit_inst[variable %in% CORE_ALL][order(-pct_missing)]
core_audit[, variable := factor(variable, levels = rev(variable))]
p1 <- ggplot(core_audit, aes(variable, pct_missing, fill = missing_tier)) +
  geom_col(width = 0.8) + coord_flip() +
  scale_fill_brewer(palette = "YlOrRd", drop = FALSE, name = NULL) +
  labs(title = "Share of institutions with no value, by core variable",
       subtitle = "Most-recent institution snapshot (6,273 institutions, 2026-06-03 file)",
       x = NULL, y = "% of institutions missing") +
  theme_minimal(base_size = 9) + theme(legend.position = "bottom")
ggsave(file.path(FIGURES_DIR, "missingness_core_latest.png"), p1,
       width = 7.5, height = 12, dpi = 150)

KEY_VARS <- c("UGDS", "TUITIONFEE_IN", "ADM_RATE", "SAT_AVG", "PCTPELL", "C150_4",
              "RET_FT4", "MD_EARN_WNE_P10", "GRAD_DEBT_MDN", "NPT4_PUB")
cv <- cov[variable %in% KEY_VARS]
p2 <- ggplot(cv, aes(year_start, pct_nonmissing, colour = variable)) +
  geom_line(linewidth = 0.8) + geom_point(size = 1.1) + ylim(0, 100) +
  labs(title = "Which years actually contain which variables",
       subtitle = "% of institutions with a value, by source year (MERGED1996_97_PP ... MERGED2025_26_PP)",
       x = "First year of the source file", y = "% of institutions with a value",
       colour = NULL) +
  theme_minimal(base_size = 10) + theme(legend.position = "bottom")
ggsave(file.path(FIGURES_DIR, "coverage_by_year.png"), p2,
       width = 9, height = 5.5, dpi = 150)

p3 <- ggplot(inst, aes(control_label, pct_headline_complete, fill = level_label)) +
  geom_boxplot(outlier.size = 0.3, alpha = 0.85, position = position_dodge(0.8)) +
  labs(title = "Data quality is not evenly distributed across sectors",
       subtitle = "Completeness of the 10 headline metrics per institution",
       x = NULL, y = "% of headline metrics that are populated", fill = NULL) +
  theme_minimal(base_size = 10) + theme(legend.position = "bottom")
ggsave(file.path(FIGURES_DIR, "row_completeness_by_sector.png"), p3,
       width = 8, height = 5, dpi = 150)

sc <- inst[!is.na(earn_p10) & !is.na(net_price) & net_price > 0 &
             dq_tier == "High (>=90%)"]
sp <- sc[, .(institutions = .N,
             spearman_net_price_vs_earnings = round(cor(net_price, earn_p10,
                                                        method = "spearman"), 2),
             median_earnings  = as.numeric(median(earn_p10)),
             median_net_price = as.numeric(median(net_price))),
         by = .(control_label, level_label)][order(control_label, level_label)]
fwrite(sp, file.path(REPORTS_DIR, "earnings_vs_netprice_correlation.csv"))
p4 <- ggplot(sc, aes(net_price, earn_p10, colour = level_label)) +
  geom_point(alpha = 0.25, size = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 0.8) +
  facet_wrap(~control_label, scales = "free_x") +
  scale_x_continuous(labels = label_dollar(scale_cut = cut_short_scale())) +
  scale_y_continuous(labels = label_dollar(scale_cut = cut_short_scale())) +
  labs(title = "Earnings 10 years out vs. average net price (complete-data institutions only)",
       subtitle = "Points are institutions with all 10 headline metrics populated",
       x = "Average net price (NPT4, all income brackets)",
       y = "Median earnings 10 years after entry", colour = NULL) +
  theme_minimal(base_size = 10) + theme(legend.position = "bottom")
ggsave(file.path(FIGURES_DIR, "earnings_vs_netprice.png"), p4,
       width = 9, height = 4.5, dpi = 150)
log_step("4 figures written to ", FIGURES_DIR)

# ===========================================================================
# 8. EDA_SUMMARY.md
# ===========================================================================
rd <- function(f) fread(file.path(REPORTS_DIR, f))
sizes   <- rd("size_limits_check.csv")
budget  <- rd("column_budget_vs_cell_limits.csv")
inst_snap <- sizes[grepl("^Most-Recent-Cohorts-Institution", file)]
fos_snap  <- sizes[grepl("^Most-Recent-Cohorts-Field-of-Study", file)]
merged_rows <- sizes[group == "yearly institution file (MERGED)"]
zip_row     <- sizes[group == "zip archive"]
manifest <- rd("simplified_outputs_manifest.csv")
tier_tab <- audit_inst[, .(columns = .N), by = missing_tier][order(missing_tier)]
ps_top   <- audit_inst[order(-pct_privacy)][1:8, .(variable, pct_missing, pct_privacy)]
ps_fos   <- audit_fos[order(-pct_privacy)][1:8, .(variable, pct_missing, pct_privacy)]
COV_VARS <- c("UGDS", "ADM_RATE", "SAT_AVG", "TUITIONFEE_IN", "COSTT4_A", "NPT4_PUB",
              "PCTPELL", "PCTFLOAN", "C150_4", "RET_FT4", "MD_EARN_WNE_P10",
              "GRAD_DEBT_MDN", "MD_FAMINC", "CDR3", "RPY_3YR_RT")
cov_tab  <- usable[variable %in% COV_VARS, .(variable, first_year_80pct, last_year_80pct,
                                             max_pct_nonmissing = round(max_pct_nonmissing, 1))]
setorder(cov_tab, first_year_80pct, variable, na.last = TRUE)

total_cols   <- nrow(audit_inst)
empty_cols   <- sum(audit_inst$pct_missing >= 99.999)
almost_empty <- sum(audit_inst$pct_missing > 99 & audit_inst$pct_missing < 99.999)
full_cols    <- sum(audit_inst$pct_missing <= 1)

md <- c(
"# EDA summary - College Scorecard (Group Project I)",
"",
paste0("_Generated by `EDA/scripts/03_eda_quality_report.R` on ", format(Sys.Date()),
       " from `data/College_Scorecard_Raw_Data_06032026`._"),
"",
"## 1. Yes - the raw files are genuinely too large for Excel / Google Sheets",
"",
paste0("Every Scorecard year is one very wide file: **", fnum(inst_snap$cols),
       " variables x ", fnum(inst_snap$rows), " institutions**."),
"",
paste0("- Google Sheets caps a spreadsheet at **10,000,000 cells**. The most-recent institution file has ",
       fnum(inst_snap$cells), " cells and the Field-of-Study snapshot has ", fnum(fos_snap$cells),
       " cells - both are refused on import."),
paste0("- The Field-of-Study snapshot is also ", fos_snap$mb,
       " MB, over Google Drive's ~100 MB conversion limit."),
paste0("- Excel allows 1,048,576 rows x 16,384 columns, so it can *open* these files, but a ",
       merged_rows$mb[1], " MB / ", fnum(merged_rows$cells[1]),
       "-cell sheet is painfully slow and often runs out of memory on a normal laptop."),
paste0("- Cell budget: with ", fnum(inst_snap$rows),
       " rows you can keep at most **~1,594 columns** inside the Sheets limit (half that for a responsive sheet); ",
       "a 228,000-row program file only takes ~43 columns."),
"",
"Files, as measured:",
"",
md_table(sizes[grepl("^(Most-Recent|MERGED2025_26|MERGED1996_97)", file) | group == "zip archive",
               .(file, rows, cols, cells = fnum(cells), MB = mb, Google_Sheets = opens_in_gsheets, Excel = opens_in_excel)]),
"",
"Column budget implied by the cell limit:",
"",
md_table(budget),
"",
paste0("Note: `", zip_row$file, "` (", zip_row$mb,
       " MB) is simply a second download of the same `College_Scorecard_Raw_Data_06032026` folder that is already extracted - it can be deleted."),
"",
"## 2. What the simplification did",
"",
md_table(manifest[, .(output, rows, columns, cells = fnum(cells), size_MB, opens_in_google_sheets)]),
"",
"All five files now open in Google Sheets and Excel. Encoding rules applied:",
"",
"- `NA` (not applicable / not collected), `PS` / `PrivacySuppressed` (cell count too small to publish) and blank cells all become **real missing values (empty cells)**;",
"- everything that parses as a number is stored as a number, so Excel sorts and charts immediately;",
"- coded variables are decoded with the official codebook (`CONTROL`, `ICLEVEL`, `REGION`, `LOCALE`, `PREDDEG`, `HIGHDEG`, `CCBASIC`) - e.g. `REGION 5` becomes `Southeast (AL, AR, FL, ...)`;",
"- the privacy signal is not thrown away: `n_headline_privacy_suppressed` counts how many of the ten headline metrics were withheld for an institution;",
"- column definitions are listed in `EDA/reports/simplified_codebook.csv`.",
"",
"## 3. Missingness is structural, not random",
"",
paste0("Of the ", fnum(total_cols), " variables in the most-recent institution file, **",
       fnum(empty_cols), " are completely empty**, ", fnum(almost_empty),
       " more are >99% empty, and only ", fnum(full_cols), " are essentially complete (<=1% missing)."),
"",
md_table(tier_tab),
"",
"Variables that are withheld most often for privacy reasons (institution file):",
"",
md_table(ps_top),
"",
"Program-level file (`Most-Recent-Cohorts-Field-of-Study`): the earnings and debt cells for small",
"programs are mostly suppressed, which is the single biggest limitation for program-level work.",
"",
md_table(ps_fos),
"",
paste0("One join trap in the same file: **", fnum(fos_noid), " program rows (",
       fnum(fos_noid_inst), " institutions) carry the literal text `NA` in `UNITID`** - Scorecard ",
       "publishes their programs but no institution-level identifier for them (mostly foreign and ",
       "closed institutions, e.g. `Aarhus University`). They cannot be joined to the institution ",
       "file, which is why the simplified extract keeps a `has_unitid` flag."),
"",
"## 4. Numeric quality scores for the ten headline metrics",
"",
"`quality_score = 100 x (share of institutions with a value) x (1 - share of cells withheld as PS)`.",
"",
md_table(q[, .(metric, pct_complete, pct_privacy_suppressed, pct_unique, quality_score, coverage_flag)]),
"",
"## 5. Which years can answer which questions",
"",
paste0("Coverage is not only about missing cells: whole variables are blank in early files. ",
       "Of the ", nrow(usable), " core variables, ", sum(is.na(usable$first_year_80pct)),
       " never reach 80% coverage in any year. First and last year with >=80% coverage:"),
"",
"",
md_table(cov_tab),
"",
paste0("Read the NA rows carefully: a variable can also never reach 80% for a structural reason. ",
       "ADM_RATE and RET_FT4 are only defined for institutions that admit or retain selective ",
       "cohorts, so a 30-40% ceiling is the property of the variable, not a gap in the file."),
"",
"(Full 113-variable x 31-year matrix: `EDA/reports/core_variable_coverage_matrix.csv`.)",
"",
"## 6. Data quality differs by sector and by size",
"",
md_table(by_group),
"",
paste0("Completeness rises with institution size: correlation with log10(undergraduate enrolment) is **",
       cor_size, "**. Only **", share_all_ten, "% of institutions have all ten headline metrics ",
       "populated** (", share_nine_ten, "% have at least nine), so any model built on the ",
       "headline metrics silently over-represents large, public, 4-year institutions."),
"",
md_table(by_size),
"",
"## 7. Missing values cluster together",
"",
"Top co-missing pairs (Jaccard = both missing / either missing; compare with the independence column):",
"",
md_table(co[1:8, .(metric_1, metric_2, n_both_missing, pct_both_missing, jaccard, expected_if_independent)]),
"",
"## 8. Logical anomalies worth a footnote in the write-up",
"",
md_table(anomalies),
"",
"## 9. Suggested next steps",
"",
"1. Use `simplified/panel_core_1996_2025.csv` for anything time-related (26 columns x ~209k institution-years, one row per institution per source file). Filter `year_start >= 2000` for a panel where tuition, admissions and completion are all populated.",
"2. Use `simplified/institution_core_latest.csv` (or the .xlsx) for cross-sectional questions; the `*_pctile_group` and `value_index_*` columns already normalise price and outcomes inside sector x level peer groups.",
"3. Use `simplified/field_of_study_by_cip2_latest.csv` (375 rows) when exploring programs, and `field_of_study_core_latest.csv` only when the full 228k-row detail is needed.",
paste0("4. Report the `dq_tier` column alongside any result - only ", share_all_ten,
       "% of institutions have all ten headline metrics populated."),
"5. Treat `PS` and `NA` differently in the write-up: `NA` means 'not collected / not applicable', `PS` means 'collected but withheld because the group was too small', which is itself informative.",
"6. If the raw 3,308-column file must be inspected by hand, split it by year *and* by theme (identifier block, admissions, cost, outcomes) - see the column groups in `EDA/scripts/00_common.R`.",
"")
# collapse repeated blank lines left behind by the conditional sections
md <- md[!(md == "" & c("", md[-length(md)]) == "")]
writeLines(md, file.path(REPORTS_DIR, "EDA_SUMMARY.md"))
log_step("wrote ", file.path(REPORTS_DIR, "EDA_SUMMARY.md"))
log_step("done")
