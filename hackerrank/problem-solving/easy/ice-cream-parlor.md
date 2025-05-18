---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Ice Cream Parlor HackerRank challenge.
---

# Ice Cream Parlor

- [Ice Cream Parlor on HackerRank](https://www.hackerrank.com/challenges/icecream-parlor)

This challenge is the same as the [Two Sum on Codewars](https://www.codewars.com/kata/52c31f8e6605bcc646000082) and [Two Sum on LeetCode](https://leetcode.com/problems/two-sum/).

## JavaScript

### Solution 1

```javascript
/**
 * Finds the indices of two distinct indices in `flavors` that when
 * added together are equal to `money`.
 *
 * NOTE: The challenge requires the output indices to start at 1 😅.
 *
 * ASSUME:
 * - There is always a single, correct solution.
 * - The input array is NOT sorted.
 * - The input array could contain duplicate values.
 *
 * @sig Int -> [Int] -> [Int, Int]
 * @param {number} money
 * @param {Array<number>} flavorPrices
 * @returns {[number, number]}
 */
function iceCreamParlor(money, flavorPrices) {
  var len = flavorPrices.length,
      i,
      j;

  for (i = 0; i < len; ++i) {
    for (j = i + 1; j < len; ++j) {
      if (flavorPrices[i] + flavorPrices[j] === money) {
        return [i + 1, j + 1];
      }
    }
  }
}
```

### Solution 2

```javascript
/**
 * Finds the indices of two distinct indices in `flavors` that when
 * added together are equal to `money`.
 *
 * - T.C: O(n).
 * - S.C: O(n).
 *
 * NOTE: The challenge requires the output indices to start at 1 😅.
 *
 * ASSUME:
 *
 * - There is always a single, correct solution.
 * - The input array is NOT sorted.
 * - The input array could contain duplicate values.
 *
 * @sig Int -> [Int] -> [Int, Int]
 * @param {number} money
 * @param {Array<number>} prices
 * @returns {[number, number]}
 */
function iceCreamParlor(money, prices) {
  var seen = {},
      price,
      complement,
      idx = 0;

  for (price of prices) {
    complement = money - price;

    if (seen[complement] !== undefined)
      return [seen[complement], idx + 1];

    seen[price] = idx + 1;
    ++idx;
  }
}
```

This solution uses the `seen` object as a lookup table of sorts to figure out if the current price with the complement stored in `seen` totals money available.
