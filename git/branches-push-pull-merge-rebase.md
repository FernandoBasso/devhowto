---
description: Some practical examples on doing a git push, pull, rebase and merge.
---

# Git Branches: push, pull, merge and rebase

## push

Push local branch to a remote and make make remote use different branch name.

```bash
$ git push origin dev-feature:dev-foo-bar
```

## remove remote branch

New approach since git >= 1.7:

```bash
$ git push origin --delete <branch-name>
```

Then this on other machines to propagate the changes:

```
$ git fetch --all --prune
```

Or, for those used to the approach `git push local_branch:remote_branch`, then this might also be easy to remember, remove the remote branch with (note space before the `:`):

```bash
$ git push origin :remote_branch_to_delete
```

References:

- [stack overflow post](https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-both-locally-and-remotely)
- `git push --help`
