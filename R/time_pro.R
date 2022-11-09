time_pro <- function(df_time, df_athlete_dir) {
  df_time |>
    mutate(
      athlete = str_remove(athlete, "^df_time_"),
      speed = 0.25 / (time / 60 / 60)) |>
    left_join(select(df_athlete_dir, athlete, distance), by = "athlete")
}