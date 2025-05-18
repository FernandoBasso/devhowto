---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and explanations on the Compare The Triplets HackerRank challenge.
---

# Compare The Triplets

- [Compare The Triplets on HackerRank](https://www.hackerrank.com/challenges/compare-the-triplets)

Note the input is always three elements for both Alice and Bob.

## JavaScript

### Solution 1

```javascript
const RATINGS_LEN = 3;

/**
 * Computes a tuple with Alice's and Bob's points.
 *
 * @param {[number, number, number]} aliceRatings
 * @param {[number, number, number]} bobRatings
 * @returns {[number, number]}
 */
function compareTriplets(aliceRatings, bobRatings) {
  let alicePoints = 0;
  let bobPoints = 0;

  for (let i = 0; i <= RATINGS_LEN; i++) {
    if (aliceRatings[i] > bobRatings[i])
      alicePoints += 1;
    else if (aliceRatings[i] < bobRatings[i])
      bobPoints += 1;
  }

  return [alicePoints, bobPoints];
}
```

A single loop with an index to access each pair from Alice and Bob input points and compare to know which person points to increment suffices here.

In the end, a tuple of Alice's and Bob's points is returned.
It is then up to the caller to output/display those values whatever way makes sense.
In HackerRank, it is mostly sending to STDOUT.

Look at other solutions in the source directory in the repository for this project.
