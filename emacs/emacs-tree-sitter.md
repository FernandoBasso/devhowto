---
description: My notes on setting up Tree Sitter with Emacs for a few of the languages I program the most in.
---

# Emacs & Tree Sitter

Emacs 29 started some progress in having a built-in tree sitter implementation (treesit).

There are also the packages tree-sitter and tree-sitter-langs.
Looks like tree-sitter-langs _don't work_ with the built-in treesit.

## Go

Go tree sitter grammar is `go-ts-mode`:

```{code} text
:label: go-ts-mode error

⛔ Warning (treesit): Cannot activate tree-sitter
because language grammar for go is unavailable (not-found):
~/.emacs.d/tree-sitter/libtree-sitter-go:
cannot open shared object file:
No such file or directory ~/.emacs.d/tree-sitter/libtree-sitter-go.0
```

Couldn't find a way to fix that in less than 30 minutes.
What did work was to uninstall the external packages `tree-sitter` and `tree-sitter-langs` and simply use the built-in `treesit`.

In emacs, run `M-x treesit-install-language-grammar` and follow the steps.
On my Arch Linux machine I just accepted all the default options and it all worked fine.

Enable it with `M-x go-ts-mode RTE`, but keep in mind that it replaces `go-mode` for the buffer, making `go-mode` key bindings and other goodies to not work any longer (unless we switch back to `go-mode` with `M-x go-mode RET`.

## Resources and references

- https://github.com/casouri/tree-sitter-module
- https://github.com/emacs-tree-sitter/tree-sitter-langs
- https://github.com/emacs-tree-sitter/tree-sitter-langs/issues/163
- https://leba.dev/blog/2022/12/12/(ab)using-straightel-for-easy-tree-sitter-grammar-installations/
- https://archive.casouri.cc/note/2023/tree-sitter-starter-guide/
https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide
- https://github.com/dominikh/go-mode.el
