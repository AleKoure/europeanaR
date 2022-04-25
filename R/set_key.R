set_key <- function(api_key) {
  stopifnot(is.character(api_key))
  Sys.setenv(EUROPEANA_KEY = api_key)
}
