---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Time Conversion HackerRank challenge.
---

# Time Conversion

- [Time Conversion on HackerRank](https://www.hackerrank.com/challenges/time-conversion)

## JavaScript

### Solution 1

```javascript
/**
 * Converts a 12-hour time format to a 24-hour (military) format.
 * 
 * - T.C: O(n).
 * - S.C: O(1).
 *
 * @sig String -> String
 */
function timeConv(time) {
  if (time.includes('AM')) {
    return time
      .replace('12', '00')
      .replace('AM', '');
  }

  if (time.includes('PM')) {
    if (/^12/.test(time))
      return time.replace('PM', '');

    return time.replace(/([01][0-9])/, function replacer(m, g1) {
      return Number(g1) + 12;
    }).replace('PM', '');
  }
}
```

### Solution 2 using ramda and helpers

Uses a mix of helper function and some partial application.

```javascript
import {
  pipe,
  replace,
  includes,
  test,
} from 'ramda';

var subst12With00 = replace('12', '00');

/**
 * Drop either 'AM' or 'PM' from the string `s`.
 *
 * @sig String -> String
 * @param {string} s
 * @returns {string}
 */
var dropMeridiem = replace(/(AM|PM)/, '');

/**
 * Adds 12 to the value of the first capturing group.
 *
 * @sig Any String -> Number
 * @param {Any} _m Not used, but part of replace callback signature.
 * @param {string} g1 The first capturing group.
 * @returns {string}
 *
 * @example
 * add12('...', '11');
 * //=> 23
 */
function add12(_m, g1) {
  return Number(g1) + 12;
}

/**
 * Takes a a meridiem time format and adds 12 to the hour.
 *
 * @sig String -> String
 */
var add12toPM = replace(/([01][0-9])/, add12);

/**
 * Checks if the given string includes 'AM'.
 *
 * @sig String -> Boolean
 */
var includesAM = includes('AM');

/**
 * Checks if the given string includes 'PM'.
 *
 * @sig String -> Boolean
 */
var includesPM = includes('PM');

/**
 * Checks if the given string starts with '12'.
 *
 * @sig String -> Boolean
 */
var startsWith12 = test(/^12/);

/**
 * Converts a 12-hour time format to a 24-hour (military) format.
 *
 * @sig String -> String
 * @param {string} time
 */
function timeConv(time) {
  if (includesAM(time))
    return pipe(subst12With00, dropMeridiem)(time);

  if (includesPM(time)) {
    if (startsWith12(time))
      return dropMeridiem(time);

    return pipe(add12toPM, dropMeridiem)(time);
  }
}
```

### Solution 3 with ramda pipe

```javascript
import {
  pipe,
  replace,
  includes,
  test,
  ifElse,
  when,
  complement,
} from 'ramda';

var subst12With00 = replace('12', '00');

/**
 * Drop either 'AM' or 'PM' from the string `s`.
 *
 * @sig String -> String
 * @param {string} s
 * @returns {string}
 */
var dropMeridiem = replace(/(AM|PM)/, '');

/**
 * Adds 12 to the value of the first capturing group.
 *
 * @sig Any String -> Number
 * @param {Any} _m Not used, but part of replace callback signature.
 * @param {string} g1 The first capturing group.
 * @returns {string}
 *
 * @example
 * add12('...', '11');
 * //=> 23
 */
function add12(_m, g1) {
  return Number(g1) + 12;
}

/**
 * Takes a a meridiem time format and adds 12 to the hour.
 *
 * @sig String -> String
 */
var add12toPM = replace(/([01][0-9])/, add12);

/**
 * Checks if the given string includes 'AM'.
 *
 * @sig String -> Boolean
 */
var includesAM = includes('AM');

/**
 * Checks if the given string includes 'PM'.
 *
 * @sig String -> Boolean
 */
var includesPM = includes('PM');

/**
 * Checks if the given string starts with '12'.
 *
 * @sig String -> Boolean
 */
var startsWith12 = test(/^12/);

/**
 * Converts a 12-hour time format to a 24-hour (military) format.
 *
 * @sig String -> String
 * @param {string} time
 *
 * @example
 * timeConv('11:59:59PM');
 * //=> '12:59:59'
 */
var timeConv = pipe(
  ifElse(
    includesAM,
    subst12With00,
    when(
      includesPM,
      when(
        complement(startsWith12),
        add12toPM,
      ),
    ),
  ),
  dropMeridiem,
);
```
