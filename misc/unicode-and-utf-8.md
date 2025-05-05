---
description: Notes, ideas and examples about text encoding and Unicdode in general
---

# Unicode and UTF-8

## Detect file encoding with the `file` tool

```{code} shell
$ file -k ./my-file-broken.csv
./my-file-broken.csv: CSV text
Non-ISO extended-ASCII text, with very long lines (344),
with CRLF line terminators

$ file -k ./my-file-utf-8.txt 
./my-file-utf-8.csv: Unicode text, UTF-8 text

$ file -b --mime-encoding -P bytes=4096 ./my-file-broken.csv 
unknown-8bit

$ file -b --mime-encoding -P bytes=4096 ./my-file-utf-8.txt
utf-8
```

## Detect file encoding with the `encguess` tool

```{code} shell
$ encguess ./my-file-broken.csv 
my-file-broken.csv	unknown

$ encguess ./my-file-utf-8.txt 
./my-file-utf-8	UTF-8
```
