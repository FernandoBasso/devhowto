---
description: A series of introductory exercises for the Lisp programming language. Includes solutions and explanations as well.
---

# Lisp Exercises and Solutions (Part 1)

## hello

:::{exercise}
:label: hello-1
Write a `hello` function that takes a string name like “Yoda” and returns “Hello, Yoda!”.
:::

:::{solution} hello-1
:class: dropdown
```lisp
(defun hello (msg)
  (format t "Hello, ~A!" msg))
```
:::

## remove

:::{exercise}
:label: remove-1
```lisp
(defvar lst '(a b c d))
(remove 'c lst)
(print lst)
;=> (a b c d)
```

Why does the print line output `(a b c d)` instead of `(a b d)`?

How to make lst contain only `(a b d)` after the `remove` line is run?
:::

:::{solution} remove-1
:class: dropdown

Because remove doesn't change the original list.
It just returns a new list with that element removed.

We can use `setf` and bind the returned list back to the original variable/name:

```lisp
(setf lst (remove 'c lst))
```

This is somewhat similar to Go's `append()`, which always returns the new collection, to which we more ofthen than not reassign to the same reference:

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

However, if we are striving to work in a functional and immutable data structures, then we should avoid reassigning.
:::
