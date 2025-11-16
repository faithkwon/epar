testthat::test_that("chemstats works", {
  # test that # of counties is correct
  expect_equal(nrow(chemstats(ma_2024, "county")), dplyr::n_distinct(ma_2024[["county"]]))

  # test that # of cities is correct
  expect_equal(nrow(chemstats(ma_2024, "city")), dplyr::n_distinct(ma_2024[["city"]]))

  # test that # of zips is correct
  expect_equal(nrow(chemstats(ma_2024, "zip")), dplyr::n_distinct(ma_2024[["zip"]]))


})
