---
title: $ tar Command Line Examples
description: Some practical examples on using the tar command to create and extract archives
---

# tar command line examples

## Unpack an archive to existing directory

Sometimes we want to unpack an archive directly into another directory instead of in the current directory. For that we can use `--directory` or `-C`:

```text title="excerpt from man tar"
-C, --directory=DIR
      Change to DIR before performing any operations.  This option  is
      order-sensitive, i.e. it affects all options that follow.
```

We do it like this, but **note that the target directory must already exist**:

```shell-session title="unpack to directory"
$ tar \
    -xf exercism-linux-64bit.tgz \
    --directory ~/bin/exercism-linux/

$ ls -a1 !$
ls -A1 ~/bin/exercism-linux/
exercism*
LICENSE
README.md
shell/
```

## Unpack an archive to a directory that doesn't exist yet

In the case above, `~/bin/exercism-linux/` directory already existed and our command line worked as expected. It seems `tar` (GNU tar 1.34, 2022), doesn't have a flag to create the target directory in case it doesn't exist yet. In that case, the solution is to create it before extracting the archive**:

```shell-session title="mkdir && unpack to directory"
$ mkdir -pv ~/bin/exercism-linux && \
    -xf exercism-linux-64bit.tgz \
    --directory ~/bin/exercism-linux/
```
