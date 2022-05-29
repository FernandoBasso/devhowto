# Contributing


- [Contributing](#contributing)
  - [Commit Messages](#commit-messages)
  - [Commit Types](#commit-types)
    - [commit-msg git hook](#commit-msg-git-hook)
    - [List of Previously Used Types](#list-of-previously-used-types)
    - [Project-Specific Commit Types and Scopes](#project-specific-commit-types-and-scopes)

## Commit Messages

We try to use all possible commit message
[good practices](https://chris.beams.io/posts/git-commit/).

Also, do a few `git log` commands to get a feel for this project's take on
commit messages.

We also use “types”. See next section.

## Commit Types

Anyone is welcome to add, fix, correct and enlighten anything in this
project. Since this is a wiki of sorts project, which is published at Read The
Docs using Sphinx, many different topics are committed here. Therefore, let's
try to write commit title (subjects) with a commit *type* prefix.

Examples of types:

- docs: related to readme, contributing (not docs about the tutorial on the
  topics themselves
- chore: update configs and dependencies
- cmdline: for anything command line, coreutils, unix tools

For programming languages, let's use the standard file extension:

- c: C programming Language.
- js: JavaScript
- hs: Haskell
- rb: Ruby
- ts: TypeScript
- scm: Scheme
- rkt: Racket

For notes on books, tutorials, courses, etc., create a type using some
sort of abbreviation or acronym. See
[Project-Specific Commit Types](#project-specific-commit-types)
below.

For example, for the [Mostly Adequate Guide to Functional
Programming](https://github.com/MostlyAdequate/mostly-adequate-guide),
the type is “magfp”. So, the commit message would look like:

```
magfp: Add solutions for chapter 5 on composition
```

For the [Haskell From First Principles](https://haskellbook.com/) book,
we chose the type “hffp”:

```
hffp: Add notes on foldr vs foldr
```

It is important that once we use a type for a book or tutorial, we stick
to that type for all commits related to that book or tutorial.

### commit-msg git hook

We have a pre-commit hook that validates the commit type. Take a look at
`.githooks/commit-msg`.

Update your local git settings to use the git hooks location for this project:

```shell-session
$ cd /path/to/this/project
$ git config --local core.hooksPath '.githooks'
```

We manually update the script's array of valid commit types when a new one
needs to be introduced.

### List of Previously Used Types

To find a list of previously used types, run something like this:

```
$ git log --format='%s' \
    | grep '^[a-z]\+:' \
    | sed 's/:.\+//' \
    | sort
    | uniq
```

Alternatively, just run the bash script (which basically just does the same as
the command line above):

```
$ ./list-commit-message-types.bash
```

### Project-Specific Commit Types and Scopes

By “project-specific types and scopes” we mean commit types for books,
tutorials, etc. (mentioned above), and not generic commit types like “rb” or
“c" or generic scope like “fix” or “feature”.

- hffp: [Haskell From First Principles](https://haskellbook.com/)
- magfp: [Mostly Adequate Guide to Functional Programming](https://github.com/MostlyAdequate/mostly-adequate-guide)
- compfpjs: [Composable Functional JavaScript](https://egghead.io/courses/professor-frisby-introduces-composable-functional-javascript)
- ts(tnadv): [Ted Neward Busy TypeScript Developer’s Guide to Advanced TypeScript](https://www.youtube.com/watch?v=wD5WGkOEJRs)



## Titles and Descriptions

The heading 1 defines the page title in the browser, but we can override it with the front matter in each file:

```
---
title: The REPL | PureScript
description: Practical examples on how to use the PureScript repl to...
---

# The PureScript REPL

REPL stands for Read, Eval, Print Loop, which...
```

The above will show the title REPL at the top of the rendered page in the browser, but the title bar will show "REPL | PureScript", which is what should be indexed by search engines and used for bookmarks, for example.

**Because** this website contains stuff for multiple languages and tools, **always** append the main topic after a "|" character (as in the example above) so we know if we are seeing a REPL page for Node, PureScript, Haskell, Ruby, etc. Both search engines and mostly important, users, will appreciate it!
