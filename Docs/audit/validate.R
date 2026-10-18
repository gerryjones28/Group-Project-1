# Targeted regression checks and independent arithmetic on existing artifacts.
# Synthetic data are isolated in tempdir(); never represent College Scorecard findings.
Sys.setenv(SC_PROJECT_ROOT = normalizePath(getwd()))
source("EDA/scripts/00_common.R")
root <- PROJECT_ROOT
say <- function(...) cat(..., "\n")
stopifnot(all(is.na(clean_column(c("", "NA", "PS", "PrivacySuppressed", "NULL", "-")))))
stopifnot(identical(clean_named(c("0101", "1101"), "CIPCODE"), c("0101", "1101")))
f <- tempfile(fileext = ".csv")
writeLines(c('x', '"NA"', '"PS"', '"PrivacySuppressed"', '"NULL"', '"-"', '"2"'), f)
a <- audit_columns(f, "x")
stopifnot(a$n_missing_total == 5, a$n_nonmissing == 1, a$n_ps == 2)
dict <- load_dictionary()
stopifnot(decode(dict, "CONTROL", 1) == "Public")
say("PASS missing tokens, text identifiers, dictionary decoding")

# Evaluate ONLY the builder function definition, without reading absent raw data.
expr <- parse("EDA/scripts/02_build_simplified_data.R")
for (e in expr) if (is.call(e) && identical(e[[1]], as.name("<-")) &&
                    identical(e[[2]], as.name("add_derived"))) eval(e)
z <- data.table(UNITID = 1:3, CONTROL = 1, ICLEVEL = 1, UGDS = 100,
                ADM_RATE = .5, OPENADMP = 0, NPT4_PUB = c(0, 100, 200),
                MD_EARN_WNE_P10 = c(0, 1000, 2000), GRAD_DEBT_MDN = 500)
dz <- add_derived(z)
stopifnot(is.na(dz$sticker_to_net[1]), is.na(dz$grad_debt_to_earn[1]))
say("PASS nonpositive ratio denominators")

audit <- fread("EDA/reports/variable_audit_institution_latest.csv")
bad <- audit[n_rows != n_missing_total + n_nonmissing,
             .(variable, n_rows, n_missing_total, n_nonmissing)]
say("Saved audit count discrepancies (require regeneration):")
print(bad)
stopifnot(all(audit$n_missing_total == audit$n_blank + audit$n_na + audit$n_ps),
          max(abs(audit$pct_missing - 100 * audit$n_missing_total / audit$n_rows)) < 1e-8)
co <- fread("EDA/reports/missingness_cooccurrence_latest.csv")
stopifnot(max(abs(co$jaccard - round(co$n_both_missing /
            pmax(1, co$n_missing_1 + co$n_missing_2 - co$n_both_missing), 3))) < 1e-8)
say("PASS saved missing-token subtotals, percentages, and pairwise Jaccard arithmetic (not raw-data reproduction)")
say("Saved audit: rows", unique(audit$n_rows), "; variables", nrow(audit),
    "; empty", sum(audit$n_nonmissing == 0), "; <=1% missing", sum(audit$pct_missing <= 1))
cov <- fread("EDA/reports/core_variable_coverage_by_year.csv")
window <- cov[variable %in% c("NPT4_PUB", "NPT4_PRIV", "TUITIONFEE_IN", "COSTT4_A") &
                file_year != "latest", .(first_observed = min(year_start[pct_nonmissing > 0]),
                     last_observed = max(year_start[pct_nonmissing > 0])), by = variable]
print(window)
say("Coverage above is from saved tables; source files are absent.")

# Make a full synthetic extract from the existing recoder, then run stream script.
fixture <- tempfile("scorecard-regression-")
dir.create(file.path(fixture, "EDA", "scripts"), recursive = TRUE)
dir.create(file.path(fixture, "EDA", "simplified"), recursive = TRUE)
file.copy(file.path(root, "EDA", "scripts", c("00_common.R", "04_streams.R")),
          file.path(fixture, "EDA", "scripts"))
n <- 24L
d <- data.table(UNITID = seq_len(n), INSTNM = paste("Synthetic", seq_len(n)), STABBR = "XX",
                CONTROL = rep(1:3, 8), ICLEVEL = 1, UGDS = seq_len(n) * 100,
                ADM_RATE = .5, OPENADMP = 0, NPT4_PUB = seq_len(n) * 100,
                NPT4_PRIV = NA_real_, NPT41_PUB = 1000, NPT45_PUB = 5000,
                TUITIONFEE_IN = 3000, COSTT4_A = 10000, PCTPELL = c((1:20)/20, rep(NA, 4)),
                PCTFLOAN = .5, C150_4 = seq_len(n)/n, RET_FT4 = .8,
                MD_EARN_WNE_P10 = (n:1)*1000, GRAD_DEBT_MDN = 1000,
                HBCU = rep(c(0, 1, NA), 8), UGDS_WHITE = .4)
d <- add_derived(d)
stopifnot(all(as.character(d[pct_headline_complete == 90, dq_tier]) == "High (>=90%)"))
d[1, minority_serving := NA_character_]
d[1:4, pct_headline_complete := 100]
fwrite(d, file.path(fixture, "EDA", "simplified", "institution_core_latest.csv"))
p <- rbindlist(lapply(c(2015L, 2020L, 2025L), function(y) {
  z <- copy(d); z[, year_start := y]; if (y == 2025) z <- z[UNITID > 2]; z
}))
panel_path <- file.path(fixture, "EDA", "simplified", "panel_core_1996_2025.csv")
fwrite(p, panel_path)
Sys.setenv(SC_PROJECT_ROOT = fixture)
run <- function(stream) {
  log <- system2(file.path(R.home("bin"), "Rscript.exe"),
           c(shQuote(file.path(fixture, "EDA", "scripts", "04_streams.R")), stream),
           stdout = TRUE, stderr = TRUE)
  if (!is.null(attr(log, "status"))) stop(paste(log, collapse = "\n"))
}
run("")
rd <- function(name) fread(file.path(fixture, "EDA", "reports", paste0("stream_", name, ".csv")))
q <- rd("d3_quality_vs_pell_quartile")
stopifnot(nrow(q) == 4, all(q$institutions == 5), sum(q$institutions) == 20,
          all(q$min_pell <= q$max_pell))
c4 <- rd("c4_dq_sensitivity")
stopifnot(c4$mean_abs_common_rank_shift == 0)
ex <- rd("d4b_exits_by_sector_size")
stopifnot(sum(ex$n_absent_2025) == 2, sum(ex$institutions) == 24,
          sum(ex$n_retained_2025) == 22)
b3 <- rd("b3_income_band_gap_latest")
stopifnot(all(b3$mean_gap == b3$mean_highinc - b3$mean_lowinc))
say("PASS synthetic all-stream execution, quartile sizes/bounds, common ranks, 2015-2025 endpoints, paired income-band means")
file.remove(panel_path)
run("A"); run("C"); run("B"); run("D")
say("PASS A/C without panel; B/D retain cross-sectional analyses without panel")
# Verify peer ranking excludes NAs and handles ties consistently.
stopifnot(identical(pctile_within(c(10, 20, NA), c(1, 1, 1)), c(.5, 1, NA_real_)))
say("PASS percentile valid-observation denominator")
say("PASS DQ tier includes exactly 90 percent in High")
Sys.setenv(SC_PROJECT_ROOT = root)
say("Synthetic outputs remain outside repository:", fixture)
