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

Note can shorten `--input --clipboard` to `-i -b`, or simply `-ib`.
Imagine `-b` is for board from clipboard.
`-c` is the short option for `--clear`, so make sure not to misuse `-c` thinking it means `--clipboard`.

And of course, don't forget to take a look at `man xsel`.

## Piping to other program's STDIN

Many programs, including editors (and/or IDEs) can take input from STDIN.
When they do so, they either follow the POSIX spec and use the `-` option to read from STDIN, or they just read from STDIN without any specific option.

For example, vim errors out if we don't provide `-` to attempt to read from STDIN:

```{code} bash
:caption: Wrong way to try to have vim read input from STDIN.
$ echo hello | vim
Vim: Warning: Input is not from a terminal
Vim: Error reading input, exiting...
Vim: preserving files...
Vim: Finished.
```

But using `vim -`, then it works:

```{code} bash
:caption: Correct way to have vim read input from STDIN.
$ echo hello | vim -
```

Now you should have the text “hello” inside the vim buffer, and it will show something like “"-stdin-" 1L, 6B” on vim's command line message.

Other editors like NeoVim and VS Code will read from STDIN with or without the `-` option.
VS Code will (as of 2025 at least) will produce the following warning:

> Run with 'code -' to read from stdin (e.g. 'ps aux | grep code | code -').

Probably, being explicit (even when not strictly required) is a good idea for these things, so, we would do something like this to send STDIN to nvim and code:

```{code} bash
$ echo hello | nvim -
$ echo world | code -
```

For Emacs at least up to version 30 in 2025, there is no option like `-`, but process substitution with `emacs --insert` gives us the same result anyway.

```{code} bash
$ emacs --help | grep -- --insert
--insert FILE   insert contents of FILE into current buffer

$ emacs --insert <(echo hello)
```

We should now have emacs open with the scratch buffer containing the string “hello”.
It works because FILE in Unix can be STDIN (remember that devices like `/dev/{stdin,stdout,stderr}` _are_ files in Unix and Linux in general, which is why we can do things like `echo hello 1> /dev/stdout` and have “hello” printed on the terminal).

Therefore, to pipe the contents of the clipboard as STDIN for some of these programs, it is possible to do something like this:

```{code} bash
$ xsel --output --clipboard | vim -
$ xsel --output --clipboard | nvim -
$ xsel --output --clipboard | code -
$ emacs --insert <(xsel --output --clipboard)
```

## References

- <https://wiki.archlinux.org/title/Clipboard>
