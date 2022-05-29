# Type Compatibility

## Structural vs Nominal Typing

**INFO**: This topic starts at [0:34 in the video](https://youtu.be/wD5WGkOEJRs?t=34).

TypeScript operates by structural typing. Two instances are
type-equivalent if their contents are “matchable”. Other languages with
similar syntax (C++, Java, C#, etc.) use “nominative typing”, or
“nominal typing”.

TypeScript compiler looks at the **members** of the things we are
working with, not the **name**.

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e02.ts"
```

1. Because `y` requires a string and a number, but x only has a string,
   we get the error that `age` is missing in `x`.

Structural typing is the basis for many cool and interesting things in
TypeScript (examples‽), which we cannot do with nominal-typed languages.

## Type Assertion

We can use a **type assertion** to mean “I want to use this as a
string”.

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e02.ts"
function getNameOrNum(): string | number {
  return (Date.now() % 2) === 0 ? "Twenty Seven" : 27;
}

let norn = getNameOrNum();

//
// Using type assertion. <1>
//
l(norn.valueOf());

// <3>
if ((<string>norn).substring) {
  log((<string>norn).substring(0, 5));
} else if ((<number>norn).toFixed) {
  log((<number>norn).toFixed(2));
}
```

1.  `someValue.valueOf` is available on almost any value.

    null prototype

    One exception is an object created with `null` as its prototype,
    which inherits nothing and therefore it nas no `valueOf` property:

        var obj = Object.create(null);
        obj.valueOf();
        Uncaught TypeError: obj.valueOf is not a function

2.  This is not an “instance of” test, because there is no inheritance
    relationship between string and number.

Note that we have to repeat the cast-like assertion to test the
condition, and then again inside the if/else blocks.

## Type Guards

Type Guards are getting better and better over time. Check the
[release notes for TypeScript 4.4](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-4.html)
for instance.

Besides type assertion (cast-like things), we can also make use of type
guards for similar results.

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e03.ts"
```

1.  Creates a type guard function that checks whether the given value is
    a string.

2.  Because we are using a type guard now, we don’t need to assert/check
    the type again inside the if/else/then blocks.

## typeof Type Guards
We can also use type guards directly defined inside the body of a
function (not defined as a separate type-guard function, like above).

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e04.ts"
```

We could simplify the `padLeft` function:

```ts
--8<-- "src/typescript/ted-neward-advanced-typescript/e05.ts"
```

1.  Here the type guard is done using a simple condition. It is not
    necessary to always create a type guard function. Use your best
    judgement for each case.

2.  Because the TypeScript compiler is ridiculously clever, it knows
    that if the input isn’t a number (from the guard in the `if`
    condition), then it can only be a string and we don’t need another
    type guard here.
