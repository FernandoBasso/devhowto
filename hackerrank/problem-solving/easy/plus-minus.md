---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Plus Minus HackerRank challenge.
---

# Plus Minus

- [Plus Minus on HackerRank](https://www.hackerrank.com/challenges/plus-minus/)

The problem involves counting the frequencies of negative, zero, and positive numbers and the ratios of each of these three “categories” in the input.

In the example on the page:

```text
[1, 1, 0, -1, -1]
```

We have a ratio of $\frac{2}{5}$ positive numbers, $\frac{1}{5}$ zeroes, and $\frac{2}{5}$ negatives.

The sum of those ratios/fractions/percentages end up as 1 (100%).

One could break the problem into:

- Counting the frequencies.
- Computing the ratios.

To compute the ratios, simply divide the frequency of the category (negative, zero, positive) by the length of the input array.
If there are, say, 3 negatives, 1 zero, and 2 positives, the ratios would be (the array would contain 6 elements, thus we would divide by 6):

- $\frac{3}{6}$.
- $\frac{1}{6}$.
- $\frac{2}{6}$.

$$
\frac{3}{6} + \frac{1}{6} + \frac{2}{6} = \frac{6}{6} = 1
$$

## JavaScript

### Solution 1 with some helpers

```javascript
/**
 * Count the frequencies of negatives, zeros and positive integers.
 *
 * T.C: O(n).
 * S.C: O(1).
 *
 * @sig [Int] -> [Int, Int, Int]
 */
function countFreqs(xs) {
  return xs.reduce(function counter(acc, x) {
    var key = x < 0
      ? 'negatives'
      : x === 0
        ? 'zeroes'
        : 'positives';

    ++acc[key];

    return acc;
  }, { negatives: 0, zeroes: 0, positives: 0 });
}

/**
 * Get the ratios of negatives, zeroes and positives.
 *
 * ASSUME: Array is not empty (can't get ratio of empty array because
 * no division by zero can occur).
 *
 * T.C: O(1).
 * S.C: O(1).
 *
 * @sig [Int] -> [Number, Number, Number]
 */
function getRatios(xs) {
  var len = xs.length;
  var freqs = countFreqs(xs);

  return {
    negatives: freqs.negatives / len,
    zeroes: freqs.zeroes / len,
    positives: freqs.positives / len,
  };
}

function print(xs) {
  var ratios = getRatios(xs);

  log(ratios.positives);
  log(ratios.negatives);
  log(ratios.zeroes);
};

print([-5, 1, 0, -2, 9, 19, 41]);
print([1, 1, 0, -1, -1]);
```

### Solution 2 frequency counter

```javascript
/**
 * Get the ratios of negatives, zeroes and positives.
 *
 * ASSUME: Array is not empty.
 *
 * T.C: O(n).
 * S.C: O(n).
 *
 * @sig [Int] -> Void
 */
function getRatios(xs) {
  var len = xs.length;

  var freqs = xs.reduce(function reducer(acc, x) {
    var key = x < 0 ? 'n' : x === 0 ? 'z' : 'p';
    ++acc[key];
    return acc;
  }, { n: 0, z: 0, p: 0 });

  ['p', 'n', 'z'].forEach(k => log(freqs[k] / len));
}

getRatios([-5, 1, 0, -2, 9, 19, 41]);
getRatios([1, 1, 0, -1, -1]);
```

The length of the input is used to calculate the ratio.
If the input is an empty array, then the ratio cannot be computed as it is impossible to divide by 0 (zero).
