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
write_csv_withpath <- function(df, fname, atomic = FALSE, ...) {
  dir_path <- dirname(fname)
  file_path <- basename(fname)

  # Ensure directory exists
  if (!dir.exists(dir_path)) {
    dir.create(dir_path, recursive = TRUE)
  }

  if (atomic) {
    # Create a temporary file in the same directory
    temp_file <- tempfile(pattern = "temp_", tmpdir = dir_path)

    # Write to the temporary file first
    data.table::fwrite(df, temp_file, ...)

    # Atomically rename the temporary file to the target filename
    file.rename(temp_file, fname)

  } else {
    data.table::fwrite(df, fname, ...)
  }
  
  return(invisible(fname))

}
