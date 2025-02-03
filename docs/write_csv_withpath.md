# write_csv_withpath Function to write files and also create folder if it doesn't yet exist.

```r
write_csv_withpath(df, fname, ...)
```

## Arguments

- `df`: Dataframe to write to file
- `fname`: The filename as a string
- `...`: Additional parameters supported by data.table::fwrite

## Description

write_csv_withpath Function to write files and also create folder if it doesn't yet exist.

## Examples

```r
temp1 <- write_csv_withpath(df, "../../Files/thing.csv")
```



