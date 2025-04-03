---
description: Some concepts, notes and ideas on newlines, both on command line and on files.
---

# Newline

## Intro

:::{tip}
The POSIX standard requires a new line at the end of properly formatted file.
:::

Disadvantages of not having a final newline in files:

- Some cli tools and other programs will miss the last line if it's not terminated by a line feed.
- It can mess up the git diff if you add to/after the last line as ideally you want a clear line delineation of the change.

## How to find files without a final newline?

### rg

Ripgrep is written in Rust, and Rust regexes provide `\z` to match “the end of text or file”.
[See their docs](https://docs.rs/regex/1.3.3/regex/#empty-matches).

```{code} bash
$ rg --multiline --files-with-matches '[^\n]\z'
```

