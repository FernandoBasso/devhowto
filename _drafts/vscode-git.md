# VSCode and Git

## gpg cannot open /dev/tty

This happened when trying to commit from VSCode's “Git: Commit Staged” command palette, which opens a normal VSCode buffer for us to type the commit message in.

```{code} shell
> git -c user.useConfigOnly=true commit --quiet
error: gpg failed to sign the data:
[GNUPG:] KEY_CONSIDERED (redacted) 2
[GNUPG:] BEGIN_SIGNING H8
[GNUPG:] USERID_HINT (redacted) User Name <user-name@example.org>
[GNUPG:] NEED_PASSPHRASE (readacted) (redacted) 1 0
[GNUPG:] INQUIRE_MAXLEN 100
gpg: cannot open '/dev/tty': Device not configured

fatal: failed to write commit object
```

https://github.com/microsoft/vscode/issues/43809
