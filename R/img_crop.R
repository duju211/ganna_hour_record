img_crop <- function(screen_shot, area, output_dir) {
  img <- image_read(screen_shot)
  
  crop <- image_crop(img, area)
  
  image_write(
    image = crop, path = file_create(output_dir, path_file(screen_shot)))
}