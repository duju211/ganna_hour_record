vis_time <- function(df_time) {
  df_time |>
    filter(lap_nr != 1) |>
    ggplot(aes(x = lap_nr, y = time)) +
    geom_point() +
    geom_smooth()
}