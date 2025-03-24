# Bash Brace Expansion

## Intro
Bash brace is useful in a lot of different situations. One of them is to do surgery on text and make more shorter and elegant command lines.

## Moving (renaming) files

``` 
$ mv -v foo-{bar,tux}.txt
renamed 'foo-bar.txt' -> 'foo-tux.txt'

$ mv -v {foo-,}tux.txt
renamed 'foo-tux.txt' -> 'tux.txt'

$ mv -v {,jedi-}tux.txt
renamed 'tux.txt' -> 'jedi-tux.txt'
```
