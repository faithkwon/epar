library(janitor)

# Read in the EPA TRI example data from the raw-data folder
ma_2024 <- read.csv("raw_data/2024_ma.csv")

ma_2024 <- clean_names(ma_2024)

# Write this data into the package. Setting "overwrite = TRUE" is necessary if you need to rewrite the data set.
usethis::use_data(ma_2024, overwrite = TRUE)
