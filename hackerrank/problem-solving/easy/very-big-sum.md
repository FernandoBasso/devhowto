---
subtitle: HackerRank Problem Solving & Algorithms
description: Notes and solutions for Big Sum Hacker Rank Challenge.
---

# A Very Big Sum

- [A Very Big Sum challenge on HackerRank](https://www.hackerrank.com/challenges/a-very-big-sum/problem).

ECMAScript has +0 and -0. Read more:

- [ECMAScript 6 Strict Equality Comparison](https://262.ecma-international.org/6.0/#sec-strict-equality-comparison)
- [ECMASCript 13 Number Type](https://262.ecma-international.org/13.0/#sec-ecmascript-language-types-number-type).
- [ECMAScript 13 Number::equal()](https://262.ecma-international.org/13.0/#sec-numeric-types-number-equal).
- [Are +0 and -0 the same? on StackOverflow](https://stackoverflow.com/questions/7223359/are-0-and-0-the-same).

## TypeScript

The TypeScript version of this challenge sounds very difficult because they mention things like `LONG_INTEGER` and `LONG_INTEGER_ARRAY`, which don't matter for languages like ECMAScript (JavaScript, TypeScript) or other languages that don't bother too much with different numeric types.
It was probably ported from C or C++, or some other language where you can't store a `long int` into an `int` (or other similar situations) without losing precision.

### Test Cases

```{code} typescript
:filename: bigSum.test.ts
import { assertEquals } from "/deps.ts";
import { sum } from "./bigSum.ts";

Deno.test("sum()", async (t) => {
  await t.step("should sum empty array", () => {
    assertEquals(sum([]), 0);
  });

  await t.step("should sum arrays of 1 element", () => {
    assertEquals(sum([0]), 0);
    assertEquals(sum([-0]), 0);

    //
    // $ deno repl
    //
    // > -0 === -0
    // true
    // > -0 === +0
    // true
    // > +0 === -0
    // true
    //
    // Yet, this fails. Must be the way `assertEquals()` is implemented.
    //
    // assertEquals(sum([-0]), -0);
    //

    assertEquals(sum([1]), 1);
    assertEquals(sum([-1]), -1);
  });

  await t.step("should sum arrays of 2 or more elements", () => {
    assertEquals(sum([1, 2]), 3);
    assertEquals(sum([-1, -2]), -3);

    assertEquals(sum([-1, 1, -2, 2]), 0);
    assertEquals(sum([-1, 1, -2, 2]), 0);

    assertEquals(sum([1e4]), 1e4);
    assertEquals(sum([-1e4]), -1e4);
  });

  await t.step("should sum test case from problem description", () => {
    assertEquals(sum([
      1000000001,
      1000000002,
      1000000003,
      1000000004,
      1000000005,
    ]),
    5000000015,
    );
  });
});
```

### v1 Procedural for loop

```{code} typescript
:filename: bigSum-v1.ts
/**
 * Sums an array of numbers.
 *
 * This solution uses a for loop in a procedural style.
 *
 * **TIME COMPLEXITY**: O(n). We iterate once for each element of the
 * input array of numbers.
 *
 * **SPACE COMPLEXITY**: O(1). We simply add to the `total` variable.
 *
 * @param xs The array of numbers to sum.
 * @returns The sum.
 */
function sum(xs: number[]): number {
  let total: number = 0;

  for (let i: number = 0; i < xs.length; ++i)
    total += xs[i];

  return total;
}

export { sum };
```

### v2 FPish with reduce and inline add function

```{code} typescript
:filename: bigSum-v2.ts
/**
 * Sums an array of numbers.
 *
 * This solution uses a reducing function in a more FPish way. The
 * reducing function is defined in place through an arrow function.
 *
 * **TIME COMPLEXITY**: O(n). We iterate once for each element of the
 * input array of numbers.
 *
 * **SPACE COMPLEXITY**: O(1). We simply add to the `total` variable.
 *
 * @param xs The array of numbers to sum.
 * @returns The sum.
 */
function sum(xs: number[]): number {
  return xs.reduce((acc: number, n: number): number => {
    return acc + n;
  }, 0);
}

export { sum };
```

### v3 FPish with reduce and helper add function

```{code} typescript
:filename: bigSum-v3.ts
import { add } from "/lib/add.ts";

/**
 * Sums an array of numbers.
 *
 * This solution uses a reducing function in a more FPish way making
 * use of the `add` helper.

 * **TIME COMPLEXITY**: O(n). We iterate once for each element of the
 * input array of numbers.
 *
 * **SPACE COMPLEXITY**: O(1). We simply add to the `total` variable.
 *
 * @param xs The array of numbers to sum.
 * @returns The sum.
 */
function sum(xs: number[]): number {
  return xs.reduce(add, 0);
}

export { sum };
```


### Ramda REPL

- [A Big Sum Ramda REPL](https://ramdajs.com/repl/#?%0Afunction%20f%28acc%2C%20num%29%20%7B%0A%20%20%2F%2F%20acc%20%3D%200%0A%20%20%2F%2F%20num%20%3D%201%0A%20%20%2F%2F%20curTotal%20%3D%201%0A%20%20%0A%20%20%2F%2F%20acc%20%3D%201%0A%20%20%2F%2F%20num%20%3D%202%0A%20%20%2F%2F%20curTotal%20%3D%203%0A%20%20%0A%20%20%2F%2F%20acc%20%3D%203%0A%20%20%2F%2F%20num%20%3D%203%0A%20%20%2F%2F%20curTotal%20%3D%206%0A%20%20const%20curTotal%20%3D%20acc%20%2B%20num%3B%0A%20%20return%20curTotal%3B%0A%20%20%2F%2F%20acc%20%3D%201%0A%20%20%2F%2F%20acc%20%3D%203%0A%20%20%2F%2F%20acc%20%3D%206%0A%7D%0A%0A%5B1%2C%202%2C%203%5D.reduce%28f%2C%20100%29%3B%0A%0Afunction%20myAdd%28x%2C%20y%29%20%7B%0A%20%20return%20x%20%2B%20y%3B%0A%7D%0A%0Aconst%20mySum%20%3D%20reduce%28myAdd%2C%200%29%3B%0A%0AmySum%28%5B1%2C%202%2C%203%5D%29%3B%0A)
