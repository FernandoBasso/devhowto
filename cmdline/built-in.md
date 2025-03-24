# Shell Built-In Commands

## Intro

A built-in is a command provided by the shell itself, not a program stored somewhere in the path.

Bash's man page uses the spelling *bultin*. Zsh man page seems to use a mix of *built-in* and *builtin*. The [POSIX spec for the Shell Command Language](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_14) seems to strictly use *built-in*. Let’s attempt consistently use POSIX spelling (**built-in**) throughout this website.

## POSIX builtin reserved word

The POSIX spec does not define a built-in command called `builtin`, but makes it a “reserved word”. Note, especially, this line:

> "If the command name matches the name of a utility listed in the following table, **the results are unspecified**."

```{figure} ../__assets/posix-spec-builtins.png
:alt: Shell Posix spec on builtins

[Shell Posix spec on builtins](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01)
```

## Shells implementation of builtin

Shells have implemented that utility called `builtin` (*builtin* here is the actual name of the command) for their (the shell's) specific purposes. For example, in Bash:

``` shell-session
$ help builtin
builtin: builtin [shell-builtin [arg ...]]
    Execute shell builtins.

    Execute SHELL-BUILTIN with arguments ARGs without performing command
    lookup.  This is useful when you wish to re-implement a shell builtin
    as a shell function, but need to execute the builtin within the function.

    Exit Status:
    Returns the exit status of SHELL-BUILTIN, or false if SHELL-BUILTIN is
    not a shell builtin.
```

One such use case is with `cd`. We may find it useful to have a function `cd` than when executed first does some other thing, like checking for the existence and reading an `.env` file in the `cd`ed directory, and **then** actually invoking the builtin `cd` to that directory. Something like:

``` bash
##
# Read .env.txt (if it exists) when changing to a directory.
#
cd () {
  builtin cd "$@"

  if [[ -f ./.env.txt ]]
  then
    cat .env.txt
  fi
}
```

We could use this approach to read `.nvmrc` or any other project related setup file for whatever language, library or framework it makes sense.
