#' Cleaning data function
#' @description A function that cleans any data set from the EPA TRI program website.
#' @details This function cleans up the inputted data by updating column names to more usable formats.
#' @param data ETA TRI dataset for a state and year
#' @return a data frame
#' @importFrom janitor clean_names
#' @importFrom dplyr select rename_with
#' @export
#' @examples
#' \dontrun{
#' clean_epa(epa_data)
#'
#' }

clean_epa <- function(data) {
  cleaned <- clean_names(data)
  cleaned <- cleaned |>
    select(.data$x1_year, .data$x3_frs_id, .data$x4_facility_name, .data$x6_city, .data$x7_county, .data$x8_st,
           .data$x9_zip, .data$x12_latitude, .data$x13_longitude, .data$x15_parent_co_name, .data$x21_federal_facility,
           .data$x23_industry_sector, .data$x37_chemical, .data$x38_elemental_metal_included,
           .data$x42_clean_air_act_chemical, .data$x43_classification, .data$x44_metal,
           .data$x46_carcinogen, .data$x47_pbt, .data$x48_pfas, .data$x50_unit_of_measure, .data$x107_total_releases) |>
    rename_with(~ substring(., 4), .cols = 1:7) |>
    rename_with(~ substring(., 5), .cols = 8:21) |>
    rename_with(~ substring(., 6), .cols = 22)
  return(cleaned)
}

