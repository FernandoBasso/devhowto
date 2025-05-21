---
description: Grains Exercism Lisp exercise notes and solutions.
---

# Grains

- [Grains Lisp Exercise](https://exercism.org/tracks/common-lisp/exercises/grains)

## v1 non-optmized recursion loop

This solution uses a more traditional approach of looping over each square and accumulating the previous values.

The solution for `total` is exactly the same as the one for `square`, except it just adds one more accumulator for the total sum of the grains on the entire board.

### Time complexity

$O(n)$, as we iterate over each square in the board once.

### Space complexity

$O(1)$, as we simply use one or two integer accumulators to hold the values we need to compute.

```{code} lisp
(defparameter *board-size* 64)

;;;;
;; square :: Integer -> Integer
;;
;; Returns the amount of grains on a given square.
;;
(defun square (n)
  (labels
    ((run (i acc)
       (if (= i n)
         acc
         (run
           (+ i 1)
           (* acc 2)))))
    (run 1 1)))

;;;;
;; total :: Integer
;;
;; Returns the total number of grains on a board of *board-size* squares.
;;
(defun total ()
  (labels
    ((run (i acc sum)
       (if (= i *board-size*)
         sum
         (run
           (+ i 1)
           (* acc 2)
           (+ sum (* acc 2))))))
    (run 1 1 1)))
```
