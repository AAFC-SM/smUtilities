#' dropcolumns
#' Function to filter the columns in the dataframe
#
#' @param dfname Dataframe
#' @param colslist List of column names to drop
#' @return Dataframe without those columns
#' @examples
#' temp1 <- dropcolumns(df, c("One", "Two", "Three"))
#' @export
dropcolumns <- function(dfname, colslist) {
  #add error handling.  If column doesn't exist???
  tmpdf <- subset(dfname, select = !(names(dfname) %in% colslist))

}

#' keepcolumns
#' Function to filter the columns in the dataframe
#
#' @param dfname Dataframe
#' @param colslist List of column names to keep
#' @return Dataframe with only those columns
#' @examples
#' temp1 <- keepcolumns(df, c("One", "Two", "Three"))
#' @export
keepcolumns <- function(dfname, colslist) {
  tmpdf <- subset(dfname, select = (names(dfname) %in% colslist))
}
