# Shell Redirection

## Intro

- `0` is the standard input, or STDIN;
- `1` is the starndard output, or STDOUT;
- `2` is the standard error, or STDERR;

In C, we can do things like this:

```c
int main(int argc, char *argv[]) {
  fprintf(stdout, "%s\n", "make: humans");

  fprintf(stderr, "%s\n", "Something is wrong in this planet.");

  return 0;
}
```

In the shell, we use the `<` and `&` operators in combination with the numbers.

## stdout

When we print or echo something, it goes to stdout by default:

```shell-session
$ echo hey
hey

$ printf '%d\n' {1..3}
1
2
3
```

Same goes for `cat`. By default, output goes to stdout:

```shel-session
$ cat <<EOF
> I'm $(whoami). My shell is $SHELL, version $BASH_VERSION.
> My main editor is $EDITOR, but I love Emacs too!
> EOF
I'm fernando. My shell is /usr/local/bin/bash, version 5.1.16(1)-release.
My main editor is vim, but I love Emacs too!
```

