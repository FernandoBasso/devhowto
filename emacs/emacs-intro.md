# Intro to Emacs

## Read from STDIN

```shell-session
$ emacs --insert <(echo 'hello world')
$ emacs --insert <(cat ~/.bash_profile)
$ emacs --insert <(bin/rails routes --controller=articles)
```

**script by twb on #emacs IRC channel**

```shell
#!/bin/bash -e

#
# Example usage:
#   curl http://example.net/mbox | with-temp-file mutt -f
#   curl http://example.net/     | with-temp-file browser
#   curl http://example.net/     | with-temp-file emacs
#

test $# -gt 0 ||
exit 1

f="`mktemp -t with-temp-file.XXXXXX`"

trap 'rm -f "$f"' EXIT

cat >"$f"

# less(1)-style tty grabber.
exec </dev/tty || true

# subshell to avoid "w-t-f unset f" not reaping
("$@" "$f")
```

twb user says:

> I was doing it once for the purposes of making alias ed="emacs -batch -f ed-mode"

## Other links and resources about Emacs

- [The Amazing Sacha Chua's blog mostly about Emacs](https://sachachua.com/blog/)
- [Martin Fowler on Mastodon post on Emacs](https://toot.thoughtworks.com/@mfowler/111817969324041521)
- [Martin Fowler on Emacs completion](https://martinfowler.com/articles/2024-emacs-completion.html)

