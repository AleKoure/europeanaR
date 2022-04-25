devtools::load_all()

#
# towns <- c("Paris", "Rome", "London", "Amsterdam", "Madrid", "Copenhagen",
#            "Berlin", "Vienna")
#
# res <- parallel::mclapply(towns, function(town) {
#
#   print(paste0("Download for ", town))
#
#   dat <- tidy_cursored_search(
#     paste0("where:", town),
#     rows = 100,
#     max_items = 100000,
#     theme = "art",
#     media = TRUE
#   )
#
#   saveRDS(dat, paste0("data-raw/town_art_obj/", town, ".rds"))
#
#   print(paste0("Saved for ", town))
#
# }, mc.cores = 5L)
#
# town <- "France"
#
# dat <- tidy_cursored_search(
#   paste0("where:", town),
#   rows = 100,
#   max_items = 100000,
#   theme = "art",
#   media = TRUE
# )



# towns <- c(
#   "France",
#   "Germany",
#   "Italy",
#   "Spain"
# )

towns <- c(
  "United Kingdom",
  "Austria"
)

res <- lapply(towns, function(town) {

  print(paste0("Download for ", town))

  dat <- tidy_cursored_search(
    paste0("where:", town),
    rows = 100,
    max_items = 100000,
    theme = "art",
    media = TRUE
  )

  saveRDS(dat, paste0("data-raw/town_art_obj/", town, ".rds"))

  print(paste0("Saved for ", town))

})

