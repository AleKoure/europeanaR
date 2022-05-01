#' Download Media
#'
#' @description Function that downloads media, using the response object of the
#' Europeana search API. It uses the fields `type` and `edmIsShownBy` to
#' retrieve the items and store them in a local folder.
#'
#' @param resp, an S3 object of type `europeana_search_api`
#' @param download_dir, destination directory. If `NULL` then `tempdir()` is used
#' @param quiet, boolean to suppress download file messages
#' @param type_, string in `c("TEXT", "IMAGE", "SOUND", "VIDEO", "3D")`
#'
#' @return destination folder
#'
#' @examplesIf Sys.getenv("EUROPEANA_KEY") != ""
#' \donttest{
#' #set your API key with set_key(api_key = "XXXX")
#' resp <- query_search_api("arioch")
#' download_media(resp, type = "IMAGE")
#' }
#'
#' @importFrom utils download.file
#'
#' @export
download_media <- function(resp,
                           download_dir = NULL,
                           type_ = NULL,
                           quiet = TRUE) {

  type <- edmIsShownBy <- id <- NULL

  stopifnot(class(resp) == "europeana_search_api")
  stopifnot("Status code is not OK" = resp$response$status_code == 200)
  stopifnot("No items found" = resp$content$itemsCount > 0)
  stopifnot(is.null(download_dir) || is.character(download_dir))
  stopifnot(is.null(type_) ||
              type_ %in% c("TEXT", "IMAGE", "SOUND", "VIDEO", "3D"))

  data <- tidy_search_items(resp)

  if(!is.null(type_))
    data <- data[type == type_]

  if(is.null(download_dir))
    download_dir <- tempdir()

  dir.create(download_dir, showWarnings = FALSE)

  inv <- lapply(seq_len(nrow(data)), function(i) {
    tryCatch({
      file_path <- file.path(download_dir, gsub(".*/", "", data[i, id]))
      download.file(data[i, edmIsShownBy],
                    file_path,
                    quiet = TRUE)
    }, error = function(e) {
      message(paste0("Cannot reach resource: ", data[i, id]))
    })
  })

  download_dir

}
