## Hello 1

:::{exercise}
Write a `hello` function that takes a string name like “Yoda” and returns “Hello, Yoda!”.
:::

:::{solution} hello-1
:class: dropdown
```lisp
(defun hello (msg)
  (format t "Hello, ~A!" msg))
```
:::

