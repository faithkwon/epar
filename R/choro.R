#' Choropleth mapping function
#' @description A function for mapping chemical releases
#' @details This function takes in EPA data. It then creates a choropleth map using a shapefile joined with the data.
#' @param epa_data ETA TRI dataset for a state and year
#' @param map_labels Add county labels to the map (TRUE, FALSE)
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_sf scale_fill_viridis_c labs theme_void geom_sf_label
#' @importFrom dplyr mutate group_by summarize rename left_join
#' @importFrom rlang .data
#' @importFrom stringr str_to_lower
#' @importFrom sf st_as_sf
#' @export
#' @examples
#' \dontrun{
#' choro(ma_2024, TRUE)
#' choro(tx_2024, FALSE)
#' }
choro <- function(epa_data, map_labels = FALSE) {
  epa_data <- epa_data |>
    rename("STUSPS" = .data$st) |>
    mutate(county = str_to_lower(.data$county))|>
    group_by(.data$STUSPS, .data$county) |>
    summarize(number_releases = n(), .groups = "drop")

  state <- epa_data$STUSPS[1]
  us_counties <- epar::us_counties[epar::us_counties$STUSPS == state, ]

  merged <- us_counties |>
    left_join(epa_data, by = c("county", "STUSPS"))
  merged <- st_as_sf(merged)
  map <- ggplot() +
    geom_sf(data = merged, aes(fill = .data$number_releases)) +
    scale_fill_viridis_c() +
    labs(title = paste0("Chemical releases by county in ", state), fill = "# releases", x = "", y = "")+
    theme_void()

  if (map_labels == TRUE) {
    map <- map +
      geom_sf_label(data = merged, aes(label = .data$county), fill = "white", color = "black", size = 2.5)
  }
  return(map)
}

