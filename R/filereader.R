#' filereader
#' Function to identify whether an input file is of type
#' csv, dbf or xlsx, and open it accordingly
#
#' @param fname The filename as a string
#' @return Dataframe for the file
#' @export
#' @import openxlsx
#' @import foreign
#' @import utils
filereader <- function(fname) {
  ext <- tolower(tail(strsplit(x = fname, split = "\\.")[[1]], n = 1))

  if (ext == "dbf" | ext == "DBF") {
    x <- read.dbf(fname, as.is = TRUE)
  } else if (ext == "csv" | ext == "CSV") {
    x <- read.csv(fname, as.is = TRUE)
  } else if (ext == "xlsx" | ext == "XLSX" | ext == "xls") {
    x <- read.xlsx(fname)
  } else {
    stop(paste0("** I don't recognize the file type of filename ", fname))
  }
}
#' fast_read_csv
#' Function to open a file via data.table - faster
##'
#' @param fname The filename as a string
#' @param data.table  Default (FALSE) Use data.table=TRUE to return a data.table
#' @inheritDotParams data.table::fread
#' @return Data.table of the input file
#' @seealso [data.table::fread()] which this function wraps.
#' @export
#' @import data.table
#' @import foreign
#' @import utils
fast_read_csv <- function(fname, data.table = FALSE, ...) {
  ext <- tolower(tail(strsplit(x = fname, split = "\\.")[[1]], n = 1))
  if (ext == "csv") {
    if (file.exists(fname)) {
      x <- data.table::fread(fname, data.table = data.table, ...)
    } else {
      stop(paste0("** file not found: ", fname))
    }
  } else {
    stop(paste0("** only supporting csv for now ", fname))
  }
}
