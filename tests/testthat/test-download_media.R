test_that("download media is OK!", {
  skip_on_cran()
  test_dir <- tempdir()
  resp <- query_search_api("arioch", rows = 2)
  download_dir <- download_media(resp,
                                  type_ = "IMAGE",
                                  download_dir = test_dir)
  expect_true(file.exists(download_dir))
  dat <- tidy_search_items(resp)
  expect_true(
    all(gsub( ".*/", "",
              dat[type == "IMAGE", id]) %in% list.files(path = download_dir))
  )
})
