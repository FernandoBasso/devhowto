---
description: Some notes and tips regarding working with branches and practical examples and commands.
---

# Git Branching

## git checkout -b

```{admonition} "Remote Name"
:class: tip

In these examples, the remote is named `gl` because I use Gitlab a lot and name my Gitlab remote repos as `gl` instead of the default `origin`.
```

We all use `git checkout -b new-branch` to create a new branch from time to time.
Generally, we first switch to `main` or `develop`, update it and then from there create the new branch:

```shell-session
$ git checkout main
$ git fetch  main
$ git reset --hard gl/main
$ git checkout -b new-branch
```

If you now do:

```shell-session
$ git branch -vv | grep new-branch
* my-branch      123aaa9 The commit message here
```

That includes no tracking branch information.

But we can also use `-b` to create a branch from some other branch (instead of from the one we currently are):

```shell-session
$ git fetch gl main
$ git checkout -b other-branch gl/main

$ git branch -vv | grep other-branch
branch 'other-branch' set up to track 'gl/main'.
Switched to a new branch 'other-branch'

$ git branch -vv | grep other-branch
* other-branch      bfc8d31 [gl/main] The commit message here
```

Specially note the bit “branch 'other-branch' set up to track 'gl/main'”.
This is significant.
It means if you now push without specifying which branch to push to, it will send changes to `main` (which could be catastrophic).

It can be fixed by setting it a new upstream to a remote branch with the same name as the local branch:

```shell-session
$ git push origin --set-upstream other-branch:other-branch
 ... some output omitted for brevity ...
 * [new branch]      other-branch -> other-branch
branch 'other-branch' set up to track 'gl/other-branch'.
```

As it can be seen, it sets the local `other-branch` to track the remote `other-branch`.

It is possible to use `--no-track` to create a branch from another branch, which is probably a safer approach than mistakenly create a branch that tracks `main` and then *fix* it in a subsequent command, as we did above.
We could do this instead:

```shell-session
$ git checkout -b other-branch --no-track gl/main
Switched to a new branch 'other-branch'

$ git branch -vv | grep other-branch
* other-branch     bfc8d31 The commit message here
```

Note it just says “Switched to a new branch 'other-branch'” without any mentions to making it track some other branch.
