#' Statistic summary by area
#' @description A function for summarizing statistics of a given area
#' @details The user can specify county, city, or zip code, and from there this function will return the number of releases, the percentage of carcinogens, the percentage of hazardous chemicals, and the top industry by counties/cities/zips.
#' @param data ETA TRI dataset for a state and year
#' @param area User choice of county, city or zip
#' @return summary statistics
#' @importFrom dplyr filter group_by summarize n arrange slice select left_join rename
#' @export
#' @examples
#' \dontrun{
#' chemstats(epa, "county")
#'
#' }

chemstats <- function(data, area = c("county", "city", "zip")) {

  grouping_var <- switch(area,
                         "county" = "x7_county",
                         "city" = "x6_city",
                         "zip" = "x9_zip")

  temp <- data |>
    group_by(.data[[grouping_var]], x23_industry_sector) |>
    summarize(sum = n()) |>
    arrange(desc(sum)) |>
    slice(1) |>
    select(!sum)

  result <- data |>
    group_by(.data[[grouping_var]]) |>
    summarize(num_releases = n(),
              percent_carcinogen = (sum(x46_carcinogen == "YES") / n())*100,
              percent_hazard = (sum(x42_clean_air_act_chemical == "NO") / n())*100) |>
    left_join(temp,
              by = grouping_var) |>
    rename(top_industry = x23_industry_sector) |>
    rename_with(~ substring(., 4), .cols = 1) # this deletes the first three letters of the column name for the grouping variable (eg. x7_county --> county)

  return(result)
}
