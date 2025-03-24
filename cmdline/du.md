---
description: Tips, notes, explanations and examples on the usage of the du command line utility
---

# du

:::{note}
Unless otherwise noted, assume the examples work on GNU coreutils `du`.
:::

## Sort

The sort examples check the disk usages of a `.git/` directory.

## Sort by disk usage in descending order

```bash
$ du ./.git | sort -nr
```

Results in something like this:

```text
11348   ./.git
10756   ./.git/objects
10600   ./.git/objects/pack
96      ./.git/logs
92      ./.git/refs
88      ./.git/logs/refs
72      ./.git/refs/remotes
72      ./.git/logs/refs/remotes
68      ./.git/refs/remotes/gl
68      ./.git/logs/refs/remotes/gl
68      ./.git/hooks
12      ./.git/refs/heads
12      ./.git/objects/88
12      ./.git/logs/refs/heads
8       ./.git/objects/fd
8       ./.git/objects/f2
8       ./.git/objects/22
8       ./.git/objects/0d
8       ./.git/info
4       ./.git/refs/tags
4       ./.git/objects/info
4       ./.git/branches
```

To `du -h` (`--human-readable`), `sort` needs the `-h` flag introduced in coreutils 7.5.

```bash
$ du -h ./.git | sort -rh
```

Results in something like:

```text
12M	./.git
11M	./.git/objects/pack
11M	./.git/objects
96K	./.git/logs
92K	./.git/refs
88K	./.git/logs/refs
72K	./.git/refs/remotes
72K	./.git/logs/refs/remotes
68K	./.git/refs/remotes/gl
68K	./.git/logs/refs/remotes/gl
68K	./.git/hooks
12K	./.git/refs/heads
12K	./.git/objects/88
12K	./.git/logs/refs/heads
8.0K	./.git/objects/fd
8.0K	./.git/objects/f2
8.0K	./.git/objects/f1
8.0K	./.git/objects/f0
8.0K	./.git/info
4.0K	./.git/refs/tags
4.0K	./.git/objects/info
4.0K	./.git/branches
```
