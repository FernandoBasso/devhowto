---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Camel Case HackerRank challenge.
---

# Camel Case

- [Camel Case on HackerRank](https://www.hackerrank.com/challenges/camelcase)

## JavaScript

### Solution 1 with regexp

```javascript
/**
 * Counts the number of words in a camelCase string.
 *
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @param {string} s
 * @return {number}
 */
function camelcase(s) {
  if (s.length === 0) return 0;

  var re = /[A-Z]/,
      cnt = 1,
      i;

  for (i = 0; i < s.length; ++i)
    if (re.test(s[i])) ++cnt;

  return cnt;
}
```

Start assuming there is one word.
Then loop increment the count for each uppercase letter found.

### Solution 2 with includes()

```javascript
/**
 * Counts the number of words in a camelCase string.
 *
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @param {string} s
 * @return {number}
 */
function camelcase(s) {
  if (s.length === 0) return 0;

  var AZ = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  var cnt = 1,
      i;

  for (i = 0; i < s.length; ++i)
    if (AZ.includes(s[i])) ++cnt;

  return cnt;
}
```

Essentially the same approach as solution 1, except using a string of uppercase letters with an `includes()` instead of a regexp.

### Solution 3 with regex split

```javascript
/**
 * Counts the number of words in a camelCase string.
 *
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @param {string} s
 * @return {number}
 */
function camelcase(s) {
  if (s.length === 0) return 0;

  return s.split(/[A-Z]/).length;
}
```

😍
