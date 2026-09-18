library(rscorecard)

sc_init() |>
  sc_filter(stabbr == "FL") |>
  sc_select(unitid, instnm) |>
  sc_get()