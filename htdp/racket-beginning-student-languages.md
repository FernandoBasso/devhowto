---
description: Notes, ideas, resources and examples on how to use Racket's Beginning Student Langauges (bsl, isl, asl, etc.)
---

# Racket Beginning Student Languages

## Intro

To run tests like those with `check-expect`, your `.rkt` file must start with something like:

```text
#lang htdp/bsl
```

or

```text
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area-tests) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
```

But not both.

Then, from racket-mode, press `C+c C+t` (`racket-test`) and be happy.
From the command line,

```text
$ raco test file.rkt
```

Thanks to user lexi-lambda in #racket IRC server for helping figuring it out.

## List of teaching languages

This is the list of known `#lang` we can use about the teaching languages (beginning, intermediate, advanced):

- `#lang htdp/bsl`
- `#lang htdp/bsl+`
- `#lang htdp/isl`
- `#lang htdp/isl+`
- `#lang htdp/asl`

## Resources

- [Beginning Student (Racket docs)](https://docs.racket-lang.org/htdp-langs/beginner.html).
- [How to use htpd/bsl from emacs or command line (Fernando Basso Github gist)](https://gist.github.com/FernandoBasso/c3f772fff707af3cd2c592e60af77529).
