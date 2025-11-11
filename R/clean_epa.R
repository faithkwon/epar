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
  return(cleaned)
}
