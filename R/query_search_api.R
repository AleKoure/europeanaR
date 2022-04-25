#' @description The Search API allows to search the Europeana repository for
#' metadata records and media. The Search API is the most straightforward to
#' use. It works in a similar fashion to the Europeana website when it comes
#' to interacting with the data. You can use the API to search for keywords,
#' and it will return any entries that contain those words. You can refine your
#' search with more advanced queries like Boolean Searches, or you can filter
#' out parts of the results advanced filtering.
#' @import data.table
#' @source https://pro.europeana.eu/page/search
#' @export
query_search_api <- function(query,
                             rows = 12,
                             path = "/record/v2/search.json",
                             ...) {

  stopifnot(`Max rows are 100` = rows <= 100)

  ua <- httr::user_agent("euRopeana (http://my.package.web.site)")

  wskey <- get_key()

  url <- httr::modify_url("https://api.europeana.eu",
                    path = path)

  resp <- httr::GET(url, ua, query = list(query = query, wskey = wskey, ...))

  if (httr::http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(httr::content(resp, "text"),
                               simplifyVector = FALSE)

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "Europeana search API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = "europeana_search_api"
  )

}
