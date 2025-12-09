test_that("mapchems works", {
  # Returning the correct object
  expect_contains(class(mapchems(ma_2024)), "ggplot")

  # Ensure no messages
  expect_silent(mapchems(ma_2024))

  # Return error if not given correct argument
  expect_error(mapchems(ma_2024, "o"))

  # Return error if multiple states in the dataset
  z <- rbind(ma_2024, tx_2024)
  expect_error(mapchems(z))
})
