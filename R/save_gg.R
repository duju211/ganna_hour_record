save_gg <- function(gg_time_all, png_out_path) {
  ggsave(png_out_path, gg_time_all)
  png_out_path
}