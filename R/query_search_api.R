#' Europeana Search Api
#'
#' @description The Search API allows to search the Europeana repository for
#' metadata records and media. The Search API is the most straightforward to
#' use. It works in a similar fashion to the Europeana website when it comes
#' to interacting with the data. You can use the API to search for keywords,
#' and it will return any entries that contain those words. You can refine your
#' search with more advanced queries like Boolean Searches, or you can filter
#' out parts of the results advanced filtering.
#'
#' @param query, character string with the search term(s)
#' @param rows, numeric that indicates the number of records to return
#' @param path, character string that describers API version
#' @param ..., other parameters passed in get request
#' @details In the query parameter the Apache Lucene Query Syntax is inheritly
#' supported by the Search API. Users can use Lucene and Apache SOLR guides to
#' get the most out of the Europeana repository. The most basic usage is for
#' searching particular keywords,
#' - `qf` String	Query Refinement. This parameter can be defined more than
#'  once. See Query Syntax page for more information.
#' - `reusability` String	Filter by copyright status. Possible values are open,
#'  restricted or permission.
#' - `media`	Boolean	Filter by records where an URL to the full media file is
#'  present in the edm:isShownBy or edm:hasView metadata and is #' resolvable.
#' - `thumbnail`	Boolean	Filter by records where a thumbnail image has been
#'  generated for any of the WebResource media resources
#'  (thumbnail #' available in the edmPreview field).
#' - `landingpage`	Boolean	Filter by records where the link to the original
#' object on the providers website (edm:isShownAt) is present and verified
#' to be working.
#' - `colourpalette`	String	Filter by images where one of the colours
#' (see colour palette) of an image matches the provided colour code. You can
#' provide this parameter multiple times, the search will then do an 'AND'
#' search on all the provided colours.
#' - `theme` String	Restrict the query over one of the Europeana Thematic
#' Collections. The possible values are: archaelogy, art, fashion,
#' industrial, manuscript, map, migration, music, nature, newspaper,
#' photography, sport, ww1.
#' - `sort`	String	Sorting records in ascending or descending order of search
#' fields. The following fields are supported: score (relenvancy of
#' the search result), timestamp_created, timestamp_update, europeana_id,
#' COMPLETENESS, is_fulltext, has_thumbnails, and has_media. Sorting on more
#' than one field is possible by supplying as comma separated values. It is
#' also possible to randomly order items by using the keyword "random" instead
#' of a field name. You can also request for a fixed random order by indicating
#' a seed "random_SEED" which is useful when paginating along the same
#' randomized order. Use: field_name+sort_order.
#' ```
#' query_search_api("arioch")
#' ````
#' For more details on the synatx of queries read the officila Europeana
#' documentation[QUERY SYNTAX](https://pro.europeana.eu/page/search#syntax).
#'
#' @source https://pro.europeana.eu/page/search
#'
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
