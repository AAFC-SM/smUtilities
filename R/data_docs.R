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
  out_file <- glue::glue("{output$filename}.md")
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

#' dictionaries_to_singlepage
#'
#' combine dictionary markdown files in a folder into a single updateable index
#' with an existing file, it will replace replace comment-marked text blocks
#' without changing the rest of the document
#'
#' designed to work with output from dictionary_to_markdown()
#'
#' also designed not to interfere with markdown previews as comments are hidden
#'
#' @param index_file file to use as new or replacement, defaults to '_index.md'
#' @param in_folder folder to search, defaults to 'input'
#' @param start_tpl starting block comment template, defaults to '<!-- START {f} -->'
#' @param end_tpl ending block comment template, defaults to '<!-- END {f} -->'
#' @examples
#' dictionaries_to_singlepage(in_file = "readme.md", in_folder = "./input")
#' @export
#' @import glue
#' @import stringr
dictionaries_to_singlepage <- function(
    index_file = "_index.md",
    in_folder = "./input",
    start_tpl = "<!-- START {f} -->",
    end_tpl = "<!-- END {f} -->") {
  out_file <- file.path(in_folder, index_file)

  # if the index file doesn't exist, create a blank with replaceable sections
  if (file.exists(out_file) != TRUE) {
    # create the file
    header <- c(
      "# Data Dictionary Index",
      "",
      glue::glue("Folder: {in_folder}"),
      ""
    )
    writeLines(header, out_file, sep = "\n")

    for (f in list.files(in_folder, pattern = "_dict.md")) {
      write(glue::glue(start_tpl), out_file, sep = "\n", append = TRUE)
      write(glue::glue(end_tpl), out_file, sep = "\n", append = TRUE)
      write("", out_file, sep = "\n", append = TRUE)
      write("", out_file, sep = "\n", append = TRUE)
    }
  }

  # read in the index file - newly built or previously built
  rmd_content <- readLines(out_file)

  # for each data dictionary markdown in the folder, replace the matching block in the index
  for (f in list.files(in_folder, pattern = "_dict.md")) {
    start_indices <- which(stringr::str_detect(rmd_content, stringr::fixed(glue::glue(start_tpl))))
    end_indices <- which(stringr::str_detect(rmd_content, stringr::fixed(glue::glue(end_tpl))))

    for (i in seq_along(start_indices)) {
      start_idx <- start_indices[i]
      end_idx <- end_indices[i]

      # Replace with your new content here
      new_content <- readLines(file.path(in_folder, f))

      rmd_content <- c(
        rmd_content[1:(start_idx)],
        new_content,
        rmd_content[end_idx:length(rmd_content)]
      )
    }
  }
  writeLines(rmd_content, out_file)
}


#' create_dictionary
#'
#' create a data dictionary csv file based on data input
#' will not update an existing one
#'
#' @param in_file data file to describe
#' @param out_file dictionary file to create, uses defaults to create
#' @param data_ext optional: extension for data to use when creating output file name (.csv)
#' @param output_ext optional: replacement extension (_dict.csv)
#' @examples
#' create_dictionary(in_file = "my_data.csv")
#' @export
create_dictionary <- function(in_file, out_file = "", data_ext = ".csv", output_ext = "_dict.csv") {
  df <- smUtilities::fast_read_csv(in_file)
  out <- sapply(df, class)
  out_df <- data.frame(out)

  if (out_file == "") {
    out_file <- sub(data_ext, output_ext, in_file)
  }

  # set new columns
  out_df$COLUMN <- rownames(out_df)
  out_df$TYPE <- out_df$out
  out_df$DESCRIPTION <- " "

  # remove index
  rownames(out_df) <- NULL
  out_df$out <- NULL

  # write to file only if it doesn't exist
  if (file.exists(out_file) == FALSE) {
    smUtilities::write_csv_withpath(out_df, out_file)
  }
  out_file
}