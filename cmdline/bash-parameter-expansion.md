# Bash Parameter Expansion

## Remove newline

Similar to `tr -d '\n`, we can also do in pure bash:

``` bash
"${var//[$'\t\r\n']}"
```
