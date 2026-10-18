# 02_build_simplified_data.R --------------------------------------------------
# Turns the 3,308-column / 100-150 MB raw Scorecard files into small, typed,
# codebook-decoded extracts that open in Excel and Google Sheets.
#
# Writes to EDA/simplified/:
#   institution_core_latest.csv / .xlsx   ~120 columns x 6,273 institutions
#   field_of_study_core_latest.csv        ~23 columns x 227,980 programs
#   field_of_study_by_cip2_latest.csv     ~500 rows (CIP family x credential)
#   panel_core_1996_2025.csv              ~26 columns x ~210,000 institution-years
#   Column names/definitions are appended to EDA/reports/simplified_codebook.csv
#
# Design rules
#   * only the columns we actually use are read (fread select=), so peak memory
#     stays in the tens of MB even though the source files are 100-150 MB;
#   * "NA" / "PS" / "PrivacySuppressed" / blank -> real NA; remaining values are
#     converted to numeric when the whole column parses as numbers;
#   * coded columns (CONTROL, ICLEVEL, REGION, LOCALE, PREDDEG, HIGHDEG, CCBASIC)
#     are decoded with the official codebook instead of being hard-coded;
#   * CSVs are written with blank cells for missing (na = "") so Excel/Sheets
#     show empty cells rather than the text "NA".
#
# Usage:  Rscript EDA/scripts/02_build_simplified_data.R

.self_dir <- function() {
  a <- commandArgs(trailingOnly = FALSE); h <- grep("^--file=", a, value = TRUE)
  if (length(h)) normalizePath(dirname(sub("^--file=", "", h[[1]]))) else normalizePath(getwd())
}
source(file.path(.self_dir(), "00_common.R"))

require_files(c(DICT_XLSX, INST_LATEST, FOS_LATEST), "the Scorecard inputs")

dict <- load_dictionary()
log_step("codebook: ", nrow(dict$labels), " variables, ", nrow(dict$values), " value labels")

# ---------------------------------------------------------------------------
# Recodes / derived columns shared by the latest snapshot and the panel
# ---------------------------------------------------------------------------
add_derived <- function(d, ps_flag = NULL) {
  d <- copy(d)
  n <- nrow(d)

  # make sure every expected column exists (old MERGED years can be empty)
  for (v in setdiff(CORE_ALL, names(d))) d[, (v) := NA_real_]
  for (v in setdiff(c("OPENADMP", "UGDS", "ADM_RATE", "NPT4_PUB", "NPT4_PRIV"), names(d)))
    d[, (v) := NA_real_]

  # ---- human-readable labels straight from the codebook --------------------
  lab_map <- list(control_label        = "CONTROL",
                  level_label          = "ICLEVEL",
                  region_label         = "REGION",
                  locale_label         = "LOCALE",
                  preddeg_label        = "PREDDEG",
                  highest_degree_label = "HIGHDEG",
                  carnegie_label       = "CCBASIC")
  for (nm in names(lab_map)) {
    v <- lab_map[[nm]]
    set(d, j = nm, value = if (v %in% names(d)) decode(dict, v, d[[v]]) else NA_character_)
  }

  # ---- mission / minority-serving flags collapsed into one column ----------
  flags <- intersect(names(MSI_FLAGS), names(d))
  if (length(flags)) {
    m <- as.matrix(d[, .SD, .SDcols = flags])
    d[, minority_serving := apply(m, 1, function(r) {
      if (all(is.na(r))) return(NA_character_)
      hit <- MSI_FLAGS[flags][!is.na(r) & r == 1]
      if (!length(hit)) "None" else paste(unname(hit), collapse = "+")
    })]
  } else d[, minority_serving := NA_character_]

  # ---- size and selectivity buckets ---------------------------------------
  d[, size_bin := size_bin_of(UGDS)]
  d[, selectivity_bin := selectivity_bin_of(ADM_RATE, d$OPENADMP)]

  # ---- coalesced headline measures ----------------------------------------
  d[, net_price        := coalesce_cols(d, c("NPT4_PUB", "NPT4_PRIV"))]
  d[, net_price_lowinc := coalesce_cols(d, c("NPT41_PUB", "NPT41_PRIV"))]
  d[, net_price_highinc:= coalesce_cols(d, c("NPT45_PUB", "NPT45_PRIV"))]
  d[, grad_rate        := coalesce_cols(d, c("C150_4", "C150_L4"))]
  d[, grad_rate_basis  := fifelse(!is.na(C150_4), "4-year cohort",
                          fifelse(!is.na(C150_L4), "2-year cohort", NA_character_))]
  d[, earn_p10 := MD_EARN_WNE_P10]
  d[, grad_debt_mdn := GRAD_DEBT_MDN]

  # ---- ratios ---------------------------------------------------------------
  d[, tuition_in_out_gap  := TUITIONFEE_OUT - TUITIONFEE_IN]
  d[, net_price_income_gap:= net_price_highinc - net_price_lowinc]
  d[, sticker_to_net      := fifelse(net_price > 0, TUITIONFEE_IN / net_price, NA_real_)]
  d[, grad_debt_to_earn   := fifelse(earn_p10 > 0, grad_debt_mdn / earn_p10, NA_real_)]

  # ---- normalisation inside peer groups (CONTROL x ICLEVEL) ---------------
  grp <- paste(d$CONTROL, d$ICLEVEL, sep = "|")
  d[, net_price_pctile_group := pctile_within(net_price, grp)]
  d[, grad_rate_pctile_group := pctile_within(grad_rate, grp)]
  d[, earn_p10_pctile_group  := pctile_within(earn_p10, grp)]
  d[, value_index_grad := grad_rate_pctile_group - net_price_pctile_group]
  d[, value_index_earn := earn_p10_pctile_group - net_price_pctile_group]

  # ---- per-institution data-quality columns --------------------------------
  hl <- intersect(HEADLINE_METRICS, names(d))
  d[, n_headline_missing := rowSums(is.na(d[, .SD, .SDcols = hl]))]
  d[, pct_headline_complete := 100 * (1 - n_headline_missing / length(hl))]
  if (!is.null(ps_flag) && ncol(ps_flag) > 0) {
    d[, n_headline_privacy_suppressed := rowSums(ps_flag)]
  } else d[, n_headline_privacy_suppressed := NA_integer_]
  d[, dq_tier := cut(pct_headline_complete,
                     breaks = c(-Inf, 50, 70, 90, Inf),
                     right = FALSE,
                     labels = c("Very low (<50%)", "Low (50-70%)",
                                "Medium (70-90%)", "High (>=90%)"))]
  d[]
}

# Column order for the institution snapshot
INST_LABEL_COLS <- c("control_label", "level_label", "region_label", "locale_label",
                     "preddeg_label", "highest_degree_label", "carnegie_label",
                     "minority_serving", "size_bin", "selectivity_bin")
INST_DERIVED_METRIC_COLS <- c("net_price", "net_price_lowinc", "net_price_highinc",
                              "net_price_income_gap", "grad_rate", "grad_rate_basis",
                              "earn_p10", "grad_debt_mdn", "tuition_in_out_gap",
                              "sticker_to_net", "grad_debt_to_earn",
                              "net_price_pctile_group", "grad_rate_pctile_group",
                              "earn_p10_pctile_group", "value_index_grad", "value_index_earn")
INST_DQ_COLS <- c("n_headline_missing", "pct_headline_complete",
                  "n_headline_privacy_suppressed", "dq_tier")

# ===========================================================================
# 1. Most-recent institution snapshot -> EDA/simplified/institution_core_latest.*
# ===========================================================================
log_step("reading institution snapshot (", basename(INST_LATEST), ") ...")
raw_inst <- read_raw_ps(INST_LATEST, CORE_ALL, ps_cols = HEADLINE_SOURCES)
inst <- add_derived(raw_inst$dt, raw_inst$ps_flag)
stopifnot(!anyNA(inst$UNITID), !anyDuplicated(inst$UNITID))
inst <- inst[, .SD, .SDcols = unique(c(CORE_ID, INST_LABEL_COLS, CORE_ACCESS, CORE_BODY,
                                      CORE_COST, CORE_OUT, CORE_EARN,
                                      INST_DERIVED_METRIC_COLS, INST_DQ_COLS))]

inst_csv  <- file.path(SIMPLIFIED_DIR, "institution_core_latest.csv")
inst_xlsx <- file.path(SIMPLIFIED_DIR, "institution_core_latest.xlsx")
fwrite(inst, inst_csv, na = "")
writexl::write_xlsx(as.data.frame(inst), inst_xlsx)

inst_stat <- data.table(
  output = c("institution_core_latest.csv", "institution_core_latest.xlsx"),
  rows   = nrow(inst), columns = ncol(inst), cells = nrow(inst) * ncol(inst),
  size_MB = round(file.size(c(inst_csv, inst_xlsx)) / 1024^2, 2),
  fits_google_sheets = nrow(inst) * ncol(inst) <= GSheets_MAX_CELLS)
log_step("institution snapshot: ", nrow(inst), " x ", ncol(inst), " (", fnum(nrow(inst) * ncol(inst)), " cells)")
print(inst_stat)

# ===========================================================================
# 2. Field-of-study snapshot -> typed extract + CIP-family aggregate
# ===========================================================================
log_step("reading field-of-study snapshot (", basename(FOS_LATEST), ") ...")
FOS_RAW <- c("UNITID", "INSTNM", "CONTROL", "CIPCODE", "CIPDESC", "CREDLEV", "CREDDESC",
             "IPEDSCOUNT1", "IPEDSCOUNT2", "DEBT_ALL_STGP_ANY_N", "DEBT_ALL_STGP_ANY_MDN",
             "DEBT_PELL_STGP_ANY_MDN", "EARN_COUNT_WNE_1YR", "EARN_MDN_1YR",
             "EARN_GT_THRESHOLD_1YR", "EARN_MDN_4YR", "EARN_MDN_5YR", "EARN_PELL_WNE_MDN_1YR")
raw_fos <- read_raw_ps(FOS_LATEST, FOS_RAW, ps_cols = c("EARN_MDN_1YR", "DEBT_ALL_STGP_ANY_MDN"))
fos <- raw_fos$dt
fos[, control_label    := decode(dict, "CONTROL", CONTROL)]
fos[, cip2             := cip2_of(CIPCODE)]
fos[, cip2_label       := cip2_label_of(CIPCODE)]
fos[, debt_to_earn_1yr := fifelse(EARN_MDN_1YR > 0,
                                DEBT_ALL_STGP_ANY_MDN / EARN_MDN_1YR, NA_real_)]
# Scorecard writes the literal text "NA" in UNITID for the institutions it does
# not publish an identifier for (mostly foreign and closed schools), so those
# rows cannot be joined to the institution file - flag them instead of dropping.
fos[, has_unitid := !is.na(UNITID)]

fos_out <- fos[, .(UNITID, INSTNM, control_label, CONTROL, cip2, cip2_label, CIPCODE, CIPDESC,
                   CREDLEV, CREDDESC, IPEDSCOUNT1, IPEDSCOUNT2, DEBT_ALL_STGP_ANY_N,
                   DEBT_ALL_STGP_ANY_MDN, DEBT_PELL_STGP_ANY_MDN, debt_to_earn_1yr,
                   EARN_COUNT_WNE_1YR, EARN_MDN_1YR, EARN_GT_THRESHOLD_1YR,
                   EARN_MDN_4YR, EARN_MDN_5YR, EARN_PELL_WNE_MDN_1YR, has_unitid)]
fos_csv <- file.path(SIMPLIFIED_DIR, "field_of_study_core_latest.csv")
fwrite(fos_out, fos_csv, na = "")
log_step("field-of-study extract: ", nrow(fos_out), " x ", ncol(fos_out),
         " (", fnum(nrow(fos_out) * ncol(fos_out)), " cells)")
log_step("  program rows whose UNITID is the text 'NA' (unpublished institutions): ",
         fnum(sum(!fos_out$has_unitid)), " across ",
         fnum(uniqueN(fos_out[has_unitid == FALSE, INSTNM])), " institutions")

med <- function(x) if (all(is.na(x))) NA_real_ else median(x, na.rm = TRUE)
cip_agg <- fos[!is.na(CIPCODE), .(
  programs              = .N,
  institutions          = uniqueN(UNITID, na.rm = TRUE),
  programs_without_unitid = sum(is.na(UNITID)),
  completions_ipeds     = sum(IPEDSCOUNT2, na.rm = TRUE),
  median_debt_all       = med(DEBT_ALL_STGP_ANY_MDN),
  median_debt_pell      = med(DEBT_PELL_STGP_ANY_MDN),
  median_earn_1yr       = med(EARN_MDN_1YR),
  median_earn_5yr       = med(EARN_MDN_5YR),
  share_earn_1yr_hidden = round(100 * mean(is.na(EARN_MDN_1YR)), 1)),
  by = .(cip2, cip2_label, CREDLEV, CREDDESC)][order(-completions_ipeds)]
cip_csv <- file.path(SIMPLIFIED_DIR, "field_of_study_by_cip2_latest.csv")
fwrite(cip_agg, cip_csv, na = "")
log_step("CIP-family aggregate: ", nrow(cip_agg), " x ", ncol(cip_agg))

# ===========================================================================
# 3. Multi-year panel -> EDA/simplified/panel_core_1996_2025.csv
# ===========================================================================
PANEL_RAW <- c("UNITID", "INSTNM", "STABBR", "CONTROL", "ICLEVEL", "UGDS", "ADM_RATE",
               "SAT_AVG", "TUITIONFEE_IN", "TUITIONFEE_OUT", "COSTT4_A", "NPT4_PUB",
               "NPT4_PRIV", "PCTPELL", "PCTFLOAN", "C150_4", "C150_L4", "RET_FT4",
               "MD_EARN_WNE_P10", "GRAD_DEBT_MDN", "MD_FAMINC", "RPY_3YR_RT")
PANEL_COLS <- c("file_year", "year_start", "UNITID", "INSTNM", "STABBR", "CONTROL",
                "control_label", "ICLEVEL", "level_label", "UGDS", "ADM_RATE", "SAT_AVG",
                "TUITIONFEE_IN", "TUITIONFEE_OUT", "COSTT4_A", "net_price", "PCTPELL",
                "PCTFLOAN", "C150_4", "C150_L4", "grad_rate", "RET_FT4", "earn_p10",
                "grad_debt_mdn", "MD_FAMINC", "RPY_3YR_RT")

merged_files <- sort(list.files(DATA_DIR, pattern = "^MERGED[0-9]{4}_[0-9]{2}_PP\\.csv$",
                                full.names = TRUE))
require_merged_files(merged_files)
log_step("building panel from ", length(merged_files), " yearly files ...")
panel <- rbindlist(lapply(merged_files, function(f) {
  fy <- sub("^MERGED([0-9]{4}_[0-9]{2})_PP\\.csv$", "\\1", basename(f))
  d  <- add_derived(read_raw_ps(f, PANEL_RAW)$dt)
  d[, `:=`(file_year = fy, year_start = as.integer(substr(fy, 1, 4)))]
  d[, .SD, .SDcols = PANEL_COLS]
}), use.names = TRUE)
setorder(panel, year_start, UNITID)
stopifnot(!anyNA(panel$UNITID), !anyDuplicated(panel[, .(year_start, UNITID)]))
panel_csv <- file.path(SIMPLIFIED_DIR, "panel_core_1996_2025.csv")
fwrite(panel, panel_csv, na = "")
log_step("panel: ", fnum(nrow(panel)), " x ", ncol(panel), " (",
         fnum(nrow(panel) * ncol(panel)), " cells, ",
         round(file.size(panel_csv) / 1024^2, 1), " MB)")

# ===========================================================================
# 4. Column dictionary for the simplified files + manifest of the outputs
# ===========================================================================
DERIVED_LABELS <- c(
  control_label          = "CONTROL decoded: Public / Private nonprofit / Private for-profit",
  level_label            = "ICLEVEL decoded: 4-year-or-above / 2-year / less-than-2-year",
  region_label           = "REGION decoded (1-9 Scorecard regions)",
  locale_label           = "LOCALE decoded (city / suburb / town / rural, size)",
  preddeg_label          = "PREDDEG decoded (predominant degree awarded)",
  highest_degree_label   = "HIGHDEG decoded (highest degree awarded)",
  carnegie_label         = "CCBASIC decoded (Carnegie classification)",
  minority_serving       = "Recoded from HBCU/PBI/TRIBAL/HSI/ANNHI/AANAPII/NANTI flags",
  size_bin               = "UGDS bucket: <1k / 1-5k / 5-20k / 20k+",
  selectivity_bin        = "ADM_RATE bucket, with OPENADMP==1 shown as 'Open admission'",
  net_price              = "NPT4_PUB coalesced with NPT4_PRIV (average net price, all income)",
  net_price_lowinc       = "NPT41_PUB coalesced with NPT41_PRIV (net price, $0-30k family income)",
  net_price_highinc      = "NPT45_PUB coalesced with NPT45_PRIV (net price, $110k+ family income)",
  net_price_income_gap   = "net_price_highinc - net_price_lowinc",
  grad_rate              = "C150_4 coalesced with C150_L4 (150% time graduation rate)",
  grad_rate_basis        = "Which cohort the graduation rate refers to (4-year vs 2-year)",
  earn_p10               = "MD_EARN_WNE_P10: median earnings 10 years after entry, working & not enrolled",
  grad_debt_mdn          = "GRAD_DEBT_MDN: median federal debt of graduates",
  tuition_in_out_gap     = "TUITIONFEE_OUT - TUITIONFEE_IN",
  sticker_to_net         = "TUITIONFEE_IN / net_price",
  grad_debt_to_earn      = "grad_debt_mdn / earn_p10 (debt-to-earnings ratio)",
  net_price_pctile_group = "Percentile of net_price within CONTROL x ICLEVEL peer group",
  grad_rate_pctile_group = "Percentile of grad_rate within CONTROL x ICLEVEL peer group",
  earn_p10_pctile_group  = "Percentile of earn_p10 within CONTROL x ICLEVEL peer group",
  value_index_grad       = "grad_rate_pctile_group - net_price_pctile_group",
  value_index_earn       = "earn_p10_pctile_group - net_price_pctile_group",
  n_headline_missing     = "Count of the 10 headline metrics that are NA for this institution",
  pct_headline_complete  = "100 * (1 - n_headline_missing / 10)",
  n_headline_privacy_suppressed = "Count of headline source cells flagged 'PS' (privacy suppressed)",
  dq_tier                = "Data-quality tier derived from pct_headline_complete",
  file_year              = "Source file label, e.g. 2013_14",
  year_start             = "Numeric first year of the source file, e.g. 2013",
  cip2                   = "2-digit CIP family of CIPCODE",
  cip2_label             = "Human-readable CIP family name",
  debt_to_earn_1yr       = "DEBT_ALL_STGP_ANY_MDN / EARN_MDN_1YR",
  has_unitid             = "TRUE when the program row carries a UNITID and can be joined to the institution file")

codebook <- rbindlist(list(
  data.table(variable = names(inst),    in_institution_core = TRUE,  in_panel = FALSE, in_field_of_study = FALSE),
  data.table(variable = names(panel),   in_institution_core = FALSE, in_panel = TRUE,  in_field_of_study = FALSE),
  data.table(variable = names(fos_out), in_institution_core = FALSE, in_panel = FALSE, in_field_of_study = TRUE)))
codebook <- codebook[, lapply(.SD, any), by = variable, .SDcols = patterns("^in_")]
codebook[, `:=`(
  derived         = variable %in% names(DERIVED_LABELS),
  scorecard_label = vapply(variable, function(v) var_label(dict, v), character(1)))]
codebook[derived == TRUE, scorecard_label := DERIVED_LABELS[variable]]
setcolorder(codebook, c("variable", "scorecard_label", "derived",
                        "in_institution_core", "in_field_of_study", "in_panel"))
setorder(codebook, -in_institution_core, -in_field_of_study, -in_panel, variable)
codebook_csv <- file.path(REPORTS_DIR, "simplified_codebook.csv")
fwrite(codebook, codebook_csv)
log_step("wrote codebook: ", nrow(codebook), " variables")

manifest <- data.table(
  output = c("institution_core_latest.csv", "institution_core_latest.xlsx",
             "field_of_study_core_latest.csv", "field_of_study_by_cip2_latest.csv",
             "panel_core_1996_2025.csv"),
  path = file.path(SIMPLIFIED_DIR, c("institution_core_latest.csv", "institution_core_latest.xlsx",
             "field_of_study_core_latest.csv", "field_of_study_by_cip2_latest.csv",
             "panel_core_1996_2025.csv")))
manifest[, size_MB := round(file.size(path) / 1024^2, 2)]
manifest[, rows := c(nrow(inst), nrow(inst), nrow(fos_out), nrow(cip_agg), nrow(panel))]
manifest[, columns := c(ncol(inst), ncol(inst), ncol(fos_out), ncol(cip_agg), ncol(panel))]
manifest[, cells := rows * columns]
manifest[, opens_in_google_sheets := cells <= GSheets_MAX_CELLS & size_MB * 1024^2 <= GSheets_MAX_BYTES]
fwrite(manifest[, .(output, rows, columns, cells, size_MB, opens_in_google_sheets)],
       file.path(REPORTS_DIR, "simplified_outputs_manifest.csv"))

cat("\n=== simplified outputs ===\n")
print(manifest[, .(output, rows, columns, cells, size_MB, opens_in_google_sheets)])
log_step("done")
