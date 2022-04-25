#' Download Media
#'
#' @description Function that downloads files from the given urls. The query
#' parameter `value` is used as the file name.
#'
#' @param urls, character vector of fiel urls
#' @param dest_dir, destination directory
#' @param quiet, boolean to suppress download file messages
#'
#' @importFrom utils download.file
#'
#' @return destination folder
#' @export
download_media <- function(urls, dest_dir = NULL, quiet = TRUE) {

  stopifnot(is.character(urls))
  stopifnot(is.null(dest_dir) || is.character(dest_dir))

  if(is.null(dest_dir))
    dest_dir <- tempdir()

  dir.create(dest_dir, showWarnings = FALSE)
  inv <- lapply(urls, function(x) {
    file_name <- urltools::param_get(x)$value
    download.file(x, file.path(dest_dir, file_name), quiet = TRUE)
  })

  dest_dir

}
