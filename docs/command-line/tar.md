# tar command line examples

## Unpack an archive to another directory

Sometimes we want to unpack an archive directly into another directory instead of in the current directory. For that we can use `--directory` or `-C`:

```text title="excerpt from man tar"
-C, --directory=DIR
      Change to DIR before performing any operations.  This option  is
      order-sensitive, i.e. it affects all options that follow.
```

Example:

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
