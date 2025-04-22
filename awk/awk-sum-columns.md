---
description: Some useful Awk examples of summing columns for different situations.
---

# Awk to Sum Columns

## Simple sum

Consider this `.csv` file:

```{code} text
:filename: sample.csv
ID,AMOUNT
1,3.33
2,8.66
```

We can then use this Awk program to sum the amount column:

```{code} awk
$ awk -F ',' '{ sum+=$2; } END { print sum; }'
```

And then feeding the file to the program:

```{code} bash
$ awk -F ',' '{ sum+=$2; } END { print sum; }' ./sample.csv
11.99
```
