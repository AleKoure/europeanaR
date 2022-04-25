test_that("Cursored search is OK!", {
  max_items <- 10
  resp <- tidy_cursored_search(
    "animal",
    rows = 2,
    max_items = max_items,
    theme = "art",
    media = TRUE
  )
  expect_true(is.data.table(resp))
  expect_equal(nrow(resp), max_items)
  expect_true(ncol(resp) > 0)
  expect_true(all(c("id", "guid") %in% names(resp)))
})
