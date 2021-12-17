# unzip

## Extract files to given directory

To extract a `.zip` archive to a specified directory, use the `-d` command
line option:

```shell-session
$ unzip ~/Downloads/some-file.zip -d ~/Public/extracted-files
```

The destination directory must exist or the command will fail. You may want to
create it first:

```shell-session
$ mkdir -pv ~/Public/extracted-files
$ unzip ~/Downloads/some-file.zip -d !$
```

!!! tip

    We used `!$` shell expansion that makes reference to the last argument of
    the last command. It is the same as if we had written:

    ```shell-session
    $ mkdir -pv ~/Public/extracted-files
    $ unzip ~/Downloads/some-file.zip -d ~/Public/extracted-files
    ```

    See
    [Word Designators](https://www.gnu.org/software/bash/manual/bash.html#Word-Designators)
    in the Bash manual.
