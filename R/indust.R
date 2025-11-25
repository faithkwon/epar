#' Industry information
#' @description A function for exploring properties of different industry sectors in a given state.
#' @details The user can provide EPA data and a binary grouping variable of interest. The function will return the variable proportion for each industry sector, while also specifying the number of releases.
#' @param data ETA TRI dataset for a state and year
#' @param grouping_var Binary variable to group by ("carcinogen", "pfas", "pbt", "federal_facility", "clean_air_act_chemical", "elemental_element_included", "metal")
#' @param return_all Determines whether the function returns a full or truncated table ("TRUE" for full, or a number for the top X rows)
#' @return tibble
#' @importFrom dplyr mutate case_when filter group_by summarize ungroup select rename rename_with arrange
#' @importFrom utils head
#' @export
#' @examples
#' \dontrun{
#' indust(ma_2024, "pbt")
#' }

indust <- function(data, grouping_var = "carcinogen", return_all = TRUE) {
  grouping_var <- match.arg(grouping_var, choices = c("carcinogen", "pfas", "pbt", "federal_facility", "clean_air_act_chemical", "elemental_element_included", "metal"))

  data <- data|>
    mutate(gvar = case_when(
      .data[[grouping_var]] == "YES" ~ 1,
      .data[[grouping_var]] == "NO" ~ 0
    ))

  if (nrow(data |> filter(.data$gvar == 1)) == 0) {
    stop(paste0(data$st[[1]], " does not have chemical releases for ", grouping_var, "."))
  }

  table <- data |>
    group_by(.data$industry_sector, .data$gvar) |>
    summarize(number_releases = n(), .groups = "drop_last") |> # drop only the grouping variable
    mutate(percent = (.data$number_releases / sum(.data$number_releases))*100) |>
    ungroup() |>
    filter(.data$gvar == 1) |>
    select(.data$industry_sector, .data$percent, .data$number_releases) |>
    arrange(desc(.data$percent)) |>
    rename("Number of releases" = .data$number_releases) |>
    rename("Industry sector" = .data$industry_sector) |>
    rename_with(~ paste("Percent", grouping_var), .data$percent) # dynamically update column name

  if (!isTRUE(return_all)) {
    table <- table |> head(return_all) # deciding whether to truncate the tibble output
  }

  return(table)
}
