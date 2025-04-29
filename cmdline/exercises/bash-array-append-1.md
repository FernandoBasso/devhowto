## Append to array index

:::{exercise}
```shell
arr=(lisp scheme haskell)
arr[1]+=foo
```

Explain what happens in the last line and what the contents of the array are after that line is executed.
:::

:::{solution} append-to-array-index
:class: dropdown
`arr[1]+=foo` appends the string "foo" to the value in `arr[1]`, so it becomes "schemefoo".
The contents of `arr` at this point becomes:

```shell
$ printf '%s\n' "${arr[@]}"
lisp
schemefoo
haskell
```
:::
