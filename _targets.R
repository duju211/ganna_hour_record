source("libraries.R")

walk(dir_ls("R"), source)

df_athlete_dir <- tibble(
  athlete_dir = dir_ls("file_in/", type = "directory")) |>
  mutate(athlete = map_chr(path_split(athlete_dir), 2))

athlete_targets <- tar_map(
  unlist = FALSE,
  values = df_athlete_dir, names = "athlete",
  tar_files(lap_files, dir_ls(here(athlete_dir, "lap_img"))),
  tar_target(
    nr_lap, nr_from_image(lap_files, bw_threshold),
    pattern = map(lap_files)),
  tar_files(time_files, dir_ls(here(athlete_dir, "time_img"))),
  tar_target(
    time_lap, nr_from_image(time_files, bw_threshold),
    pattern = map(time_files)),
  tar_target(df_time, time(tibble(time = time_lap, lap_nr = nr_lap))),
  tar_target(gg_time, vis_time(df_time))
)

combined_targets <- tar_combine(
  df_time,
  athlete_targets[["df_time"]],
  command = dplyr::bind_rows(!!!.x, .id = "athlete")
)

list(
  tar_target(bw_threshold, "75"),
  
  athlete_targets,
  
  combined_targets
)