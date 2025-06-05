---
title: The cp Command
description: Tips, notes, explanations and examples on the usage of the cp command line utility
----

## Intro

```shell-session
$ ls docs/algdsts/!(index).md
docs/algdsts/big-O-arrays-objects.md  docs/algdsts/problem-solving.md
docs/algdsts/helper-functions.md      docs/algdsts/space-complexity-examples.md
docs/algdsts/logarithms.md

$ mv -v docs/algdsts/!(index).md ./docs/algorithms-data-structures/
renamed 'docs/algdsts/big-O-arrays-objects.md' -> './docs/algorithms-data-structures/big-O-arrays-objects.md'
renamed 'docs/algdsts/helper-functions.md' -> './docs/algorithms-data-structures/helper-functions.md'
renamed 'docs/algdsts/logarithms.md' -> './docs/algorithms-data-structures/logarithms.md'
renamed 'docs/algdsts/problem-solving.md' -> './docs/algorithms-data-structures/problem-solving.md'
renamed 'docs/algdsts/space-complexity-examples.md' -> './docs/algorithms-data-structures/space-complexity-examples.md'
```

## Turn directory hierarchy into full filename

In this example, we have files with the same name `input.json` inside directories named numerically:

```{code} bash
$ ls -1 examples/**/input.json
examples/1/input.json
examples/2/input.json
examples/3/input.json
examples/4/input.json
examples/5/input.json
examples/6/input.json
examples/7/input.json
examples/8/input.json
```

And we want to copy those files to some other directory, but keeping the directory structure as part of the filename itself, so that `examples/1/input.json` would become `examples-1-input.json`.

A good tip is to try the string transformations with either `echo` or `printf`:

```{code} bash
for file in examples/**/input.json
do
  printf '%s\n' "$file" | tr '/' '-'
done

examples-1-input.json
examples-2-input.json
examples-3-input.json
examples-4-input.json
examples-5-input.json
examples-6-input.json
examples-7-input.json
examples-8-input.json
```

Yep, that works!
Therefore, we make use the `cp` command to copy all those files:

```{code} bash
for file in examples/**/input.json
do
  cp -v "$file" "$(printf '%s' "$file" | tr '/' '-')"
done

'examples/1/input.json' -> 'examples-1-input.json'
'examples/2/input.json' -> 'examples-2-input.json'
'examples/3/input.json' -> 'examples-3-input.json'
'examples/4/input.json' -> 'examples-4-input.json'
'examples/5/input.json' -> 'examples-5-input.json'
'examples/6/input.json' -> 'examples-6-input.json'
'examples/7/input.json' -> 'examples-7-input.json'
'examples/8/input.json' -> 'examples-8-input.json'
```
