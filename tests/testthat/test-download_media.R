urls <- c(
  "https://teylers.adlibhosting.com/wwwopacx/wwwopac.ashx?command=getcontent&server=images&value=K%20II%20009.jpg",
  "https://teylers.adlibhosting.com/wwwopacx/wwwopac.ashx?command=getcontent&server=images&value=M%20031.jpg"
)

test_that("download media is OK!", {
  download_data <- download_media(urls)
  expect_true(file.exists(download_data))
  expect_true(
    all(urltools::param_get(urls)$value %in% list.files(path = download_data))
  )
})
