# pkg_rd2markdown

```r
pkg_rd2markdown(in_folder = "man", out_folder = "docs", ...)
```

## Arguments

- `in_folder`: path to man/ where .Rd files created by devtools::documentation/oxygen2 defaults to in_folder="man", out_folder="docs"

## Description

convenience function to wrap around rd2markdown::rd2markdown() walks a folder for all Rd files and converts to converts all Rd files in a folder to regular markdown for easier viewing in gitlab/github outputs a list of links that can be pasted into a readme

## Examples

```r
pkg_rd2markdown("man")
```



