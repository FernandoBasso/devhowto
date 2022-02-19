# Basic Types Quiz | TypeScript

## Q1: Booleans

!!! question

    ```ts
    var g: boolean = false;
    let h: boolean = true;

    g = undefined;
    h = null;
    ```

    Are the last two lines valid?

    ??? "Answer"

        No, they are not valid. The literal types `undefined` and `null` DO NOT count as boolean values (they belong to the `undefined` and `null` types). Also note that `var` and `let` make no difference for the types here (sometimes `const` vs `let/var` causes different types, but not here).

## Q2: min and max numbers

!!! question

    How can you know the minimum and maximum JavaScript numbers possible on your runtime?

    ??? "Answer"

        By taking a look at `Number.MIN_VALUE` and `Number.MAX_VALUE`.

