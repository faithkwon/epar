#' Simple mapping function
#' @description A function for mapping chemical releases
#' @details This function takes in EPA data and a grouping variable. It then creates a simple geographic scatter plot using lat/lon coordinates, differentiating by the grouping variable.
#' @param data ETA TRI dataset for a state and year
#' @param grouping_var Categorical variable to group by ("classification", "carcinogen", "federal_facility", "pbt", "pfas")
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_sf geom_point labs theme_bw scale_size_continuous
#' @importFrom janitor clean_names
#' @importFrom dplyr filter mutate
#' @importFrom rlang .data
#' @importFrom scales comma
#' @export
#' @examples
#' \dontrun{
#' mapchems(ma_2024, "classification")
#'
#' }

mapchems <- function(data, grouping_var = "classification") {
  grouping_var <- match.arg(grouping_var, choices = c("classification", "carcinogen", "federal_facility", "pbt", "pfas"))

  counties <- epar::us_counties |>
    filter(.data$STUSPS == data$st[1])

  data <- data |>
    mutate(total_release = ifelse(
      .data$unit_of_measure == "Grams",
      .data[["total_releases"]] * 0.00220462,
      .data[["total_releases"]]
    )) |>
    filter(.data$total_release > 0)

  ggplot() +
    geom_sf(data = counties, fill = "white", color = "black") +
    geom_point(data = data, aes(x = .data$longitude, y = .data$latitude, color = .data[[grouping_var]], size = .data[["total_releases"]])) +
    theme_bw() +
    scale_size_continuous(name = "Total release (lbs)", labels = comma) +
    labs(title = paste0(data$st[1], " Chemical Releases with ", grouping_var),
         x = "", y = "")
}

