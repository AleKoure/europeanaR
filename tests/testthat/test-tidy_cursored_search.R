test_that("Cursored search is OK!", {
  skip_on_cran()
  max_items <- 20
  resp <- tidy_cursored_search(
    query = "animal",
    max_items = max_items,
    theme = "art",
    media = TRUE
  )
  expect_true(is.data.table(resp))
  expect_equal(nrow(resp), max_items)
  expect_true(ncol(resp) > 0)
  expect_true(all(c("id", "guid") %in% names(resp)))
})
