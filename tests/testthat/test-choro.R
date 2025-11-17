test_that("Output is correct", {
  # Returning the correct object
  expect_contains(class(choro(ma_2024)), "ggplot")

  # Make sure title is dynamically updating
  expect_match(attributes(choro(ma_2024))$labels[['title']], "MA")
})
