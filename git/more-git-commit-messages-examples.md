---
description: Add more examples on git commit messages with insights on some what's and why's.
---

# More Git Commit Message Examples

## Detailed commit message with ASCII drawing

This is a commit that has to do with CSS styling and layout. The author
provides a visual example on how it looks before and after the commit.
The ASCII representation of the new UI is a nice touch and provides a
very clear picture (no pun intended) of results of applying the commit.

``` 
dev-how-to [devel *% u=]
$ git log -1
commit 86513e14fc97c124340053a471fa82400fb62119 (HEAD -> devel, gl/devel)
Author: Fernando Basso <redacted email>
Date:   Thu Aug 26 07:49:30 2021 -0300

style: Add borders and text around QandaA containers

Currently, there is no visual clue for the users as to where both the
question and answer start and end. This commit adds some borders and
text labels around the question and the answer to help visually identify
what part is the question and what part is the answer.

Before this commit, the question and answer look like this:

    How to see what is in gl/devel but not in HEAD?

    Easy enough: 😄

    $ git log HEAD..gl/devel

 And this is how it should like after this commit:

                          +----------+
    +---------------------| question |-+
    |                     +----------+ |
    | How to see what is in gl/devel   |
    | but not in HEAD?                 |
    +----------------------------------+
                            +--------+
    +-----------------------| answer |-+
    |                       +--------+ |
    | Easy enough: 😄                  |
    |                                  |
    |   $ git log HEAD..gl/devel       |
    +----------------------------------+
```

:::: note
::: title
Note
:::

It is not that hard to draw some ASCII boxes in vim with `virtualedit`.

In vim:

``` 
:help 'virtualedit'
:set virtualedit=all
```
::::

## fzf Junegunn Choi Awesome Commit Message

- Use of proper imperative mood in the subject line.
- Well formatted with reasonable line lengths and proper empty lines when appropriate.
- Documents the new behavior.
- Documents how to get previous behavior if one prefers that.
- Documents fallback if using older version of Vim which does not yet support popup window.
- Informs _why_ this change exists: To make use of the (new) Vim popup window feature (at the time it was new).

```text
fzf [master u=]
$ git show c60ed175831
commit c60ed1758315f0d993fbcbf04459944c87e19a48
Author: Junegunn Choi <hidden-email@example.com>
Date:   Sat Sep 12 21:08:05 2020 +0900

    [vim] Change the default layout to use popup window

    The new default is

      { 'window' : { 'width': 0.9, 'height': 0.6, 'highlight': 'Normal' } }

    The default highlight group for the border of the popup window is
    'Comment', but 'Normal' seems to be a safer choice.

    If you prefer the previous default, add this to your Vim configuration file:

      let g:fzf_layout = { 'down': '40%' }

    (fzf will fall back to this if popup window is not supported)
```

- [Commit from the example above on fzf repository](https://github.com/junegunn/fzf/commit/c60ed175831)
