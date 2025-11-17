test_that("percentage works", {
  # Test for when the whole column is one value
  expect_equal(percentage(ma_2024, "year", "2024"), 100)

  # Test for when the column has just two values
  expect_equal(percentage(ma_2024, "carcinogen", "YES"), 27.8)

  # Test for when the column has more than two values
  expect_equal(percentage(ma_2024, "county", "ESSEX"), 9.76)

  # Test for when the column is numeric
  expect_equal(percentage(ma_2024, "zip", 2702), 0.98)
})
