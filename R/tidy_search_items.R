#' Tidy search API response
#'
#' Transforms API response to a tidy `data.table` for easier manipulation
#'
#' @param resp, and S3 object of type `europeana_search_api`.
#'
#' @import data.table magrittr
#'
#' @export
tidy_search_items <- function(resp) {

  stopifnot(class(resp) == "europeana_search_api")
  stopifnot("Status code is not OK" = resp$response$status_code == 200)
  stopifnot("No items found" = resp$content$itemsCount > 0)

  tidy_data <- lapply(resp$content$items, function(x) {
    res <- sapply(x, function(meta) {
      meta %>%
        unlist() %>%
        paste(collapse = " \n ")
    }) %>%
      data.table() %>%
      transpose() %>%
      setnames(names(x))
  }) %>%
    rbindlist(fill = TRUE)

}
