## Assign to array index

:::{exercise}
```shell
$ arr=(lisp scheme haskell)
$ arr[1]=javascript
$ arr[2]=(ruby)
```

What happens on the last two lines where we assign to the indexes 1 and 2 and what is the content of `arr` afterwards?
:::

:::{solution} assign-to-array-index
:class: dropdown

When we assign "javascript" to `arr[1]` it works fine because we are assigning a new literal string to that array index, and it is valid to do that.
The index 1 now has the new string "javascript" instead of the original string "scheme".

On the other hand, `arr[2]=(javascript)` is an error

> “bash: `arr[2]`: cannot assign list to array member”

Using the syntax `(value)` on the right-hand side of an assignment tells bash it is an array, and as bash does not support multidimensional arrays, it is not legal to try to add an array to a given index.
In this case, the original string "haskell" is still present in `arr[2]`.

The contents of the array is:

```shell
$ printf '%s\n' "${arr[@]}"
lisp
javascript
haskell
```

:::
