#' County plotting function
#' @description A function for plotting the number of facilities by industry
#' @details This function takes in EPA data and a county of interest. It filters the data to the specified county and groups by the industry sector, creating a plot of the number of chemical releases by facility in that county.
#' @param data ETA TRI dataset for a state and year
#' @param my_county County of interest
#' @return a ggplot object
#' @importFrom ggplot2 ggplot aes geom_col labs theme_bw theme element_text
#' @importFrom janitor clean_names
#' @importFrom dplyr filter group_by summarize n
#' @importFrom forcats fct_reorder
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{
#' county_plot(ma_2024, "ESSEX")
#'
#' }

county_plot <- function(data, my_county) {
  data <- clean_names(data)

  if (!(my_county %in% data$county)) {
    stop(paste0("ERROR: ", my_county, " is not found in state ", data$st[1], ". Please try again with valid county name."))
  }

  g <- data |>
    filter(.data$county == my_county) |>
    group_by(.data$industry_sector) |>
    summarize(number = n()) |>
    ggplot(aes(x = fct_reorder(.data$industry_sector, .data$number, .desc = TRUE), y = .data$number)) +
    geom_col() +
    labs(x = "Industry sector", y = "Number of facility chemical releases",
         title = paste0("Industry Releases in ", my_county, ", ", data$st[[1]])) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  return(g)
}
