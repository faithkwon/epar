#' Choropleth mapping function
#' @description A function for mapping chemical releases
#' @details This function takes in EPA data. It then creates a choropleth map using a shapefile joined with the data.
#' @param data ETA TRI dataset for a state and year
#' @param map_labels Add county labels to the map (TRUE, FALSE)
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_sf scale_fill_viridis_c labs theme_void geom_sf_label
#' @importFrom dplyr filter mutate group_by summarize rename left_join
#' @importFrom rlang .data
#' @importFrom stringr str_to_lower
#' @importFrom tigris counties
#' @export
#' @examples
#' \dontrun{
#' choro(ma_2024, TRUE)
#' choro(tx_2024, FALSE)
#' }
choro <- function(data, map_labels = FALSE) {
  data <- data |>
    mutate(county = str_to_lower(.data$county))|>
    rename("total_releases" = .data$`_total_releases`) |>
    group_by(.data$st, .data$county) |>
    summarize(number_releases = n())

  us_counties <- tigris::counties(cb = TRUE)
  us_counties <- us_counties |>
    rename("county" = "NAME") |>
    rename("st" = "STUSPS") |>
    mutate(county = str_to_lower(.data$county)) |>
    filter(.data$st == .data$st[1])

  merged <- us_counties |>
    left_join(data, by = c("county", "st"))

  map <- ggplot() +
    geom_sf(data = merged, aes(fill = .data$number_releases)) +
    scale_fill_viridis_c() +
    labs(title = "Chemical releases by county", fill = "# releases", x = "", y = "")+
    theme_void()

  if (map_labels == TRUE) {
    map <- map +
      geom_sf_label(data = merged, aes(label = .data$county), fill = "white", color = "black", size = 2.5)
  }
  return(map)
}
