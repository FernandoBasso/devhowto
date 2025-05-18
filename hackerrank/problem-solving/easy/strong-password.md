---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Strong Password HackerRank challenge.
---

# Strong Password

- [Strong Password on HackerRank](https://www.hackerrank.com/challenges/strong-password)

## JavaScript

### Solution 1

The solution is $max(6 - n, 4 - d)$ where `n` is string length and `d` is the number of different type of characters that are already present in the input password.

```javascript
/**
 * A password must contain at least 6 characters.
 */
const MIN_LEN = 6;

/**
 * A password must contain at least 1 char from each of the four
 * character classes blow.
 */
const NUMS = '0123456789';
const LOWERS = 'abcdefghijklmnopqrstuvwxyz';
const UPPERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const SPECIALS = '!@#$%^&*()-+';

/**
 * Checks if `str` contains a char from `oneOf`.
 *
 * - T.C: O(n²).
 * - S.C: O(n).
 *
 * @sig String -> String -> Boolean
 * @param {string} str
 * @param {string} oneOf
 * @returns {boolean}
 */
function contains(str, oneOf) {
  return !![...oneOf].find(c => str.includes(c));
}

/**
 * Returns the number of missing chars required to satisfy the
 * password requirements.
 *
 * - T.C: O(n²) because of `contains()`, which is itself O(n²).
 * - S.C: O(1).
 *
 * @param {number} length The length of the input password string.
 * @param {string} password The password string.
 * @returns {number} The number of missing chars.
 */
function minNum(length, password) {
  const missingLength = MIN_LEN - length;
  let missingType = 4;

  if (contains(password, NUMS))
    missingType -= 1;

  if (contains(password, LOWERS))
    missingType -= 1;

  if (contains(password, UPPERS))
    missingType -= 1;

  if (contains(password, SPECIALS))
    missingType -= 1;

  return Math.max(missingLength, missingType);
}
```

### Solution 2

```javascript
/**
 * A password must contain at least 6 characters.
 */
const MIN_LEN = 6;

/**
 * A password must contain at least 1 char from each of the
 * four character classes blow.
 */
const NUMS = '0123456789';
const LOWERS = 'abcdefghijklmnopqrstuvwxyz';
const UPPERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const SPECIALS = '!@#$%^&*()-+';

/**
 * Checks if `str` contains a char from `oneOf`.
 *
 * - T.C: O(n²).
 * - S.C: O(n).
 *
 * @sig String -> String -> Boolean
 * @param {string} str
 * @param {string} oneOf
 * @returns {boolean}
 */
function contains(str, oneOf) {
  return !![...oneOf].find(c => str.includes(c));
}

/**
 * Returns the number of missing chars required to satisfy the
 * password requirements.
 *
 * - T.C: O(n³).
 * - S.C: O(1).
 *
 * @sig Number -> String -> Number
 * @param {number} length The length of the input password string.
 * @param {string} password The password string.
 * @returns {number} The number of missing chars.
 */
function minNum(length, password) {
  const missingLength = MIN_LEN - length;
  const charClasses = [NUMS, LOWERS, UPPERS, SPECIALS];

  const missingType = charClasses.reduce((count, charClass) => {
    return contains(password, charClass) ? count - 1 : count;
  }, charClasses.length);

  return Math.max(missingLength, missingType);
}
```

Here `charClasses.length` is used as reduce's accumulator.
Each time a character class is found in `password`, 1 is reduced from that accumulator (`count` inside the reducer callback), 1 is subtracted.

In the end, the max of `missingLength` or `missingType` is returned to satisfy the challenge requirements.

Finally, the time complexity is $O(n³)$ because we use `contains()` (which is $O(n²)) inside `reduce()`.
