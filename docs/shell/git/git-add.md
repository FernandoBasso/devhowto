# git add

## --patch and --intent-to-add

Sometimes it is very useful to carefully add each patch chunk by chunk
instead of going nuclear with `git add .` (which simply adds
everything). Git offers switches for a more granular control of what is
being added to the index, besides giving us the chance to do a last minute review of the
patches:

```shell-session
$ git add --patch <pathspec>
```

It works fine, except that it does not show the patch for new files, and they
are simply not added to the stage at all (after all, there is no previous
version to compare them to and generate a patch).

However, `git add` is endowed with an `--intent-to-add` flag that can be
used for this purpose of allowing to see the patch even for new files.
The workflow is simple:

```shell-session
$ git add --intent-to-add <pathspec>
$ git add --patch <pathspec>
```

Now we see a patch even for the new files and we can selectively add the to
the index with `--patch`.

Beware that if you do `git add --intent-to-add <pathspec>` followed by a
`git status`, git will still show the file in the not staged for commit state
and that is expected.

And by the way, `--patch` is the long version for `-p`, and
`--intent-to-add` is the long version for `-N`.

### References

- `git add --help`, or
  [man git add online](https://man.archlinux.org/man/git-add.1)).
