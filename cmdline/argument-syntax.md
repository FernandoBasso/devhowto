# Shell Argument Syntax

There are a few, but **extremely important** concepts that we must keep in mind to make reasonable use of the command line and write shell scripts in general.

## Whitespace and Quoting

In the shell, whitespace matters. It is used to break the input into tokens. See [the spec](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03) and [bash shell syntax documentation](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Syntax).

For the shell, the first *word* (a.k.a *token*) is the command, or the name of the program to run, and the remaining *words* are parameters to be passed to the program.

``` shell-session
$ printf '%d\n' {1..3}
1
2
3
```

Here, `printf` is the first token (the name of the program to be run), `%d\n` is the second token (quotes are removed - unless escaped - before the argument is passed to the program, and `{1..3}` is the third token, except the shell (Bash in my case) performs brace expansion before passing the results as individual tokens to the `printf` program. When the shell finds the newline, it then executes the command line.

## A Sad rm Incident

It is paramount that we prevent the shell from word splitting in certain (most) cases.

``` shell-session
$ ls -1
message.txt
secret message.txt
secret.txt
```

Now we want to remove `secret message.txt`:

``` shell-session
$ ls -1
message.txt
secret message.txt
secret.txt

$ rm -v secret message.txt
rm: cannot remove 'secret': No such file or directory
removed 'message.txt'

$ ls -1
'secret message.txt'
secret.txt
```

Oh shoot! Because we did not prevent the shell from breaking `secret message.txt` into individual tokens, what was passed to `rm` was not a single parameter, but two: `secret` and `message.txt`. `rm` was unable to remove a file named `secret` because no such file exists (we have `secret.txt`) but **was able to** remove `message.txt` because that was a file that really existed (but no longer). Unfortunately, we did not remove `secret message.txt` which is what we wanted, **but accidentally removed** `secret.txt` **which we didn't want to**. Yes, that is a sad story...

We must prevent the shell from performing word splitting in cases like this (and many others). What we should have done is this:

``` shell-session
$ rm -v 'secret message.txt'
removed 'secret message.txt'

$ ls -1
message.txt
secret.txt
```

Now we removed `secret message.txt` and not incidents took place.

# End Of Options ‘--’

The *end of options* `--` is used to indicate the end of options 🤣. It is documented under [Utility Syntax Guidelines](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html#tag_12_02).

Guideline 10 says:

> "The first -- argument that is not an option-argument should be accepted as a delimiter indicating the end of options. Any following arguments should be treated as operands, even if they begin with the '-' character."

It is useful when we want to tell a program something like “Look, from now on, these arguments are real files, directories, whatever. They **are not** options (command line flags) to the program.”

> [!NOTE]
> The `echo` command treats `--` as a normal string operand. See [the echo spec](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html).

Let's see some use cases.

## remove files starting with ‘-’

Sometimes, by accident or some other reason, we end up with files whose name start with one or more `-` (U+002D HYPHEN-MINUS character). If we try to remove (or rename, or some other operation) them, we run into problems.

``` shell-session
shell
$ tree -CF .
.
├── --oops.txt
└── -w00t.txt

0 directories, 2 files

shell
$ rm -v -w00t.txt
rm: invalid option -- 'w'
Try 'rm ./-w00t.txt' to remove the file '-w00t.txt'.
Try 'rm --help' for more information.

shell
$ rm -v --oops.txt
rm: unrecognized option '--oops.txt'
Try 'rm ./--oops.txt' to remove the file '--oops.txt'.
Try 'rm --help' for more information.
```

> "How embarrassing!"
>
> -- Master Yoda

But because we can use `--`, we have a way out!

``` shell-session
$ rm -vi -- --oops.txt -w00t.txt
rm: remove regular empty file '--oops.txt'? yes
removed '--oops.txt'
rm: remove regular empty file '-w00t.txt'? yes
removed '-w00t.txt'
```

Another option is to use `./<name of the file>` to force the shell to see that since we are using a path specifier (`./`), the thing must be a file:

``` shell-session
$ tree -CF .
.
├── --oops.txt
└── -w00t.txt

0 directories, 2 files

$ rm -vi ./--oops.txt ./-w00t.txt
rm: remove regular empty file './--oops.txt'? y
removed './--oops.txt'
rm: remove regular empty file './-w00t.txt'? y
removed './-w00t.txt'

$ tree -CF .
.

0 directories, 0 files
```

(TO BE CONTINUED)
