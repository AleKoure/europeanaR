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

  rbindlist(tidy_item_list, fill = TRUE)

}
