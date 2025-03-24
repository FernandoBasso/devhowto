# Echo and Printf
---

## Intro

> [!NOTE]
> For all the examples that follow, set the `PS1` prompt to a simple `$␠` (the dollar sign followed by a single whitespace) unless otherwise noted. E.g:
>
> ``` bash
> PS1='\$ '
> ```

## echo

### echo and newline

``` shell-session
$ echo -n
```

Why does `echo -n` still produce a newline and the next prompt is on a line of its own?

It is not `echo` that is producing a newline. Because we first add a newline by hitting `Enter` (a.k.a `Return`) in order to execute the command, then bash prints nothing (we provided nothing for `echo` to print), the output is a newline from our `Enter` and nothing else. The `$` prompt is positioned on a line of its own simply because `echo` had nothing to print.

When we do `echo -n foo` and hit `Enter`, we first produce a newline, then bash prints 'foo'.

``` shell-session
$ echo -n foo<Return>
foo$
```

Then the prompt `$` is positioned immediately after 'foo'. After all, we asked `echo` NOT to append a newline, so, `echo` prints 'foo' and the prompt is positioned right after `echo`'s output.

### How to print '-n'?

If we just do `echo -n`, the `-n` is treated as the `-n` option (do not append a newline).

This doesn’t work:

``` shell-session
$ echo -- -n
-- -n.
```

Not what we want…​ We learned in `cmdline End of Options` that a anything following `__` should be treated as a normal string operand, and not as an option to the program. Why then `--` is not working here and preventing `-n` from beting treaded an option‽ Because bash’s `echo` honors [the specs](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html):

> The echo utility shall not recognize the “--” argument in the manner specified by Guideline 10 of XBD Utility Syntax Guidelines; “--” shall be recognized as a string operand.
>
> — echo POSIX spec

We can `man ascii` and look for the numeric value of `--`:

**Excerpt from \`man ascii’.**

``` text
Oct   Dec   Hex   Char
──────────────────────
...
055   45    2D    -
...
```

Then we can use the `-e` option for `echo` and use the octal or hexadecimal values to produce `-` and just implicitly concatenate both `-` and `n`.

``` shell-session
$ echo -e '\055'n
-n

$ echo -e '\x2d'n
-n
```

It has been said that:

> "Any fool can make something complicated. It takes a genius to make it simple.”

Therefore:

``` shell-session
$ echo -n -; echo n;
```

Jokes apart, the version with `-e` and `\x2d` is cool and useful too. It is nice to have the tools and know how to use them.

Nice question and discussion: [When and how was the double-dash (--) introduced as an end of options delimiter in Unix/Linux?](https://unix.stackexchange.com/questions/147143/when-and-how-was-the-double-dash-introduced-as-an-end-of-options-delimiter)

### Prefer printf instead of echo

The use of `echo` is discouraged for several reasons. First, see [echo application usage](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html#tag_20_37_16).

Basically, behaviour differs across implementations making it all but impossible to use `echo` in a reliable and portable way.

Also, observe the output of these commands:

``` shell-session
$ var=-e
$ echo "$var"
```

Nothing is printed. 😮

``` shell-session
$ arr=(-e -n -en -ne)
$ echo "${arr[@]}"
```

Same problem... But we are fine with `printf`:

``` shell-session
$ var=-e
$ printf '%s\n' "$var"
-e
$ arr=(-e -n -en -ne)
$ printf '%s\n' "${arr[@]}"
-e
-n
-en
-ne
```

However, these work with `echo`:

``` shell-session
$ var=-e
$ echo "hello $var"
hello -e

$ arr=(-e -n -en -ne)
$ printf 'hello %s\n' "${arr[@]}"
hello -e
hello -n
hello -en
hello -ne
```

As do these:

``` shell-session
$ echo " $var"
 -e

$ printf ' %s\n' "${arr[@]}"
 -e
 -n
 -en
 -ne
```

In bash's `echo` at least, we can print those *option-like* parameters as long as there is something before them. Even a whitespace before them causes it to work. But do note that the space is preserved in the output.

Well, the options are there, and `echo` can still be used for certain things, but care must be taken.

## printf

Contrary to `echo`, `printf` *does not add a newline by default*.

``` shell-session
$ printf '%s' hello
hello$

$ printf '%s\n' hello
hello
$
```

### Format operand reutilization

Another thing to consider is that the *format operand* (`%s`, `%d`, etc.) is reused until all *argument operands* are consumed:

> "The format operand shall be reused as often as necessary to satisfy the argument operands."
>
> -- [printf POSIX spec](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html)

That explains why even with a single `%s`, the next line prints all argument operands (instead of just the first one):

``` shell-session
$ printf '%s\n' may the force
may
the
force

$ words=(be with you)
$ printf '%s\n' "${words[@]}"
be
with
you
```
