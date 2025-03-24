---
description: Notes, tips and examples on using `git reset`.
---

# Git Reset

:::{admonition} Be **VERY** careful with git reset 😱
:class: danger

**Be very CAREFUL WITH GIT RESET**. 

It is very powerful and very useful.
It is also a DANGEROUS COMMAND if used improperly since it may cause you to lose code (or text/data/whatever).
Read carefully and don't ever rush when you are using `git reset` commands.

YOU HAVE BEEN WARNED!
:::

## Introduction to git reset

`HEAD` is the commit we are currently at.

A *hard reset* removes all not yet committed changes, which means it also removes staged changes (they are staged, not commit).

`git rest --hard HEAD~1` moves `HEAD` to point to the previous commit,
which has the effect of *deleting* the last commit.

`git rest --hard` without any *refs* implies `HEAD` in this context,
therefore, it is the same as `git rest --hard HEAD`.

Again, a **hard reset DESTROYS** any uncommitted changes, be they stated
or not.

- <https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefrefaref>
