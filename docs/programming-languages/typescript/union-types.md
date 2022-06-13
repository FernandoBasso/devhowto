# Union Types

Think of types as sets. A type is a set in which certain values can inhabit.

## never

There is an inhabitable type called `never`. No value exists on the type `never`, which means an identifier typed as `never` cannot possibly be assigned any value:

```ts
let n: never;
let s: never;
let o: never;
let a: never;

n = 1;
s = "Hello!";
o = { id: 1, skill: "The Force" };
a = [1, 2, 3];
```

- [TS Playground](https://tsplay.dev/mpnnBw)

The last four lines are all errors.

The type `never` is *the empty set* ∅.

## Union of never with empty set ∅

If we concatenate a "z" with an empty string "", we get "z", right? (the empty string amounts to *nothing*). If we have a *union* of `string | never` (the empty set ∅), we end up with `string` (the empty set ∅ *also amounts to nothing*).

```ts
type T = string | never
```

The type of `T` is simply `string`.

- [TS Playground](https://tsplay.dev/wXQQ9N)

## Union of some type and any

Since `string` is a subtype of `any` (`any` is a *top type* which all other types belong to), having a union of `string | any` results in simply `any`:

```ts
type T = string | any;
type U = number | any;
type W = Array<[number, string]> | any;
```

`T`, `U` and `W` are all of the type `any`.

- [TS Playground](https://tsplay.dev/mLqqZW)