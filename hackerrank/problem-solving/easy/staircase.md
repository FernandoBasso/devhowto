---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Staircase HackerRank challenge.
---

# Staircase

- [Staircase on HackerRank](https://www.hackerrank.com/challenges/staircase)

As an example, when the input is 6, should print this:

```text
     #
    ##
   ###
  ####
 #####
######
```

## JavaScript

### Solution 1

```javascript
/**
 * Prints an ascii-art of a stair case of `n` steps.
 *
 * - T.C: O(n²).
 * - S.C: O(n).
 *
 * @param {number} n The number of steps to print.
 * @sig Number -> Void
 */
function staircase(n) {
  for (var i = 1; i <= n; ++i) {
    var row = new Array(n).fill(' ').fill('#', n - i).join('');
    console.log(row);
  }
}
```

Time complexity $O(n²)$ because we use `fill()` and `join()` inside each iteration of the loop.
Those array methods are loops themselves.

### Solution 2

```javascript
/**
 * Prints an ascii-art of a stair case of `n` steps.
 *
 * - T.C: O(n²)
 * - S.C: O(n).
 * 
 * @param {number} n The number of steps to print.
 * @sig Number -> Void
 */
 function staircase(n) {
  let r = 1;

  while (r <= n) {
    let blanks = [...Array(n - r)].map(i => ' ');
    let hashes = [...Array(n - (n - r++))].map(i => '#');
    console.log([...blanks, ...hashes].join(''));
  }
}
```

Spreads are loops too, as are maps and joins.
Time complexity $O(n²)$ because in the end there are nested loops with this approach too.
