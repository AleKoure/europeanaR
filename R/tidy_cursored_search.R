#' Tidy Cursored Search
#'
#' @description This function is a "runner" of a particular query that consequently makes
#' API requests until maximum items are reached or all related items have been
#' collected.
#'
#' @param query, character string with the search term(s)
#' @param rows, numeric that indicates the number of records to return in each
#' batch with limit up to 100.
#' @param max_items, numeric that indicates max items collected
#' @param ..., other params passed to get request, see also `query_search_api()`
#'
#' @importFrom utils head
#' @export
tidy_cursored_search <- function(query, rows = 100, max_items = 1e4, ...) {

  responses <- list()
  cursor <- "*"

  while(!is.null(cursor)) {
    res <- query_search_api(query, rows = rows, cursor = cursor, ...)
    if(isTRUE(length(res$content$items) == 0)) {
      cursor <- NULL
      next()
    }
    responses[[cursor]] <- res
    item_length <- sapply(responses, function(x) {
      length(x$content$items)
    })
    if(sum(item_length, na.rm = TRUE) >= max_items){
      cursor <- NULL
      next()
    }
    cursor <- res$content$nextCursor
  }

  tidy_item_list <- lapply(responses, function(europeana_res) {
    tidy_search_items(europeana_res)
  })

  res <- rbindlist(tidy_item_list, fill = TRUE)
  head(res, max_items)

}
