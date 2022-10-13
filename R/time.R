time <- function(df_time_raw) {
  df_time_raw |>
    mutate(
      across(where(is.character), parse_number),
      ind = row_number())
}