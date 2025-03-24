# Run Commands on Files Based on Git Status

## Open files touched by last commit in vim

```shell-session
$ git log -1 --name-only --pretty=format:
src/main.c
src/utils.c
src/utils.h
```

The output is each file on its own line.
That can be passed to vim:

```shell-session
$ vim $(git log -1 --name-only --pretty=format:)
13 files to edit
```

Just before vim actually opens the file, it displays a message of how many files it (vim) is going to edit.
After you close the editor, the message is still on the terminal.

And it works for more than one commit too:

```shell-session
$ vim $(git log -15 --name-only --pretty=format: HEAD~1)
81 files to edit
```

In any case, we used `--name-only` in conjunction with `--pretty=format:` with no format specifier after the colon (`:`) precisely because we want to output the filenames and nothing else.

The output may contain some empty lines, but those will simply be ignored by git, so we don’t need to clean them up manually, but we can anyway, just for kicks.
Let’s see this example from vim repository itself:

```shell-session
~/work/src/projects/others/vim [master|u=]
$ git log -5 --name-only --pretty='format:'
runtime/autoload/gzip.vim
runtime/ftplugin/perl.vim
runtime/ftplugin/ruby.vim

src/ex_docmd.c
src/list.c
src/macros.h
src/testdir/test_crash.vim
src/testdir/test_usercommands.vim
src/userfunc.c
src/version.c

src/testdir/test_vim9_disassemble.vim
src/version.c

src/testdir/test_recover.vim
src/version.c
```

Then we can use sed (or tr) to exclude the empty lines from the output:

```shell-session
$ git log -5 --name-only --pretty='format:' | sed '/^$/d'
runtime/autoload/gzip.vim
runtime/ftplugin/perl.vim
runtime/ftplugin/ruby.vim
Filelist
src/ex_docmd.c
src/list.c
src/macros.h
src/testdir/test_crash.vim
src/testdir/test_usercommands.vim
src/userfunc.c
src/version.c
src/testdir/test_vim9_disassemble.vim
src/version.c
src/testdir/test_recover.vim
src/version.c
```

And pass the result to vim, just like earlier:

```shell-session
$ vim $(git log -5 --name-only --pretty='format:' | sed '/^$/d')
17 files to edit
```

### Credits and references

Got the gist of the idea from [this blog post by Luis Osa](https://logc.github.io/blog/2015/07/15/open-files-from-last-commit-in-vim/).
I just added more details to the explanation as they made sense to me.

## Optimize images

Run `git status` and we see a `.png` image.
We want to optimize it before uploading somewhere or committing it to the repository.

```shell-session
$ git status --short
 M git/run-commands-on-selected-files.adoc
?? __assets/bash-help-null-command-2023-09-06T11-28-27-441Z.png
?? cmdline/null-command.adoc
```

It doesn’t show on the text above, but those “??” characters are printed with some colors, which means git introduced shell color escape codes on that output.
We had better use `--porcelain` to get a more “easy-to-parce format for scripts”:

See `git status --help` then search for `--porcelain`:

```{code} text
:filename: excerpt from git status --help
--porcelain[=<version>]
   Give the output in an easy-to-parse format for scripts. This is
   similar to the short output, but will remain stable across Git
   versions and regardless of user configuration. See below for details.

   The version parameter is used to specify the format version. This is
   optional and defaults to the original version v1 format.
```

```shell-session
$ git status --short --porcelain
 M git/run-commands-on-selected-files.adoc
?? __assets/bash-help-null-command-2023-09-06T11-28-27-441Z.png
?? cmdline/null-command.adoc
```

No colors now!
Time to parse it.

First, we filter only files ending with `.png` using `grep`:

```shell-session
$ git status --short --porcelain | grep '\.png$'
?? __assets/bash-help-null-command-2023-09-06T11-28-27-441Z.png
```

And then we use `cut` to get the second field delimited by a space:

```shell-session
$ git status --short --porcelain | grep '\.png$' | cut -d ' ' -f 2
__assets/bash-help-null-command-2023-09-06T11-28-27-441Z.png
```

We can finally optimize that image with a tool like `optipng`:

```shell-session
$ optipng -o7 $(git status --short --porcelain | grep '\.png$' | cut -d ' ' -f 2)
** Processing: __assets/bash-help-null-command-2023-09-06T11-28-27-441Z.png
451x185 pixels, 4x8 bits/pixel, RGB+alpha
Reducing image to 8 bits/pixel, 158 colors in palette
Input IDAT size = 12297 bytes
Input file size = 13018 bytes

Trying:
  zc = 9  zm = 9  zs = 0  f = 0		IDAT size = 3011
  zc = 9  zm = 8  zs = 0  f = 0		IDAT size = 3011
  zc = 9  zm = 9  zs = 1  f = 0		IDAT size = 2990
  zc = 9  zm = 8  zs = 1  f = 0		IDAT size = 2990

Selecting parameters:
  zc = 9  zm = 8  zs = 1  f = 0		IDAT size = 2990

Output IDAT size = 2990 bytes (9307 bytes decrease)
Output file size = 4197 bytes (8821 bytes = 67.76% decrease)
```

In the previous example, we had a single `.png` file to optimize, but a tool like `optipng` is able to handle multiple image file parameters at once:

**excerpt from optipng --help**

```text
$ optipng --help
Synopsis:
    optipng [options] files ...
```

So, even if we have multiple files, the above command, unmodified, just works as expected:

```shell-session
$ git status --short --porcelain | grep '\.png$' | cut -d ' ' -f 2
__assets/bash-null-built-in-command-2023-09-06T11-50-04-415Z.png
__assets/bash-test-built-in-command-2023-09-06T11-49-25-911Z.png

$ optipng -o7 $(git status --short --porcelain | grep '\.png$' | cut -d ' ' -f 2)
** Processing: __assets/bash-null-built-in-command-2023-09-06T11-50-04-415Z.png
441x178 pixels, 4x8 bits/pixel, RGB+alpha
Reducing image to 8 bits/pixel, 158 colors in palette
Input IDAT size = 12152 bytes
Input file size = 12873 bytes

Trying:
  zc = 9  zm = 9  zs = 0  f = 0		IDAT size = 2988
  zc = 9  zm = 8  zs = 0  f = 0		IDAT size = 2988
  zc = 9  zm = 9  zs = 1  f = 0		IDAT size = 2967
  zc = 9  zm = 8  zs = 1  f = 0		IDAT size = 2967

Selecting parameters:
  zc = 9  zm = 8  zs = 1  f = 0		IDAT size = 2967

Output IDAT size = 2967 bytes (9185 bytes decrease)
Output file size = 4174 bytes (8699 bytes = 67.58% decrease)

** Processing: __assets/bash-test-built-in-command-2023-09-06T11-49-25-911Z.png
806x142 pixels, 4x8 bits/pixel, RGB+alpha
Reducing image to 8 bits/pixel, 158 colors in palette
Input IDAT size = 16237 bytes
Input file size = 16958 bytes

Trying:
  zc = 9  zm = 9  zs = 0  f = 0		IDAT size = 4793
  zc = 8  zm = 9  zs = 0  f = 0		IDAT size = 4789
  zc = 8  zm = 8  zs = 0  f = 0		IDAT size = 4789
  zc = 9  zm = 9  zs = 1  f = 0		IDAT size = 4738
  zc = 8  zm = 9  zs = 1  f = 0		IDAT size = 4738
  zc = 8  zm = 8  zs = 1  f = 0		IDAT size = 4738

Selecting parameters:
  zc = 8  zm = 8  zs = 1  f = 0		IDAT size = 4738

Output IDAT size = 4738 bytes (11499 bytes decrease)
Output file size = 5945 bytes (11013 bytes = 64.94% decrease)
```

But if a given image optimization tool you are using takes only a single image at a time, we can do a shell loop.
Let’s see with a simple `printf` first:

```bash
for img in $(git status --short --porcelain | grep '\.png$' | cut -d ' ' -f 2)
do
  printf '%s\n' "$img"
done
__assets/bash-null-built-in-command-2023-09-06T11-50-04-415Z.png
__assets/bash-test-built-in-command-2023-09-06T11-49-25-911Z.png
```

If we are satisfied with the result, we can replace `printf` with `optipng` (or whatever other tool).
Let’s save it as `run_optipng.sh`:

**run_optipng.sh**

```bash
#!/usr/bin/env bash

imgs=(\
	$(git status --short --porcelain \
	| grep '\.png$' \
	| cut -d ' ' -f 2 \
	) \
)

for img in "${imgs[@]}"
do
	optipng -o7 "$img"
done
```
