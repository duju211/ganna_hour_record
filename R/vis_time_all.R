vis_time_all <- function(df_time_pro) {
  df_time_pro |>
    filter(lap_nr != 1) |>
    mutate(athlete = str_to_title(athlete)) |>
    ggplot(aes(x = lap_nr, y = speed, color = athlete)) +
    geom_point() +
    geom_hline(aes(yintercept = distance, color = athlete), linetype = 2) + 
    geom_smooth() +
    labs(
      title = "Hour Record Pacing Strategies (Color: Athlete)",
      subtitle = "Average Speed per Attempt displayed as dotted line",
      x = "Lap Number", y = "Speed [km / h]", color = "Athlete") +
    theme(legend.position = "bottom")
}