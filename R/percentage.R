#' Getting the percentage of how many values of a column are equal to a specific value
#' @description A function for getting the percentage of instances of a specific value
#' @details The user can give a dataset, a column, and a specific value and the function will return the percentage of values in the column that is equal to a specific value.
#' @param data ETA TRI dataset for a state and year
#' @param column Name of a column in data
#' @param value Specific value to count
#' @return percentage
#' @export
#' @examples
#' \dontrun{
#' percentage(ma_2024, "metal", "YES")
#'
#' }

percentage <- function(data, column, value) {
  if (!(column %in% names(data))) {
    stop(paste0("ERROR: ", column, " is not found in this dataset. Please try again with valid column name."))
  } else if (column == "frs_id" || column == "latitude" || column == "longitude") {
    warning("Select a different column for more meaningful results.")
  }

  result <- round((sum(data[[column]] == value) / nrow(data)) * 100, digits = 2)

  if(is.na(result)) {
    return(0)
  }

  return(result)
}
