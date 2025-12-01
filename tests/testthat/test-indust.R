test_that("indust works", {
  # Test that the top industry returns correctly
  expect_equal(indust(ma_2024, "pbt", 1)[[1]], "Furniture")

  # Test that the number of chemical releases is correct
  expect_equal(indust(tx_2024, "pbt", 1)[[3]], 337)

  # Test that the expected number of columns is correct
  expect_length(indust(ma_2024, "pbt"), 3)

  # Test that the proportion outputted is correct
  expect_equal(indust(tx_2024, 'pbt', 1)[[2]], 71.702128)
})
