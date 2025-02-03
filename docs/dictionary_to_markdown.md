# dictionary_to_markdown convert a dictionary file to a markdown document for pasting into documentation csv only

```r
dictionary_to_markdown(dictionary_file, in_file = "")
```

## Arguments

- `dictionary_file`: path to dictionary file
- `in_file`: (optional) path to original data file

## Description

columns expected: COLUMN,TYPE,DESCRIPTION

## Examples

```r
dictionary_to_markdown("../../my_data_dict.csv")
```



