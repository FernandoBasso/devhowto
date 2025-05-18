---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Missing Numbers HackerRank challenge.
---

# Missing Numbers

- [Missing Numbers on HackerRank](https://www.hackerrank.com/challenges/missing-numbers)

## JavaScript

### Solution 1

```javascript
/**
 * Finds numbers that are present in `ys` but missing in `xs`.
 *
 * - T.C: O(n).
 * - S.C: O(n).
 *
 * @param {number[]} xs
 * @param {number[]} ys
 * @returns {number[]} The array of the missing numbers (the
 *   difference).
 */
function missingNums(arr, brr) {
  var freqXs = {},
      freqYs = {},
      i,
      n;

  for (i = 0; n = xs[i], i < xs.length; ++i)
    freqXs[n] = freqXs[n] + 1 || 1;

  for (i = 0; n = ys[i], i < ys.length; ++i)
    freqYs[n] = freqYs[n] + 1 || 1;

  return Object.keys(freqYs).reduce((missing, key) => {
    if (freqYs[key] === freqXs[key])
      return missing;

    missing.push(Number(key));

    return missing;
  }, []);
}
```

Solution using frequency counters.
There are three loops involved but neither is nested, which makes for time complexity $O(n)$.

### Solution 2 with helper

```javascript
/**
 * Returns a hash map of the frequencies of the values in `xs`.
 *
 * - T.C: O(n).
 * - S.C: O(n).
 *
 * @param {number[]} xs
 * @returns {{ [key: string]: number }}
 */
function countFreq(xs) {
  return xs.reduce(function reducer(freqs, x) {
    freqs[x] = freqs[x] + 1 || 1;
    return freqs;
  }, {});
}

/**
 * Finds numbers that are present in `ys` but missing in `xs`.
 *
 * - T.C: O(n).
 * - S.C: O(n).
 *
 * @param {number[]} xs
 * @param {number[]} ys
 * @returns {number[]} The array of the missing numbers (the
 *   difference).
 */
function missingNums(xs, ys) {
  var freqXs = countFreq(xs);
  var freqYs = countFreq(ys);

  return Object.keys(freqYs).reduce((missing, key) => {
    if (freqYs[key] === freqXs[key]) return missing;

    return [...missing, Number(key)];
  }, []);
}
```

Essentially the same as solution 1, but extracting part of the logic into a helper function.

### Solution 3 with sets, spread, sort and splice

```javascript
/**
 * Compares two numbers for ascending sorting.
 *
 * - T.C: O(1).
 * - S.C: O(1).
 *
 * @param {number} a
 * @param {number} b
 * @returns {number}
 */
function sortAsc(a, b) {
  return a - b;
}

/**
 * Finds numbers that are present in `ys` but missing in `xs`.
 *
 * - T.C: O(n²).
 * - S.C: O(1).
 *
 * @param {number[]} xs
 * @param {number[]} ys
 * @returns {number[]} The array of the missing numbers (the
 *   difference).
 */
function missingNums(xs, ys) {
  for (const n of xs) {
    if (ys.includes(n)) {
      const idx = ys.indexOf(n);
      ys.splice(idx, 1);
    }
  }

  //
  // • Use sets to remove duplicates.
  // • Convert back to array with spread syntax.
  //
  return [...new Set(ys)].sort(sortAsc);
}
```

For each number in `xs`, try to find it in `ys` and remove it from `ys` if present.
In the end, only numbers in `ys` that are missing in `xs` will remain in `ys`.

Also use some ECMAScript set and spread stuff to return the final result.
