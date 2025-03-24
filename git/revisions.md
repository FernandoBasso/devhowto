---
description: Let's understand git revision syntax through concepts and practical examples of real life situations.
---

# Git Revisions

What is `HEAD`, `upstream`, `@{u}`, `@~3`, `HEAD..@{upstream}`, etc.? Those are things well cover in this text.

NOTE: This text is a work in progress.

## Upstream and remote tracking branches

When we push a branch to a remote repository, we can use `--set-upstream` or or its short form `-u` to tell git to keep an eye out for differences between the local branch and its remote (upstream).

```shell-session
$ git push origin --set-upstream drafts
```

That is, after se “set upstream” for a branch, `git status`, `git checkout` (and possibly a few other commands) inform us of differences between them.

E.g.:

```shell-session
$ git status
On branch drafts
Your branch is behind 'gl/drafts' by 3 commits, and can be fast-forwarded.

$ git checkout typescript 
Switched to branch 'typescript'
Your branch is up to date with 'gl/typescript'.
```

So, it means there are tree commits in upstream that are not present on our local branch.
We are on the `drafts` branch.
How to find out what its upstream is?

```shell-session
$ git branch --verbose --verbose
```

It will show all local branches with their upstreams.
Of course, one could grep the output.
Another alternative is to use `git rev-parse`:

```shell-session
$ git rev-parse --abbrev-ref drafts@{upstream}
```

## References

- [Git revisions official docs](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/gitrevisions.html) (or `git --help gitrevisions` on the command line).
- [Git rev-parse man page](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/git-rev-parse.html) (or `git --help rev-parse` on the command line).
