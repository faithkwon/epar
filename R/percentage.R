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
  round((sum(data[[column]] == value) / nrow(data)) * 100, digits = 2)
}
