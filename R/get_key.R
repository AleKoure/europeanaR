get_key <- function() {
  api_key <- Sys.getenv("EUROPEANA_KEY")
  stopifnot(`Provide an API key with set_key()` = api_key != "")
  api_key
}
