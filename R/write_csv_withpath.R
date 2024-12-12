#' write_csv_withpath
#' Function to write files and also create folder if it doesn't yet exist.
#
#' @param df Dataframe to write to file
#' @param fname The filename as a string
#' @param ... Additional parameters supported by data.table::fwrite
#' @examples
#' temp1 <- write_csv_withpath(df, "../../Files/thing.csv")
#' @export
#' @import data.table
write_csv_withpath <- function(df, fname, ...) {
  dir_path <- dirname(fname)
  file_path <- basename(fname)

  p <- file.path(dir_path)
  if (dir.exists(p) == FALSE) {
    dir.create(p, recursive = TRUE)
  }
  return(
    data.table::fwrite(df, fname, ...)
  )
}
