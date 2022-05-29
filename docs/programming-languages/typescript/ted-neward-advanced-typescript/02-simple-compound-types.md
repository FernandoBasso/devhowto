# Simple Compound Types

**INFO**: This topic starts at [06:08 in the video](https://youtu.be/wD5WGkOEJRs?t=368).

Arrays and tuples can be used bracket syntax or generic syntax:

```ts
const xs: number[] = [1, 2, 3];
const ys: Array<number> = [4, 5, 6];
```

!!! info

    Ted thinks kinda feels like they misnamed union and intersection
    types. He says that perhaps `&` should mean the union and `|`
    should mean the intersection.

## Union Types (EITHER/OR)

- Union types use a pipe `|` to denote “OR” (a sum type, not a product
  type).
- Similar to “union” types from C/C++ (done at the declaration; not a
  new type).
- Anything assignable to one of the union's members is accepted.
- Any property from any of the union's members are accessible. 

```ts
var z = string | number = 'zero';

z = 0;
z= '

// NOK 
// z = false
// Type 'boolean' is not assignable to type 'string | number'.
```

1. We say that `z` can be either a string OR a number. But it cannot be
   anything else, like <3>. We are also initializing it to the string “zero”.

2. OK, it can be a number.

3. Nope, it can’t be a boolean. It cannot be any other type that is not
   a string or a number.

## Intersection Types (AND)

Intersection types:

* Represent values that simultaneously have multiple types. The compound
  type `A & B` is a value that is both of type `A` **AND** type `B`.
* Typically used for object types.
    * `string & number` is effectively mutually exclusive.
* Can be very useful for function signatures.

Because this is an intersection type, it has to fully satisfy the one or
the other. You can’t mix and match.

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e06.ts"
```

1. Okay to call `f` with two strings.

2. Okay to call `f` with two numbers.

3. NOT okay to call `f` with any other combination of types. It has to
    fully satisfy the one of the other of the compound intersection
    (product) type.

4. ts error: no overload matches this call

    ```
     [tsserver 2769] [E] No overload matches this call.
       Overload 1 of 2, '(x: string, y: string): void', gave the following error.
         Argument of type 'number' is not assignable to parameter of type 'string'.
       Overload 2 of 2, '(x: number, y: number): void', gave the following error.
         Argument of type 'string' is not assignable to parameter of type 'number'.
    ```

5. ts error (same as previous error)


## Tuples

**VIDEO**: Topic starts at [9:33 in the video](https://youtu.be/wD5WGkOEJRs?t=563).

Introduced in ECMAScript 2015 introduced tuples and picked the *array syntax*
for them.

Tuples:

* Fixed-size collection of any different types (“fixed-size array of flexible
  types”);
* Unnamed field names;
* Access using indices into fields;
* Structurally typed

Some languages now a days are starting to let individual fields of tuples to
be named.

```ts
--8<--- "src/typescript/ted-neward-advanced-typescript/e07.ts"
```

1. TypeScript knows the first element of the tuple is a string.
2. TypeScript knows that the second element is a number, and that numbers
   don't have a  `substring` property/method.

!!! warning

    `String.prototype.substr` [has been deprecated](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substr).
    Prefer `String.prototype.substring` instead!

### Destructuring Tuples

We can destructure these tuples:

* Locals can be declared as “parts” of a larger thing (such as tuples);
* Destructuring is shorthand syntax;
* Empty comma can ignore elements in the source;
* `...` (*spread*) can capture the “rest” into one element.

A two-tuple of a string and a number and destructuring example:

```ts title="simple destructuring"
let tup: [string, number];
tup = ["Yoda", 1];
const [name, id] = tup;
log(name, id);
// → "Yoda", 1
```

A three-tuple of numbers, ignoring the second element in the
destructuring:

```ts title="ignoring elements when destructuring"
const nums: [number, number, number] = [1, 2, 3];
//          (1)
const [first, , third] = nums;
log(first, third);
// → 1, 3
```

1. Not a typo. We want to ignore the second value.


Destructuring example with `...` rest operator.

!!! info

    I extended this example to include the numbers generator in an
    attempt to make it a little more interesting.

```ts title="destructuring with spread"
/**
 * A Generator function that produces numbers from `min` to `max`.
 *
 * @param ini The start of the range (inclusive).
 * @param end The end of the range (inclusive).
 * @returns The generator.
 */
function* numsFromTo(
  ini: number,
  end: number,
): Generator<number, void, unknown> {
  while (ini < end) yield ini++;
}

// <1>
const [head, ...tail] = [...numsFromTo(0, 9)];

log(head, tail);
// → 0
// → [1, 2, 3, 4, 5, 6, 7, 8, 9];
```

Note how we can use `...tail` to capture all the remaining values that
have not been handled earlier on in the destructuring.


!!! note

    > The reason tuple syntax is important is as we start getting into some
    > more advanced types gymnastics, the tuple syntax will show up as a way
    > to express type tuples.


## Enums

**VIDEO**: Topic starts at [12:13 in the video](https://youtu.be/wD5WGkOEJRs?t=733).

Enumerated types:

* Represents bound set of possible values;
* Backed by numeric value (usually starting and 0 and incrementing if not
  specified).
* At run time enums are objects;
* “const enum” are compile-time computed for efficiency.

```ts
enum Direction {
  Up = 1, // (1)
  Down,
  Left,
  Right,
}

const currentDirection = Direction.Down;

if (currentDirection === Direction.Down) {
  movePlayerDown(player);
}

const isOne = Direction.Up === 1;
log(isOne);
// → true
```

1. Would be 0 if not explicitly set to start at 1.
