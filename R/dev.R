#' pkg_rd2markdown
#'
#' convenience function to wrap around rd2markdown::rd2markdown()
#' walks a folder for all Rd files and converts to
#' converts all Rd files in a folder to regular markdown for easier viewing in gitlab/github
#' outputs a list of links that can be pasted into a readme
#'
#' @param in_folder path to man/ where .Rd files created by devtools::documentation/oxygen2
#'        defaults to in_folder="man", out_folder="docs"
#'
#' @examples
#' pkg_rd2markdown("man")
#' @export
#' @import rd2markdown
pkg_rd2markdown <- function(in_folder = "man", out_folder = "docs", ...) {
  links <- c()
  for (f in list.files(in_folder, pattern = ".Rd")) {
    if (dir.exists(out_folder) == FALSE) {
      dir.create(out_folder, recursive = TRUE)
    }
    f_out <- sub(".Rd", ".md", f)
    in_file <- file.path(in_folder, f)
    out_file <- file.path(out_folder, f_out)
    rd <- rd2markdown::get_rd(file = in_file)
    rds <- rd2markdown::rd2markdown(rd, ...)
    write(
      rds,
      sep = "\n",
      file = out_file
    )
    links <- c(links, glue::glue("[{f_out}]({out_file})"))
  }
  result <- paste(links, collapse="\n")
  cat(result)
  # links
}
