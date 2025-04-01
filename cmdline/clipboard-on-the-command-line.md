---
description: Tips, ideas and examples on working with the clipboard from the command line.
---

# Working With The Clipboard On The Command Line

There are many instances when it is useful to manipulate the system clipboard from the command line.
Some involve scripting, other involve copying and pasting the contents of the clipboard to a command line tool or terminal-based editor.
Let's see some examples.

On Linux, tools like `xsel` and `xclip` are available.
These are supposed to work on Xorg.
For Linux with Wayland, `wl-clipboard` is the alternative.
macOS comes with `pbcopy` and `pbpaste`.

Linuxes complying with the Free Desktop spec should feature two main selections: primary and clipboard.
The primary is the one that you can paste with the middle mouse click.
The clipboard is the default one just like in most other operating systems which can be handled with with normal copy and paste (`kbd`{Ctrl+c}  `kbd`{Ctrl+v}).

- <https://wiki.archlinux.org/title/Clipboard>

Let's look at some examples.

## xsel

Copy the output of a command and save it on the 

```{code} bash
$ printf '%s\n' Hello. | xsel --input --clipboard
$ xsel --output --clipboard
Hello.

$ date | xsel --input --clipboard
$ xsel --output --clipboard
Tue Apr  1 05:30:33 PM -03 2025
```
