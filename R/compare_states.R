#' Comparing summary statistics between two states
#' @description A function for comparing statistics of two states
#' @details The user can specify two data sets for different states and the function will return three comparisons between the two: the number of releases, the percentage of hazardous chemicals, and the percentage of carcinogenic chemicals.
#' @param data ETA TRI dataset for a state and year
#' @param data2 ETA TRI dataset for another state and year
#' @return text summarizing differences
#' @importFrom dplyr summarize n pull
#' @export
#' @examples
#' \dontrun{
#' compare_states(ma_2024, tx_2024)
#'
#' }

compare_states <- function(data, data2) {
  state1 <- toupper(data[["st"]][1])
  state2 <- toupper(data2[["st"]][1])

  num_releases <- nrow(data)
  num_releases2 <- nrow(data2)

  perc_hazard <- data |>
    summarize((sum(.data$clean_air_act_chemical == "NO") / n())*100) |>
    pull() |>
    round(digits = 2)

  perc_hazard2 <- data2 |>
    summarize((sum(.data$clean_air_act_chemical == "NO") / n())*100) |>
    pull() |>
    round(digits = 2)

  perc_carcin <- data |>
    summarize((sum(.data$carcinogen == "YES") / n())*100) |>
    pull() |>
    round(digits = 2)

  perc_carcin2 <- data2 |>
    summarize((sum(.data$carcinogen == "YES") / n())*100) |>
    pull() |>
    round(digits = 2)

  cat("Your two states are: ", state1, " and ", state2, ".", "\n")
  cat(state1, " has ", num_releases, " chemical releases.", "\n", state2, " has ", num_releases2, "chemical releases.", "\n")
  cat(perc_hazard, "% of ", state1, "'s chemical releases are classified as hazardous by the Clean Air Act.", "\n", perc_hazard2, "% of ", state2, "'s chemical releases are hazardous.", "\n")
  cat(perc_carcin, "% of ", state1, "'s chemical releases are classified as carcinogens.", "\n", perc_carcin2, "% of ", state2, "'s chemical releases are carcinogens.")
}
