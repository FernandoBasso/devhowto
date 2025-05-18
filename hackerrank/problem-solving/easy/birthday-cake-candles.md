---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Birthday Cake Candles HackerRank challenge.
---

# Birthday Cake Candles

- [Birthday Cake Candles on HackerRank](https://www.hackerrank.com/challenges/birthday-cake-candles)


This problem involves mainly two steps:

- Find the largest number.
- Count how many times that largest number appears.

The input is never empty.

The input array contains at least 1 element.

Because the input contain repeated numbers, we either have to loop twice (one time to find the max, another time to count how many time it appears), or find some other approach (if one exists).
And there is at least one: in a single loop, both keep the maximum up to date and a frequency counter of each char encountered.

## JavaScript

### Solution 1 with two non-nested loops

```javascript
/**
 * Counts how many times the largest integer shows up in the input.
 *
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @sig [Int] -> Int
 */
function birthdayCakeCandles(candles) {
  var max = -Infinity;
  var cnt = 0;

  for (var cur of candles)
    max = Math.max(cur, max);

  for (var cur of candles)
    if (cur === max) ++cnt;

  return cnt;
}
```

The first loop finds the maximum integer and the second loop increments `cnt` if the current number happens to be the same as `max` (found in the first loop).

Because the loops are not nested, this approach is said to have time complexity of $O(n)$ nonetheless.

### Solution 2 with single loop and frequency counter

```javascript
/**
 * Counts how many times the largest integer shows up in the input.
 *
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @sig [Int] -> Int
 */
function birthdayCakeCandles(candles) {
  var max = -Infinity;
  var freq = {};

  for (var cur of candles) {
    max = Math.max(cur, max);
    freq[cur] = ++freq[cur] || 1;
  }

  return freq[max];
}
```

With this approach, a frequency counter is used to store the count of _each_ different integer that shows up.
`max` is still maintained like in the previous solution.
However, *both* thing are performed inside the _same_ loop this time.

The time complexity is $O(n)$, but we know we have one less loop than before, so in practice it should yield better performance.

The space complexity is $O(n)$ because it potentially needs to store a frequency of $n$ integers.
