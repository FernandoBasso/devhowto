---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Mini Max Sum HackerRank challenge.
---

# Mini Max Sum

- [Mini Max Sum on HackerRank](https://www.hackerrank.com/challenges/mini-max-sum)

## JavaScript

### Solution 1

```javascript
/**
 * Add `x` and `y` together.
 *
 * - T.C: O(1).
 * - S.C: O(1).
 *
 * @sig Number Number -> Number
 * @param {number} x
 * @param {number} y
 * @returns {number}
 */
function add(x, y) {
  return x + y;
}

/**
 * Sort callback for ascending order.
 *
 * - T.C: O(1).
 * - S.C: O(1).
 *
 * @sig Int Int -> Int
 * @param {number} a
 * @param {number} b
 * @return {number}
 */
function sortAsc(x, y) {
  return x - y;
}

/**
 * Finds the min and max sum of the five-integer array.
 *
 * ASSUME: The input always contains five positive integers and is
 * sorted in ascending order.
 * 
 * - T.C: O(n).
 * - S.C: O(n).
 *
 * @sig [Int] -> { min: Int, max: Int }
 * @param {number} xs
 * @returns {{ min: number, max: number }}
 */
function miniMaxSum(xs) {
  var sorted = [...xs].sort(sortAsc);

  return {
    min: sorted.slice(0, 4).reduce(add, 0),
    max: sorted.slice(1).reduce(add, 0),
  };
}
```

Time complexity of $O(n)$ because there is spread, sort, slice and reduce (which are all some sort of lopping internally), but neither is nested inside one another.
So even though it is more like $O(4n)$, it simplifies to $O(n)$.

Space complexity of $O(n)$ as `xs` is sorted and stored for further use.

### Solution 2

Reuses `add()` from earlier.

```javascript
/**
 * Finds the min and max sum of the five-integer array.
 *
 * ASSUME: The input always contains five positive integers and is
 * sorted in ascending order.
 *
 * - T.C: O(n²).
 * - S.C: O(n).
 *
 * @sig [Int] -> { min: Int, max: Int }
 * @param {number} xs
 * @returns {{ min: number, max: number }}
 */
function miniMaxSum(xs) {
  var smallerXs = xs.slice(0, 4);
  var largerXs = xs.slice(0, 4);
  var rest = xs.slice(4);

  var i, max, min, cur;

  for (i = 0; i < rest.length; ++i) {
    cur = rest[i];
    max = Math.max(...smallerXs);
    min = Math.min(...largerXs);

    if (cur < max)
      smallerXs[i] = cur;

    if (cur > min)
      largerXs[i] = cur;
  }

  return {
    min: smallerXs.reduce(add, 0),
    max: largerXs.reduce(add, 0),
  };
}
```

Make the first four elements of `xs` be both an array of smaller _and_ larger numbers.

Then, iterate over `rest` (actually a single `[xs]` as the input is always an array of five elements) and see if that single element is less than, or greater than the min and max element in `smallerXs` and `largerXs` respectively.

Finally, sum both arrays to produce the object `{ min, max }` as the final result.
