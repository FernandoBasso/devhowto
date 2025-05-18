---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Sherlock and Array HackerRank challenge.
---

# Sherlock and Array

- [Sherlock and Array on HackerRank](https://www.hackerrank.com/challenges/sherlock-and-array)

## JavaScript

### Solution 1 with nested loops

This version is correct but does not satisfy the time constraints in HackerRank.
Execution times out.

```javascript

/**
 * Gets the elements to the left of `idx`.
 *
 * @param {number} idx
 * @param {Array<number>} xs
 * @returns {Array<number>}
 */
function left(idx, xs) {
  return xs.slice(0, idx);
}

/**
 * Gets the elements to the right of `idx`.
 *
 * @param {number} idx
 * @param {Array<number>} xs
 * @returns {Array<number>}
 */
function right(idx, xs) {
  return xs.slice(idx + 1);
}

/**
 * Sums all the numbers in `xs`.
 *
 * @param {Array<number>} xs
 * @returns {number}
 */
function sum(xs) {
  return xs.reduce((total, x) => total + x, 0);
}

/**
 * Checks if there is an element whose sum of all elements on its
 * left is equal to the sum of all elements to its right.
 *
 * @param {Array<number>} xs
 * @returns {'YES' | 'NO'}
 */
function balancedSum(xs) {
  var p,
      lSum = 0,
      rSum = 0;

  for (p = 0; p < xs.length; ++p) {
    lSum = sum(left(p, xs));
    rSum = sum(right(p, xs));

    if (lSum === rSum) return 'YES';
  }

  return 'NO';
}

export { balancedSum };
```

This solution has horrible time performance because `left()` and `right()` (which internally perform array slicing, which is a complex operation) are used over and over again inside the loop.

On top of that, the sliced elements are applied `sum()`, which again loops some more each time.

In the end, there are three nested loops _twice_.
One for the left slice, and another for the right slice.

### Solution 2 with accumulators

```javascript
/**
 * Sums all the numbers in `xs`.
 *
 * @param {Array<number>} xs
 * @returns {number}
 */
function sum(xs) {
  return xs.reduce((total, x) => total + x, 0);
}

/**
 * Checks if there is an element whose sum of all elements on its
 * left is equal to the sum of all elements to its right.
 * 
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @param {Array<number>} xs
 * @returns {'YES' | 'NO'}
 */
function balancedSum(xs) {
  var p,
      lSum = 0,
      rSum = sum(xs.slice(1));

  if (rSum === 0) return 'YES';

  for (p = 1; p < xs.length; ++p) {
    lSum += xs[p - 1];
    rSum -= xs[p];

    if (lSum === rSum) return 'YES';
  }

  return 'NO';
}
```

Note this approach simply adds or subtracts values from `lSum` and `rSum` to keep a running total of the sums on the left and right of the *pointer*.
Addition and subtraction in this way has $O(1)$ time complexity, which is the best possible (contrary to the nested loops of the approach on solution 1).

It is still necessary to sum everything once at the very beginning, and there is another loop after to find the balancing sum (if any).
But two loops one after another is still time complexity $O(n)$ because they are **not** nested loops.
