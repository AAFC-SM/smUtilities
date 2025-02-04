# smUtilities

R utilities functions helpful to projects

## Installation
This can be installed directly from gitlab using [remotes package](https://remotes.r-lib.org/)
```R
remotes::install_github("AAFC-SM/smUtilities")
```

## Usage
* [create_dictionary.md](docs/create_dictionary.md)
* [dictionaries_to_singlepage.md](docs/dictionaries_to_singlepage.md)
* [dictionary_to_markdown.md](docs/dictionary_to_markdown.md)
* [dropcolumns.md](docs/dropcolumns.md)
* [fast_read_csv.md](docs/fast_read_csv.md)
* [filereader.md](docs/filereader.md)
* [keepcolumns.md](docs/keepcolumns.md)
* [loadPackages.md](docs/loadPackages.md)
* [pkg_rd2markdown.md](docs/pkg_rd2markdown.md)
* [write_csv_withpath.md](docs/write_csv_withpath.md)


## Building documentation and testing locally
This will work locally in R environment.
* increment version - DESCRIPTION
* inline documentation with functions
* run doxygen2 `roxygen2::roxygenise()` or `devtools::document`
* run `smUtilities::pkg_rd2markdown()` to get a list of markdown links of the functions to use in the readme
