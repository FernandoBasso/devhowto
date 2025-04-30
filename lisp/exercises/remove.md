## Remove 1

:::{exercise}
```lisp
(defvar lst '(a b c d))
(remove 'c lst)
(print lst)
;=> (a b c d)
```

Why does the print line output `(a b c d)` instead of `(a b d)`?

How to make lst contain only `(a b d)` after the `remove` line is run?
:::

### Solution 1

:::{solution} remove-1
:class: dropdown

Remove doesn't change the original list.
It just returns a new list with that element removed.

We can use `setf` and bind the returned list back to the original variable/name:

```lisp
(setf lst (remove 'c lst))
```

This is somewhat similar to Go's `append()` (and a few other languages as well), which always returns the new collection, to which we more often than not reassign to the same reference:

```go
package main

import "fmt"

func main() {
  nums := []int8{1, 2, 3}
  nums = append(nums, 4)
  fmt.Printf("%#v", nums)
  //=> []int8{1, 2, 3, 4}
}
```

However, if we are striving to work in a functional functional style and treat data structures as immutable, then we should avoid reassigning.
:::
