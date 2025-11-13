#' Cleaning data function
#' @description A function that cleans any data set from the EPA TRI program website.
#' @details This function cleans up the inputted data by updating column names to more usable formats.
#' @param data ETA TRI dataset for a state and year
#' @return a data frame
#' @importFrom janitor clean_names
#' @export
#' @examples
#' \dontrun{
#' clean_epa(epa_data)
#'
#' }

clean_epa <- function(data) {
  cleaned <- clean_names(data)
  cleaned <- cleaned |>
    select(x1_year, x3_frs_id, x4_facility_name, x6_city, x7_county, x8_st,
           x9_zip, x12_latitude, x13_longitude, x15_parent_co_name, x21_federal_facility,
           x23_industry_sector, x37_chemical, x38_elemental_metal_included,
           x42_clean_air_act_chemical, x43_classification, x44_metal,
           x46_carcinogen, x47_pbt, x48_pfas, x50_unit_of_measure, x107_total_releases)
  return(cleaned)
}
