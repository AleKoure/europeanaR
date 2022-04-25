#
# resp <- query_search_api("arioch")
# x <- tidy_search_items(resp = resp)
# x
#
# resp <- query_search_api("arioch", qf = "1712")
# x <- tidy_search_items(resp = resp)
# x
#
# resp <- query_search_api("arioch", media = TRUE)
# x <- tidy_search_items(resp = resp)
# x
#
# resp <- query_search_api("arioch", thumbnail = TRUE)
# x <- tidy_search_items(resp = resp)
# x
#
#
# resp <- query_search_api("arioch", landingpage = FALSE)
# x <- tidy_search_items(resp = resp)
# x
#
#
# resp <- query_search_api("arioch", colourpalette = "#2F4F4F")
# x <- tidy_search_items(resp = resp)
# x
#
# resp <- query_search_api("arioch", theme = "art")
# x <- tidy_search_items(resp = resp)
# x
#
# resp <- query_search_api("arioch", sort = "COMPLETENESS")
# x <- tidy_search_items(resp = resp)
# x1 <- x$id
#
#
# resp <- query_search_api("arioch", sort = "COMPLETENESS + timestamp_update")
# x <- tidy_search_items(resp = resp)
# x2 <- x$id
#
# tidy_cursored_search("arioch", rows = 3, theme = "art")
# tidy_cursored_search("arioch", rows = 3)
# tidy_cursored_search("cat", max_items = 1000)
#
#
# resp <- tidy_cursored_search(
#   "animal",
#   rows = 100,
#   max_items = 1000,
#   theme = "art",
#   media = TRUE
# )
#
# resp %>%
#   names()
#
#
