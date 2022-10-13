nr_from_image <- function(img_path, bw_threshold) {
  image_read(img_path) |> 
    image_quantize(colorspace = "gray") |>
    image_threshold(threshold = bw_threshold) |>
    ocr()
}