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
