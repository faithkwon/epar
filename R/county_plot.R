#' County plotting function
#' @description A function for plotting the number of facilities by industry
#' @details This function takes in EPA data and a county of interest. It filters the data to the specified county and groups by the industry sector, creating a plot of the number of chemical releases by facility in that county.
#' @param data ETA TRI dataset for a state and year
#' @param county County of interest
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_col labs theme_bw theme element_text
#' @importFrom janitor clean_names
#' @importFrom dplyr filter group_by summarize n
#' @importFrom forcats fct_reorder
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{
#' county_plot(epa_data, "ESSEX")
#'
#' }

county_plot <- function(data, county) {
  data <- clean_names(data)
  g <- filtered <- data |>
    filter(.data$x7_county == county) |>
    group_by(.data$x23_industry_sector) |>
    summarize(number = n()) |>
    ggplot(aes(x = fct_reorder(.data$x23_industry_sector, .data$number, .desc = TRUE), y = .data$number)) +
    geom_col() +
    labs(x = "Industry sector", y = "Number of facility chemical releases",
         title = paste0("Industry Releases in ", ceounty, ", ", data$x8_st[[1]])) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  return(g)
}
