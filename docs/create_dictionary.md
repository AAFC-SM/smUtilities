# create_dictionary

```r
create_dictionary(
  in_file,
  out_file = "",
  data_ext = ".csv",
  output_ext = "_dict.csv"
)
```

## Arguments

- `in_file`: data file to describe
- `out_file`: dictionary file to create, uses defaults to create
- `data_ext`: optional: extension for data to use when creating output file name (.csv)
- `output_ext`: optional: replacement extension (_dict.csv)

## Description

create a data dictionary csv file based on data input will not update an existing one

## Examples

```r
create_dictionary(in_file = "my_data.csv")
```



