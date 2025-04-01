---
description: Tips, ideas and examples on working with the clipboard from the command line.
---

# Working With The Clipboard On The Command Line

There are many instances when it is useful to manipulate the system clipboard from the command line.
Some involve scripting, other involve copying and pasting the contents of the clipboard to a command line tool or terminal-based editor.
Let's see some examples.

On Linux desktop environments and window managers running on Xorg, tools like `xsel` and `xclip` can be used.
If using Wayland, `wl-clipboard` is the alternative.
macOS comes with `pbcopy` and `pbpaste`.

Linuxes complying with the Free Desktop spec should feature two main selections: primary and clipboard.
The primary selection is the one that you can paste with the middle mouse click.
The clipboard is the one that works just like in most other operating systems which can be handled with with normal copy and paste ({kbd}`Ctrl` + {kbd}`c` and {kbd}`Ctrl` + {kbd}`v`).

Let's look at some examples.

## xsel

In this first example, we `printf` a simple text, copy it to the clipboard, then send it to STDOUT:

```{code} bash
$ printf '%s\n' Hello. | xsel --input --clipboard
$ xsel --output --clipboard
Hello.
```

And here we do a very similar thing, but with the output of `date` instead:

```{code} bash
$ date | xsel --input --clipboard
$ xsel --output --clipboard
Tue Apr  1 05:29:33 AM -03 2025
```

## References

- <https://wiki.archlinux.org/title/Clipboard>
