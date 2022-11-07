vis_time_all <- function(df_time) {
  df_time |>
    filter(lap_nr != 1) |>
    ggplot(aes(x = lap_nr, y = time, color = athlete)) +
    geom_point() +
    geom_smooth() +
    labs(x = "Lap Number", y = "Time", color = "Athlete") +
    theme(legend.position = "bottom")
}