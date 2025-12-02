test_that("unit_change works", {

  # Checking that lbs --> g works
  expect_equal(unit_change(ma_2024, "g")['unit_of_measure'][[1]][1], "g")

  # Checking that lbs --> kg works
  expect_equal(unit_change(ma_2024, "kg")['unit_of_measure'][[1]][1], "kg")

  # Checking that g --> lbs works
  x <- unit_change(ma_2024, "g")
  expect_equal(unit_change(x, "lbs")['unit_of_measure'][[1]][1], "lbs")

  # Checking that kg --> lbs works
  y <- unit_change(ma_2024, "kg")
  expect_equal(unit_change(y, "lbs")['unit_of_measure'][[1]][1], "lbs")

  # Checking that kg --> g works
  expect_equal(unit_change(y, "g")['unit_of_measure'][[1]][1], "g")

  # Checking that g --> kg works
  expect_equal(unit_change(x, "kg")['unit_of_measure'][[1]][1], "kg")

  # Checking that values stay the same before and after conversion
  t1 <- ma_2024 |> summarize(sum = sum(total_releases)) |> pull()
  t2 <- y |> summarize(sum = sum(total_releases)) |> pull()
  t1 <- t1*0.453592
  expect_equal(t1, t2)

  t1 <- ma_2024 |> summarize(sum = sum(total_releases)) |> pull()
  t3 <- x |> summarize(sum = sum(total_releases)) |> pull()
  t1 <- t1*453.592
  expect_equal(t1, t3)

})
