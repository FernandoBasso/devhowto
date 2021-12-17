#!/usr/bin/env bash

#
# List commit messages “tags”. Git git tags from the `git tag' command.
# Instead, a tagging of sorts we use to identify what a commit is
# roughly about. See CONTRIBUTING.md.
#
# Looks like the shebang line is causing the newer bash installed from brew be
# used instead of the old 3.2 one shipped with MacOS.
#

git log --format='%s' \
  | grep '^[a-z]\+:' \
  | sed 's/:.\+//' \
  | sort \
  | uniq

