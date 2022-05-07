
init_time <- Sys.time()
query <- "(when:17 OR when:16 OR when:15 OR when:14)"
res_bulk <- tidy_cursored_search(query, qf = "what:painting", max_items = 50)
Sys.time() - init_time
# res <- query_search_api(query, rows = 100)
# tidy_search_items(res) %>%
#   View()

# saveRDS(res_bulk, "data-raw/res_bulk.rds")
