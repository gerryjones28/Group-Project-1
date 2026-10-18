# 00_common.R -----------------------------------------------------------------
# Group Project I - College Scorecard
# Shared paths, constants, spreadsheet limits and helper functions.
# Sourced by every other script in EDA/scripts/. Not meant to be run directly.
#
# The scripts locate the project root from the Rscript --file= argument, so they
# can be run from any working directory. RStudio users can instead set
#   Sys.setenv(SC_PROJECT_ROOT = "/path/to/Group Project 1")
# before sourcing a script.

suppressPackageStartupMessages(library(data.table))

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

script_dir <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  hit <- grep("^--file=", args, value = TRUE)
  if (length(hit)) return(normalizePath(dirname(sub("^--file=", "", hit[[1]]))))
  normalizePath(getwd())
}

PROJECT_ROOT <- normalizePath(file.path(script_dir(), "..", ".."))
if (nzchar(Sys.getenv("SC_PROJECT_ROOT")))
  PROJECT_ROOT <- normalizePath(Sys.getenv("SC_PROJECT_ROOT"))

EDA_DIR        <- file.path(PROJECT_ROOT, "EDA")
DATA_DIR       <- file.path(PROJECT_ROOT, "data", "College_Scorecard_Raw_Data_06032026")
DICT_XLSX      <- file.path(PROJECT_ROOT, "data", "CollegeScorecardDataDictionary.xlsx")
SIMPLIFIED_DIR <- file.path(EDA_DIR, "simplified")
REPORTS_DIR    <- file.path(EDA_DIR, "reports")
FIGURES_DIR    <- file.path(EDA_DIR, "figures")

INST_LATEST <- file.path(DATA_DIR, "Most-Recent-Cohorts-Institution.csv")
FOS_LATEST  <- file.path(DATA_DIR, "Most-Recent-Cohorts-Field-of-Study.csv")

invisible(lapply(c(SIMPLIFIED_DIR, REPORTS_DIR, FIGURES_DIR),
                 function(d) if (!dir.exists(d)) dir.create(d, recursive = TRUE)))

# ---------------------------------------------------------------------------
# Preflight: the raw downloads are 60-150 MB each and are NOT versioned in git
# (see the repo-root .gitignore), so a fresh clone fails right here. Say which
# files are missing and where to get them instead of a raw readxl/fread error.
# ---------------------------------------------------------------------------
require_files <- function(paths, what = "input files", hint = "") {
  missing <- paths[!file.exists(paths)]
  if (!length(missing)) return(invisible(TRUE))
  stop(paste0("Missing ", what, ":\n  ", paste(missing, collapse = "\n  "),
              "\n\nThe College Scorecard downloads are 60-150 MB per file and are not ",
              "stored in this git repo.\nSee README.md -> \"Getting the data\" (and ",
              "EDA/README.md) for the download steps",
              if (nzchar(hint)) paste0(", then ", hint) else "", "."), call. = FALSE)
}

require_merged_files <- function(files) {
  if (length(files)) return(invisible(TRUE))
  stop(paste0("No MERGED####_##_PP.csv files found in ", DATA_DIR,
              ".\nThe yearly College Scorecard files are not stored in this git repo ",
              "- see README.md -> \"Getting the data\"."), call. = FALSE)
}

# ---------------------------------------------------------------------------
# Spreadsheet hard limits (used to explain why the raw files will not open)
# ---------------------------------------------------------------------------
# Google Sheets : 10,000,000 cells per spreadsheet (all tabs combined)
#                 Google Drive also refuses to *convert* uploads over ~100 MB
# Microsoft Excel (.xlsx sheet): 1,048,576 rows x 16,384 columns
# Practical comfort zone for either tool: < ~5,000,000 cells and < ~30 MB
GSheets_MAX_CELLS <- 1e7
GSheets_MAX_BYTES <- 100 * 1024^2
Excel_MAX_ROWS    <- 1048576L
Excel_MAX_COLS    <- 16384L
COMFORT_CELLS     <- 5e6
COMFORT_BYTES     <- 30 * 1024^2

# ---------------------------------------------------------------------------
# Missing-value encodings used by the Scorecard CSV files
# ---------------------------------------------------------------------------
#   "NA"        -> not applicable / not collected / otherwise unavailable
#   "PS"        -> "PrivacySuppressed": cell count too small to publish. The
#                  most-recent Field-of-Study file also spells it out in full.
#   "" (blank)  -> no value supplied
NA_LIKE_TOKENS <- c("NA", "N/A", "NULL", ".", "-")
PS_TOKENS      <- c("PS", "PrivacySuppressed")
MISSING_TOKENS <- c("", NA_LIKE_TOKENS, PS_TOKENS)

# ---------------------------------------------------------------------------
# Generic CSV helpers
# ---------------------------------------------------------------------------

# Column names only (reads the header, no data).
csv_header <- function(path) names(fread(path, nrows = 0L, showProgress = FALSE))

# Number of data rows (header excluded). select = 1L keeps this cheap.
count_rows <- function(path) nrow(fread(path, select = 1L, showProgress = FALSE))

# Read columns verbatim: every cell stays text and nothing becomes NA, so the
# literal tokens "NA"/"PS"/blank can be counted separately. Codes such as
# UNITID/CIPCODE also keep their original text form.
read_text_cols <- function(path, cols) {
  fread(path, select = cols, colClasses = "character",
        na.strings = character(0), showProgress = FALSE)
}

# Per-column audit of the literal contents: how many cells are blank, "NA",
# "PS"/"PrivacySuppressed", how many distinct non-missing values there are, and
# whether the remaining values all parse as numbers.
audit_columns <- function(path, cols) {
  x <- read_text_cols(path, cols)
  n <- nrow(x)
  rbindlist(lapply(cols, function(cl) {
    v <- trimws(x[[cl]])
    n_blank <- sum(is.na(v) | v == "")
    n_na    <- sum(v %in% NA_LIKE_TOKENS)
    n_ps    <- sum(v %in% PS_TOKENS)
    keep    <- !(is.na(v) | v %in% MISSING_TOKENS)
    good    <- v[keep]
    num     <- suppressWarnings(as.numeric(good))
    is_num  <- length(good) > 0 && all(!is.na(num))
    data.table(
      variable          = cl,
      n_rows            = n,
      n_blank           = n_blank,
      n_na              = n_na,
      n_ps              = n_ps,
      n_missing_total   = n_blank + n_na + n_ps,
      pct_missing       = 100 * (n_blank + n_na + n_ps) / n,
      pct_privacy       = 100 * n_ps / n,
      n_nonmissing      = length(good),
      n_unique_nonmiss  = length(unique(good)),
      pct_unique        = 100 * length(unique(good)) / max(1L, length(good)),
      numeric_like      = is_num,
      min               = if (is_num) min(num) else NA_real_,
      median            = if (is_num) stats::median(num) else NA_real_,
      mean              = if (is_num) mean(num) else NA_real_,
      max               = if (is_num) max(num) else NA_real_
    )
  }))
}

# Column-chunked audit of a whole file. max_cells caps how many text cells are
# held in memory at once, which keeps the 228k x 178 Field-of-Study file flat.
audit_file <- function(path, max_cells = 2e6, chunk_max = 200L) {
  cols  <- csv_header(path)
  nr    <- count_rows(path)
  chunk <- max(1L, min(chunk_max, floor(max_cells / max(1, nr))))
  rbindlist(lapply(seq(1L, length(cols), by = chunk), function(s) {
    idx <- s:min(s + chunk - 1L, length(cols))
    audit_columns(path, cols[idx])
  }))
}

# Return a numeric vector if every non-missing value parses as a number,
# otherwise NULL (column stays character).
as_num_if_possible <- function(v) {
  keep <- !(is.na(v) | v %in% MISSING_TOKENS)
  if (!any(keep)) return(rep(NA_real_, length(v)))
  num <- suppressWarnings(as.numeric(v))
  if (all(!is.na(num[keep]))) num else NULL
}

# Turn raw tokens into NA, then convert to numeric when the column is numeric.
clean_column <- function(v) {
  v <- trimws(v)
  v[v %in% MISSING_TOKENS] <- NA_character_
  num <- as_num_if_possible(v)
  if (is.null(num)) v else num
}

# Same, but also reports how many "PS" cells each column carried (the privacy
# signal is otherwise lost once everything is set to NA).
clean_with_ps <- function(v) {
  v <- trimws(v)
  n_ps <- sum(v %in% PS_TOKENS)
  v[v %in% MISSING_TOKENS] <- NA_character_
  num <- as_num_if_possible(v)
  list(value = if (is.null(num)) v else num, n_ps = n_ps)
}

# ---------------------------------------------------------------------------
# Column-subset readers used by the build and EDA scripts
# ---------------------------------------------------------------------------

# Identifier-like columns that must stay text (leading zeros matter).
KEEP_TEXT <- c("ZIP", "OPEID", "OPEID6", "ST_FIPS", "CIPCODE")
clean_named <- function(v, name) {
  v <- trimws(v)
  if (name %in% KEEP_TEXT) {
    v[v %in% MISSING_TOKENS] <- NA_character_
    return(v)
  }
  clean_column(v)
}

# ---------------------------------------------------------------------------
# Read a column subset, clean it, and keep the per-cell privacy flags
# ---------------------------------------------------------------------------
read_raw_ps <- function(path, cols, ps_cols = character()) {
  have <- csv_header(path)
  missing <- setdiff(cols, have)
  if (length(missing))
    log_step("note: ", length(missing), " requested column(s) absent from ",
             basename(path), ": ", paste(head(missing, 8), collapse = ", "),
             if (length(missing) > 8) " ..." else "")
  cols <- intersect(cols, have)
  raw  <- read_text_cols(path, cols)
  # per-column privacy-suppression counts (before tokens collapse into NA)
  ps_total <- vapply(raw, function(v) sum(trimws(v) %in% PS_TOKENS), integer(1))
  # per-row privacy flags for the headline source columns
  hl <- intersect(ps_cols, cols)
  ps_flag <- if (length(hl))
    vapply(raw[, .SD, .SDcols = hl], function(v) trimws(v) %in% PS_TOKENS,
           logical(nrow(raw)))
  else matrix(FALSE, nrow(raw), 0)
  dt <- as.data.table(lapply(seq_along(cols), function(i) clean_named(raw[[i]], cols[i])))
  setnames(dt, cols)
  list(dt = dt, ps_total = ps_total, ps_flag = ps_flag, cols = cols)
}

# First non-missing value out of a set of alternative columns (e.g. NPT4_PUB and
# NPT4_PRIV are mutually exclusive by sector).
coalesce_cols <- function(d, cands) {
  cc <- intersect(cands, names(d))
  if (!length(cc)) return(rep(NA_real_, nrow(d)))
  do.call(fcoalesce, unname(as.list(d[, .SD, .SDcols = cc])))
}

# ---------------------------------------------------------------------------
# Codebook (CollegeScorecardDataDictionary.xlsx)
# ---------------------------------------------------------------------------

# The codebook spreadsheet uses merged cells: "VARIABLE NAME" / "NAME OF DATA
# ELEMENT" are written only on the first row of each variable's block, and every
# extra code row below it is blank. Forward-filling those columns is what makes
# the multi-level codes (PREDDEG 0-4, REGION 0-9, LOCALE 11-43, ...) decodable.
locf <- function(x) {
  ok  <- !is.na(x) & x != ""
  idx <- cumsum(ok)
  out <- x
  out[!ok] <- x[which(ok)][idx[!ok]]
  out[idx == 0] <- NA_character_
  out
}

load_dictionary <- function() {
  d <- suppressMessages(readxl::read_excel(
    DICT_XLSX, sheet = "Institution_Data_Dictionary", col_types = "text"))
  d <- as.data.table(d)
  setnames(d, c("NAME OF DATA ELEMENT", "VARIABLE NAME", "VALUE", "LABEL"),
           c("element", "variable", "value", "label"), skip_absent = TRUE)
  d[, `:=`(variable = locf(trimws(variable)), element = locf(trimws(element)))]
  # value/element definitions sometimes span several rows in the .xlsx; collapse
  # the line breaks so every label stays a single cell.
  d[, `:=`(variable = trimws(variable), value = trimws(value),
           label    = trimws(gsub("[\r\n]+", " ", label)),
           element  = trimws(gsub("[\r\n]+", " ", element)))]
  labels <- unique(d[!is.na(variable) & !is.na(element), .(variable, element)])
  labels <- labels[, .SD[1L], by = variable]
  values <- unique(d[!is.na(variable) & !is.na(value) & !is.na(label),
                     .(variable, value, label)])
  list(labels = labels, values = values)
}

# Human-readable label for a variable name (falls back to the name itself).
var_label <- function(dict, var) {
  hit <- dict$labels[variable == var, element]
  lab <- if (length(hit) && !is.na(hit[1])) hit[1] else var
  # some official definitions span several rows in the dictionary - collapse the
  # line breaks so the label stays a single cell (and cannot break a markdown table)
  trimws(gsub("[\r\n]+", " ", lab))
}

# Decode a coded column (CONTROL, ICLEVEL, REGION, LOCALE, ...) into text with
# the official codebook; codes not in the codebook are kept as "code: N".
decode <- function(dict, var, x) {
  lut <- dict$values[variable == var]
  key <- as.character(x)
  int <- grepl("^-?[0-9]+$", key)
  key[int] <- as.character(as.integer(as.numeric(key[int])))
  out <- lut$label[match(key, lut$value)]
  bad <- is.na(out) & !is.na(x)
  out[bad] <- paste0("code: ", key[bad])
  out
}

# ---------------------------------------------------------------------------
# CIP (Classification of Instructional Programs) 2-digit families
# ---------------------------------------------------------------------------

CIP2_LABELS <- c(
  "01" = "Agriculture", "03" = "Natural Resources & Conservation",
  "04" = "Architecture", "05" = "Area, Ethnic & Gender Studies",
  "09" = "Communication & Journalism", "10" = "Communications Technologies",
  "11" = "Computer & Information Sciences", "12" = "Personal & Culinary Services",
  "13" = "Education", "14" = "Engineering",
  "15" = "Engineering Technologies", "16" = "Foreign Languages & Linguistics",
  "19" = "Family & Consumer Sciences", "21" = "Reserved (CIP 21)",
  "22" = "Legal Professions", "23" = "English Language & Literature",
  "24" = "Liberal Arts & General Studies", "25" = "Library Science",
  "26" = "Biological & Biomedical Sciences", "27" = "Mathematics & Statistics",
  "28" = "Military Science", "29" = "Military Technologies",
  "30" = "Multi/Interdisciplinary Studies", "31" = "Parks, Recreation & Fitness",
  "32" = "Basic & Developmental Skills", "33" = "Citizenship Activities",
  "34" = "Health-Related Knowledge", "35" = "Interpersonal & Social Skills",
  "36" = "Leisure & Recreation", "37" = "Personal Awareness",
  "38" = "Philosophy & Religious Studies", "39" = "Theology & Religious Vocations",
  "40" = "Physical Sciences", "41" = "Science Technologies",
  "42" = "Psychology", "43" = "Security & Protective Services",
  "44" = "Public Administration & Social Service", "45" = "Social Sciences",
  "46" = "Construction Trades", "47" = "Mechanic & Repair Technologies",
  "48" = "Precision Production", "49" = "Transportation & Materials Moving",
  "50" = "Visual & Performing Arts", "51" = "Health Professions",
  "52" = "Business, Management & Marketing",
  "53" = "High School / Secondary Certificates", "54" = "History",
  "60" = "Residency Programs", "61" = "Residency/Fellowship Programs")

# 4-digit CIP code ("0109") -> 2-digit family ("01")
cip2_of <- function(cipcode) sprintf("%02d", floor(as.numeric(cipcode) / 100))
cip2_label_of <- function(cipcode) {
  k <- cip2_of(cipcode)
  out <- unname(CIP2_LABELS[k])
  out[is.na(out)] <- paste0("Other (CIP ", k[is.na(out)], ")")
  out
}

# ---------------------------------------------------------------------------
# Core variable sets (verified against the 2026-06-03 file headers)
# ---------------------------------------------------------------------------

CORE_ID <- c(
  "UNITID", "OPEID6", "INSTNM", "CITY", "STABBR", "ZIP", "LATITUDE", "LONGITUDE",
  "REGION", "ST_FIPS", "CONTROL", "ICLEVEL", "PREDDEG", "HIGHDEG", "CCBASIC",
  "LOCALE", "CURROPER", "MAIN", "NUMBRANCH", "DISTANCEONLY", "SCH_DEG", "HCM2",
  "HBCU", "PBI", "TRIBAL", "HSI", "ANNHI", "AANAPII", "NANTI", "MENONLY",
  "WOMENONLY", "RELAFFIL", "ACCREDAGENCY", "INSTURL")

# access / selectivity
CORE_ACCESS <- c("OPENADMP", "ADM_RATE", "SAT_AVG", "ACTCMMID", "SATVRMID", "SATMTMID")

# size, composition and student-body economics
CORE_BODY <- c(
  "UGDS", "UG", "UG25ABV", "PFTFTUG1_EF",
  "UGDS_WHITE", "UGDS_BLACK", "UGDS_HISP", "UGDS_ASIAN", "UGDS_AIAN",
  "UGDS_NHPI", "UGDS_2MOR", "UGDS_NRA", "UGDS_UNKN", "UGDS_MEN", "UGDS_WOMEN",
  "UGNONDS", "MD_FAMINC", "FAMINC_IND",
  "INC_PCT_LO", "INC_PCT_M1", "INC_PCT_M2", "INC_PCT_H1", "INC_PCT_H2",
  "STUFACR", "AVGFACSAL")

# affordability, price and debt
CORE_COST <- c(
  "TUITIONFEE_IN", "TUITIONFEE_OUT", "TUITIONFEE_PROG", "COSTT4_A", "COSTT4_P",
  "NPT4_PUB", "NPT4_PRIV", "NPT41_PUB", "NPT45_PUB", "NPT41_PRIV", "NPT45_PRIV",
  "PCTPELL", "PCTFLOAN", "DEBT_MDN", "GRAD_DEBT_MDN", "PELL_DEBT_N")

# completion, retention and repayment outcomes
CORE_OUT <- c(
  "C150_4", "C150_L4", "C150_4_POOLED", "C150_L4_POOLED", "C200_4", "C200_L4",
  "D150_4", "D150_L4", "RET_FT4", "RET_FTL4", "RET_FT4_POOLED", "RET_FTL4_POOLED",
  "OMACHT6_FTFT", "OMACHT8_FTFT",
  "RPY_3YR_RT", "RPY_5YR_RT", "RPY_7YR_RT",
  "COMPL_RPY_3YR_RT", "COMPL_RPY_5YR_RT", "COMPL_RPY_7YR_RT", "CDR2", "CDR3")

# post-completion earnings
CORE_EARN <- c(
  "MD_EARN_WNE_P6", "MD_EARN_WNE_P8", "MD_EARN_WNE_P10",
  "MN_EARN_WNE_P6", "MN_EARN_WNE_P8", "MN_EARN_WNE_P10",
  "PCT25_EARN_WNE_P10", "PCT75_EARN_WNE_P10", "GT_25K_P6", "GT_25K_P10")

CORE_ALL <- unique(c(CORE_ID, CORE_ACCESS, CORE_BODY, CORE_COST, CORE_OUT, CORE_EARN))

# Headline metrics: the ten measurements the group is most likely to model on.
# Four of them (net_price, grad_rate, earn_p10, grad_debt_mdn) are coalesced
# from the sector-specific raw columns listed in HEADLINE_SOURCES.
HEADLINE_METRICS <- c(
  "ADM_RATE", "UGDS", "TUITIONFEE_IN", "net_price", "PCTPELL", "PCTFLOAN",
  "grad_rate", "RET_FT4", "earn_p10", "grad_debt_mdn")

HEADLINE_SOURCES <- unique(c(
  "ADM_RATE", "UGDS", "TUITIONFEE_IN", "NPT4_PUB", "NPT4_PRIV", "PCTPELL",
  "PCTFLOAN", "C150_4", "C150_L4", "RET_FT4", "MD_EARN_WNE_P10", "GRAD_DEBT_MDN"))

# ---------------------------------------------------------------------------
# Recodes shared by the simplified institution file and the multi-year panel
# ---------------------------------------------------------------------------

CONTROL_LABELS <- c("1" = "Public", "2" = "Private nonprofit", "3" = "Private for-profit")
LEVEL_LABELS   <- c("1" = "4-year or above", "2" = "2-year", "3" = "Less than 2-year")

MSI_FLAGS <- c(HBCU = "HBCU", PBI = "PBI", TRIBAL = "Tribal", HSI = "HSI",
               ANNHI = "ANNHI", AANAPII = "AANAPII", NANTI = "NANTI")

size_bin_of <- function(ugds) {
  out <- rep("Not reported", length(ugds))
  ok <- !is.na(ugds)
  out[ok & ugds < 1000]                   <- "Under 1,000"
  out[ok & ugds >= 1000  & ugds < 5000]   <- "1,000-4,999"
  out[ok & ugds >= 5000  & ugds < 20000]  <- "5,000-19,999"
  out[ok & ugds >= 20000]                 <- "20,000 or more"
  out
}

# Selectivity buckets. Open-admission schools (OPENADMP == 1) are separated
# from schools that simply did not report an admission rate.
selectivity_bin_of <- function(adm_rate, open_admp = NULL) {
  out <- rep(NA_character_, length(adm_rate))
  ok <- !is.na(adm_rate)
  out[ok & adm_rate < 0.25]                   <- "Most selective (<25%)"
  out[ok & adm_rate >= 0.25 & adm_rate < 0.50] <- "Selective (25-50%)"
  out[ok & adm_rate >= 0.50 & adm_rate < 0.75] <- "Somewhat selective (50-75%)"
  out[ok & adm_rate >= 0.75]                   <- "Least selective (>=75%)"
  if (!is.null(open_admp))
    out[is.na(out) & !is.na(open_admp) & open_admp == 1] <- "Open admission"
  out[is.na(out)] <- "Not reported"
  out
}

# Percentile rank of each school inside its peer group (same CONTROL x ICLEVEL),
# i.e. a normalisation between categories. NA stays NA.
pctile_within <- function(x, g) {
  dt <- data.table(x = x, g = g, p = NA_real_)
  dt[!is.na(x), p := frank(x, ties.method = "average") / .N, by = g]
  dt$p
}

# ---------------------------------------------------------------------------
# Small formatting helpers
# ---------------------------------------------------------------------------

fnum <- function(x) formatC(x, big.mark = ",", digits = 0, format = "f")

pct1 <- function(x) paste0(formatC(x, digits = 1, format = "f"), "%")

md_table <- function(dt, digits = 2) {
  dt <- copy(dt)
  for (cl in names(dt)) if (is.numeric(dt[[cl]])) dt[[cl]] <- round(dt[[cl]], digits)
  hdr  <- paste(names(dt), collapse = " | ")
  sep  <- paste(rep("---", ncol(dt)), collapse = " | ")
  rows <- apply(dt, 1, function(r) paste(r, collapse = " | "))
  c(paste0("| ", hdr, " |"), paste0("| ", sep, " |"), paste0("| ", rows, " |"))
}

log_step <- function(...) cat(sprintf("[%s] ", format(Sys.time(), "%H:%M:%S")), ..., "\n", sep = "")
