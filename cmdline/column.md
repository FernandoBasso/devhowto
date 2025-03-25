---
description: Notes, tips, examples and ideas on using the column command.
---

# Column

## Intro

The unix `column` command line utility columnate lists and csv-style data.

For example, if the columns are separated with spaces (and tabs are also considered spaces by default):

```{code} bash
cat <<EOF | column -t
ID NAME EDITOR
1 Bram vim
2 Richard emacs
3 Vader ed
EOF
ID  NAME     EDITOR
1   Bram     vim
2   Richard  emacs
3   Vader    ed
```

Or, if the fields are separated with some other character, like “,” (comma), then we say `-s,` to make `column` use “,” as the separator:

```{code} bash
$ cat <<EOF | column -ts,
ID,NAME,EDITOR
1,Bram,vim
2,Richard,emacs
3,Vader,ed
EOF
ID  NAME     EDITOR
1   Bram     vim
2   Richard  emacs
3   Vader    ed
```

And if the data is on a file, we can do something like this:

```{code} bash
$ column -ts, -- ./heroes.csv 
ID  NAME     EDITOR
1   Bram     vim
2   Richard  emacs
3   Vader    ed
```
