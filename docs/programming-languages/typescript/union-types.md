---
title: Union Types | TypeScript
description: Let's understand how union type works, how it relates to sets, the emtpy type `never` (empty set ∅) and some practical examples.
---

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

## Unions with the empty set ∅

If we concatenate a "z" with an empty string "", we get "z", right? (the empty string amounts to *nothing*). If we have a *union* of `string | never` (the empty set ∅), we end up with `string` (the empty set ∅ *also amounts to nothing*). Examples:

```ts
type T = string | never
// → string

type U = number | never;
// → number

type V = string | string[] | never;
// → string | string[]

type W = Record<string, number> | never;
// → { [k: string]: number }
```

In all of the above cases, the type `never` (the empty set ∅) is not part of the resulting type (not part of the set).

- [TS Playground](https://www.typescriptlang.org/play?#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNkmUFBEAE8OPAgAFQgAXghaRHQzQhMIAB8IQhkCAG5PCAgAPQB+COjYiABVZPz4AFthAlz8wvQSyDKqmpi4gDUmtIyszvHMkwBtAF1Oguli0orqyKGIAHUmgCU8BXQyAB5prIAaZraCAD4l7t7mfuqgA)

## Union of some type and any

Since `string` is a subtype of `any` (`any` is a *top type* which includes all other types), having a union of `string | any` results in simply `any`:

```ts
type T = string | any;
type U = number | any;
type V = Array<[number, string]> | any;
```

`T`, `U` and `V` are all of the type `any`.

- [TS Playground](https://www.typescriptlang.org/play?#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNkmUFBEAE8OPAgAFQgAXghaRHQzQhMIAB8IUiiAbk8ICAA9AH4I6NiIAFVkiEJ4AFthAlz8wiKS8qrImLiANUbYdHRiKIAeAG1mtoIAGlT0zJMAXQA+ToLiyFLK0CA)