#' Mapping function
#' @description A mapping function that visualizes what % of chemical releases are carcinogens by factory
#' @details This function takes in EPA data and graphs a simple map of the state and plots each facility. Then, according to what the user specifies, the points are either colored(1), sized(2), or both(3) according to the percentage of chemical releases that are carcinogens.
#' @param data ETA TRI dataset for a state and year
#' @param props Categorical variable to group by ("1", "2", "3"), depending on what the user wants the map to look like.
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_sf geom_point labs theme_bw
#' @importFrom dplyr filter mutate summarize group_by
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{
#' facil(ma_2024, 3)
#'
#' }

facil <- function(data, props = c(1, 2, 3)) {
  counties <- epar::us_counties |>
    filter(.data$STUSPS == data$st[1])

  summed <- data |>
    group_by(.data$facility_name, .data$latitude, .data$longitude) |>
    summarize(carcin_perc = sum(.data$carcinogen == "YES")/n()*100)

  print(summed)

  result <- ggplot() +
    geom_sf(data = counties,
            fill = "white",
            color = "black") +
    theme_bw() +
    labs(title = paste0(data$st[1] ," Chemical Releases by Facility"),
         color = "% Carcinogen", size = "% Carcinogen", x = "", y = "")

  if (props == 1) {
    # only color
    result <- result +
      geom_point(data = summed,
                 aes(x = .data$longitude, y = .data$latitude, color = .data$carcin_perc))
  } else if (props == 2) {
    # only size
    result <- result +
      geom_point(data = summed,
                 aes(x = .data$longitude, y = .data$latitude, size = .data$carcin_perc))
  } else if (props == 3) {
    # both color and size
    result <- result +
      geom_point(data = summed,
                 aes(x = .data$longitude, y = .data$latitude, size = .data$carcin_perc, color = .data$carcin_perc))
  }

  return(result)

}
