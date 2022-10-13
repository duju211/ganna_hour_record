source("libraries.R")
walk(dir_ls("R"), source)

time_area <- geometry_area(
  width = 145, height = 41, x_off = 2241, y_off = 899)
lap_area <- geometry_area(
  width = 72, height = 37, x_off = 2808, y_off = 111)

img_dir <- dir_create("file_in", "campenaerts")
lap_img_dir <- dir_create(img_dir, "lap_img")
time_img_dir <- dir_create(img_dir, "time_img")

screen_shots <- dir_ls("file_in/", type = "file")

time_img <- map_chr(screen_shots, ~ img_crop(.x, time_area, time_img_dir))
lap_img <- map_chr(screen_shots, ~ img_crop(.x, lap_area, lap_img_dir))
