#' Load package, install package if not installed
#'
#' @param package_list list of packages

#' @export
#' @import utils
loadPackages <- function(package_list) {
  install.packages(base::setdiff(package_list, rownames(installed.packages())))
  for (p in package_list) {
    library(p, character.only = TRUE)
  }
}

#' dictionary_to_markdown
#' convert a dictionary file to a markdown document 
#' for pasting into documentation
#' csv only
#'
#' columns expected: COLUMN,TYPE,DESCRIPTION
#'
#' @param dictionary_file path to dictionary file
#' @param in_file (optional) path to original data file
#' @examples
#' dictionary_to_markdown("../../my_data_dict.csv")
#' @export
#' @import glue
#' @import knitr
#' @import tools
dictionary_to_markdown <- function(dictionary_file, in_file = "") {
  parse_filename <- function(full_path) {
    folder <- dirname(full_path)
    file_with_ext <- basename(full_path)
    filename <- tools::file_path_sans_ext(file_with_ext)
    extension <- tools::file_ext(file_with_ext)

    return(list(
      folder = folder,
      filename = filename,
      extension = extension
    ))
  }

  description_dict <- fast_read_csv(dictionary_file)

  output <- parse_filename(dictionary_file)
  out_file <- glue::glue("{output$filename}_dict.md")
  out_folder <- output$folder

  writeLines(
    glue::glue("__File:__ {in_file} \\"),
    file.path(out_folder, out_file)
  )
  write(
    glue::glue("__Data dictionary:__ {dictionary_file}"),
    sep = "\n", append = TRUE,
    file = file.path(out_folder, out_file)
  )
  md_dict <- knitr::kable(description_dict, "pipe")
  write(
    md_dict,
    sep = "\n", append = TRUE,
    file = file.path(out_folder, out_file)
  )
}
