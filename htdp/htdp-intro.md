---
description: My notes, tips and ideas on solutions for the excellent How To Design Programs book.
---

# How To Design Programs Book

## The Book

The [How to Design Programs Book] (HtDP) is the book that has most changed the way I think about, see and do programming.
I have previously gone through the [How to Code: Systematic Program Design Course on EDX][how to code: systematic program design course on edx] (part 1, 2 and 3, free, later updated and renamed to How To Code) which is based on the HtDP book.

During the course -- which also meant I perused the book a lot -- I learned in practice what it means to use TDD to guide the design of programs (together with other concepts), and how tests serve as specification and documentation as much as they serve as tests proper.

This is the number one book I recommend to my friends (online or otherwise), coworkers, alien species, or other creatures I have the chance to do so 😅.
By the way, the authors of the book sometimes answer questions on the [racket-users] google group.

I'm slowly (as time permits) studying the book (not the course this time).
My previous solutions from the course exercises are in my [htcspd gitlab repository].

There is also the [HtDP Plus] page with additional material that further extends the topics covered in the book.

## Design Recipes and Examples

- [CSC120 - How to Design Data Definitions (HtDD)](https://cs.berry.edu/webdocs-common/csc120/docs/recipes/htdd.html).
- [The Program Design Recipe](https://course.ccs.neu.edu/cs5010sp15/recipe.html).
- [Design Recipes | SPD1x | edX](https://courses.edx.org/courses/course-v1:UBCx+SPD1x+2T2015/77860a93562d40bda45e452ea064998b/).

## Racket and BSL

- [A Taste of Racket](https://jeremykun.com/2011/10/02/a-taste-of-racket/)
- [Docs Racket Lang HTDP](http://docs.racket-lang.org/htdp/)
- [The Little JavaScripter](http://www.crockford.com/javascript/little.html) -- Douglas Crockford post.
- <https://github.com/pkrumins/the-little-schemer>
- [Racket guide on how to run .rkt files](https://docs.racket-lang.org/guide/intro.html).
- [Racket docs on Racket scripts](https://docs.racket-lang.org/guide/scripts.html).
- [How to set language to htdp/bsl in REPL](https://stackoverflow.com/questions/46045086/how-to-set-language-to-htdp-bsl-in-repl)
- [How to use htpd/bsl from emacs or command line (my gist)](https://gist.github.com/FernandoBasso/c3f772fff707af3cd2c592e60af77529)
- [htdp/sbl support?](https://gitlab.com/jaor/geiser/-/issues/193) (issue I opened for Geiser)
- [Emacs key bindings in DrRacket?](https://stackoverflow.com/questions/25711372/emacs-key-bindings-in-drracket)
- [The DrScheme repl isn’t the one in Emacs](https://blog.racket-lang.org/2009/03/the-drscheme-repl-isnt-the-one-in-emacs.html) -- Some rationale why DrScheme (now DrRacket) is not a REPL like in
  other Lisps.

1. Add the repos to `.emacs` or `init.el` as described in <https://melpa.org/#/getting-started>.
2. Run `M-x RET package-refresh-contents RET` (they don’t mention it in the tutorial).
3. Run `M-x RET package-install geiser RET`.

Geiser info pages:

```
C-h i m Geiser RET
```

Read about installation notes for [Chicken Scheme stuff](http://www.nongnu.org/geiser/geiser_2.html#Installation).

```
M-x run-geiser
```

Open a `.rkt` file in Emacs.
Whether you have Geiser repl running or not, hit `C-c C-a` and all functions and other definitions inside the `.rkt` file will be available for use in the Geiser REPL.

In Geiser REPL you can do:

```
(enter! "foo.rkt")
(enter! "projs/main.rkt")
```

It will load code on those files into the REPL.
It seems the files must start with `#lang racket` or something like that.
Or, if you are editing a `.rkt` file and want to “enter” it into the REPL:

```
C-c C-a
```

- <http://www.nongnu.org/geiser/geiser_5.html>
- <https://docs.racket-lang.org/reference/interactive.html>

### Teaching Languages — htdp/bsl 📖

```
#lang htdp/bsl
```

[Topic about images in htdp/bsl that shows some useful things.](https://github.com/greghendershott/racket-mode/issues/125)

To run tests like those with `check-expect`, your `.rkt` file must start with one of these (beginner/intermediate/advanced student languages.
The “+” a few more features.

```
#lang htdp/bsl
#lang htdp/bsl+
#lang htdp/isl
#lang htdp/isl+
#lang htdp/asl
```

Or:

```
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area-tests) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
```

### Emacs, Geiser

`C-u C-c C-z` or `C-c C-a` brings one to the REPL in the current module/file.
It DISPLAYS IMAGES! 💖️

`C-c C-k` runs fine with the http languages (`C-c C-a` seems not work for the teaching languages).

But not both.

Then, from `racket-mode`, do `C-c C-t` (runs `racket-test` and be happy.
From the command line,

```
$ raco test file.rkt
```

### Racket Mode

- https://racket-mode.com/

Docs for thing at point: `C-c C-d`. Insert lambda: `C-m-y`.

### Other libs used in the book

- [2htdp/image](https://docs.racket-lang.org/teachpack/2htdpimage.html) → `bitmap`
- [2htdp/universe](https://docs.racket-lang.org/teachpack/2htdpuniverse.html) → `animate`

### DrRacket

- [DrRacket Keyboard Shortcuts](https://docs.racket-lang.org/drracket/Keyboard_Shortcuts.html) (Emacs!!! ⭐️)

`C-x o` to move from interactions to definition window (just like in Emacs, to jump to the “other” window).

**TIP**: To use `(bitmap "../images/foo.png")` make sure the file is saved so the relative path works, otherwise, with an unsaved buffer, DrRacket will try to load images relative to your home directory.

**WARNING**: If you paste/insert images through Racket’s UI, or your you set the language through the UI, you end up with unreadable source code files.
Use a header like one of these and see the next tip about “Determine language from source”.

**TIP**: To allow the line `#lang htdp/<some language>`, make sure “determine language from source” is selected in DrRacket’s bottom left corner.

**TIP**: On wide screens, you may find it useful to display the interactions pane on the right side (instead of at the bottom).
Go to “View → Use Horizontal Layout”.
There is a setting in Preferences too.

### Naming Source Files

Name each source file incrementally and append a descriptive name:

e001e-function.rkt (example from the book, note “e???e…”)
e002e-images.rkt e070p49-rocket-cond.rkt e071p50-tests-traffic-light.rkt

“n” is the exercise number, like “e070p49-rocket-cond.rkt”, meaing we
are at the file 70 written so far, but the practice exercise is 49.

For “World Programs”, use a “wp” as well, like in “e075p51-wp-traffic-light.rkt”.

## Images

- [Drawing Animals Using Simple Shapes](https://www.pinterest.co.uk/sonjaeisenbeiss/drawing-animals-using-simple-shapes/)

## Other Links

Racket Mode: https://racket-mode.com/#Completion

The Animated Guide to Paredit: http://danmidwood.com/content/2014/11/21/animated-paredit.html

## Other People’s Notes and Solutions

- [EDX Systematic Program Design Part 1 Summary](https://courses.edx.org/courses/course-v1:UBCx+SPD1x+2T2015/77860a93562d40bda45e452ea064998b/)
- [eareese solutions](https://github.com/eareese/htdp-exercises/) (gh) seems to have every single exercise solved
- [adaliu-gh](https://github.com/adaliu-gh/htdp) (gh) seems to have the main exercises solved in code
- [HtDP2e-solutions](https://github.com/emaphis/HtDP2e-solutions) [adaliu-gh/htdp: COMPLETE! My solutions to exercises in htdp-2ed (most of them)](https://github.com/adaliu-gh/htdp) - [eareese/htdp-exercises HTDP2e exercise solutions](https://github.com/eareese/htdp-exercises/)

[how to code: systematic program design course on edx]: https://learning.edx.org/course/course-v1:UBCx+SPD1x+2T2016/home
[how to design programs book]: https://htdp.org/
[htcspd gitlab repository]: https://gitlab.com/fernandobasso/htcspd
[htdp plus]: https://felleisen.org/matthias/htdp-plus.html
[racket-users]: https://groups.google.com/g/racket-users
