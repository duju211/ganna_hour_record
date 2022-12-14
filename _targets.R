source("libraries.R")

walk(dir_ls("R"), source)

df_athlete_dir <- tibble(
  athlete_dir = dir_ls("file_in/", type = "directory")) |>
  mutate(
    athlete = map_chr(path_split(athlete_dir), 2),
    distance = case_when(
      athlete == "ganna" ~ 56.792,
      athlete == "campenaerts" ~ 55.089,
      TRUE ~ NA_real_))

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
  tar_target(
    csv_url,
    str_glue(
      "https://raw.githubusercontent.com/duju211/ganna_hour_record/master/",
      "file_out/hour_record.csv")),
  tar_target(repo, "https://github.com/duju211/ganna_hour_record"),
  tar_target(png_out_path, "file_out/gg_time_all.png"),
  
  athlete_targets,
  
  combined_targets,
  tar_target(df_time_pro, time_pro(df_time, df_athlete_dir)),
  tar_target(gg_time_all, vis_time_all(df_time_pro)),
  tar_target(
    csv_time, command = {
      out_path <- "file_out/hour_record.csv";
      write_excel_csv(df_time, "file_out/hour_record.csv");
      return(out_path)
    }, format = "file"),
  tar_target(png_time_all, save_gg(gg_time_all, png_out_path)),
  
  tar_render(hour_record_post, "hour_record.Rmd"),
  tar_render(
    hour_record_readme, "hour_record.Rmd", output_format = "md_document",
    output_file = "README.md")
)