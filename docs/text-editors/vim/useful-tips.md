# Vim Useful Tips

## Copy relative file path to the clipboard

Create a function like this:

```vim title="vim function to copy relative path of file"
function! YankFilePath()
  let @+ = expand('%')
  echomsg 'Copied “' . expand('%') . '” to the clipboard.'
endfunction
```

And then map it to some keybinding. I am OK with this:

```vim title="vim keybinding for the function"
nnoremap <Leader>yp :call YankFilePath()<CR>
```

## Making gf work: includeexpr and suffixes add

### includexpr

You have this path (“`^`” representes the cursor position):

```text
foo/bar/intro.md
          ^
```
But the catch is that the file is actually:

```text
docs/foo/bar/intro.md
```

When we do `gf`, it wil lnot work because the path in the file is not
the actuall path on the disk. We must make vim prepend that `docs/`
prefix. For that, we can use `includeexpr`.

```vim title="includeexpr with substitute() example"
set includeexpr=substitute(v:fname,'^','docs/','')
```

If we `echo &includeexpr` we see that it stored the entire substitute
expression we provided. From now on, when we do `gf`, that `docs/`
prefix will be applied we'll be able to visit the file.

Of course, that will happen for all `gf`, even for things that don't
have `docs/` in front of them. We could create more complex functions to
handle situatiosn conditionally.

#### References

See:

- `:help includeexpr`
- `:help substitute()`

### suffixesadd

Another situation is when we want to `gf` to a path which is included
without the file extension. Suppose we have this:

```text
import { parserCmdLine } from "src/utils/parser";
                                          ^
```

If we do `gf`, vim might not know that we want `parser.js`, `parser.ts`
or some other extension altogheter.

But if it is not working by default (depends on extensions and
setup), we can simply do this:

```vim title="suffixesadd .ts and .js example"
let suffixesadd+=.ts,.js
```

Note the `+` so we *append* rather than override what is already in
place, and also note that we provide the extensions with the dot `.`
and the comma separating them (in case there is more than one extension
being set). It is `.ts,.js`, not `ts,js`.

We can see what it is set up with:

```vim title="inspecting suffixesadd"
:echo &suffixesadd
```

#### References

See:

- `:help suffixesadd`
