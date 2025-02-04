# dictionaries_to_singlepage

```r
dictionaries_to_singlepage(
  index_file = "_index.md",
  in_folder = "./input",
  start_tpl = "<!-- START {f} -->",
  end_tpl = "<!-- END {f} -->"
)
```

## Arguments

- `index_file`: file to use as new or replacement, defaults to '_index.md'
- `in_folder`: folder to search, defaults to 'input'
- `start_tpl`: starting block comment template, defaults to '<!-- START f -->'
- `end_tpl`: ending block comment template, defaults to '<!-- END f -->'

## Description

combine dictionary markdown files in a folder into a single updateable index with an existing file, it will replace replace comment-marked text blocks without changing the rest of the document

## Details

designed to work with output from dictionary_to_markdown()

also designed not to interfere with markdown previews as comments are hidden

## Examples

```r
dictionaries_to_singlepage(in_file = "readme.md", in_folder = "./input")
```



