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
