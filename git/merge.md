---
description: Some useful and practical (and some advanced) examples on `git merge'.
---

# Git Merge

## Fast-forward merge branch without checkout

The same way we can do `git log <branch>`, we can do a fast-forward merge of a branch onto some other branch without having leave whatever branch we are currently in.

Let's see a practical example:

```shell-session
$ echo '# My Project' > README.txt
$ git add -- ./README.txt 
$ git commit --message 'Add README'

$ git log --oneline 
a8dafb2 (HEAD -> main) Add README

$ git branch devel

$ git branch 
  devel
* main

$ git diff HEAD..devel
(no output)
```

Note that `main` and `devel` have the same state.
Then we create a new commit on `main`:

```shell-session
$ echo 'Hello, world!' > hello.txt

$ git add -- ./hello.txt 

$ git commit --message 'Add hello example'
[main 59d0052] Add hello example
 1 file changed, 1 insertion(+)
 create mode 100644 hello.txt

$ git log --oneline devel..HEAD
59d0052 (HEAD -> main) Add hello example
```

OK, now `main` has one commit that `devel` does not have.
To update `devel` with the latest stuff from main, we could checkout to it and do a merge, but we can also do it it without ever leaving the `main` branch.

```shell-session
$ git fetch . main:devel
From .
   a8dafb2..59d0052  main       -> devel
```

The above does a *fast-forward* merge of `main` into `devel`.
The two branches now again have the same state (same commits, same hashes, etc.).

```shell-session
$ git log --oneline main
59d0052 (HEAD -> main, devel) Add hello example
a8dafb2 Add README

$ git log --oneline devel
59d0052 (HEAD -> main, devel) Add hello example
a8dafb2 Add README

```

Notice we used `.` to “fetch” from the local repo, but we could also use the name of the remote tracking branch too if needed:

```shell-session
$ git fetch <remote> <source-branch>:<destination-branch>
```

Perhaps something like:

```shell-session
$ git fetch origin my-feature-branch:main
```

This would do a fast-forward merge of `my-feature-branch` into `main`.
