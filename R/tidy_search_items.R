#' @import data.table magrittr
#' @export
tidy_search_items <- function(resp) {

  stopifnot(class(resp) == "europeana_search_api")

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
