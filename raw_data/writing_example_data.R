# Read in the EPA TRI example data from the raw-data folder
ma_2024 <- read.csv("raw_data/2024_ma.csv")
tx_2024 <- read.csv("raw_data/2024_tx.csv")

# Cleaning the data
ma_2024 <- clean_epa(ma_2024)
tx_2024 <- clean_epa(tx_2024)

# Write this data into the package. Setting "overwrite = TRUE" is necessary if you need to rewrite the data set.
usethis::use_data(ma_2024, overwrite = TRUE)
usethis::use_data(tx_2024, overwrite = TRUE)

# Writing in the US counties shapefile so it isn't retrieved every time a map function is called
library(tigris)
library(dplyr)
library(stringr)
us_counties <- tigris::counties(cb = TRUE)
us_counties <- us_counties |>
  rename("county" = "NAME")|>
  mutate(county = str_to_lower(.data$county)) |>
  select(!c(NAMELSAD, LSAD, AWATER, ALAND, GEOID, GEOIDFQ, COUNTYNS))
usethis::use_data(us_counties, overwrite = TRUE)
