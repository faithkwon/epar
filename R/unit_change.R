#' Changing units
#' @description A function for changing the units of the continuous total release information.
#' @details This is a function that can be used to change and synthesize the units of the total_release variable of the epa data. Original units are in pounds, other than dioxins which are in grams. This function can convert the dioxins to pounds, and then convert everything to kilograms or grams if desired.
#' @param epa_data ETA TRI dataset for a state and year
#' @param new_unit User choice of lbs, kg, or g
#' @return a dataset
#' @importFrom dplyr mutate
#' @importFrom rlang .data
#' @export
#' @examples
#' \dontrun{
#' unit_change(epa_data, "lbs")
#'
#' }
unit_change <- function(epa_data, new_unit) {
  # All lowercase
  epa_data <- epa_data |>
    mutate(unit_of_measure = tolower(.data$unit_of_measure))

  # Define unit to change to
  new_unit <- match.arg(new_unit, choices = c("lbs", "kg", "g"))

  # Convert dioxins g to lbs.
  if ("grams" %in% unique(epa_data$unit_of_measure)) {
    epa_data <- epa_data |>
      mutate(total_release = ifelse(
        .data$unit_of_measure == "grams",
        .data[["total_releases"]] * 0.00220462,
        .data[["total_releases"]]
      )) |>
      mutate(unit_of_measure = "pounds")
  }

  if (new_unit %in% c("pounds")) {
    if("pounds" %in% unique(epa_data$unit_of_measure)) {
      message("Already in pounds.")
    } else if ("kg" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*2.20462, unit_of_measure = "lbs")
    } else if ("g" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*0.00220462, unit_of_measure = "lbs")
    }
  }
  if (new_unit == "kg") {
    if("kg" %in% unique(epa_data$unit_of_measure)) {
      message("Already in kilograms.")
    } else if ("pounds" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*0.453592, unit_of_measure = "kg")
    } else if ("g" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*0.001, unit_of_measure = "kg")
    }
  }
  if (new_unit == "g") {
    if("g" %in% unique(epa_data$unit_of_measure)) {
      message("Already in grams.")
    } else if ("pounds" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*453.592, unit_of_measure = "g")
    } else if ("kg" == unique(epa_data$unit_of_measure)) {
      epa_data <- epa_data |>
        mutate(total_release = .data$total_release*1000, unit_of_measure = "g")
    }
  }
  return(epa_data)
}
