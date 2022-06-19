---
title: infer | Conditional Types | TypeScript
description: A detailed discussion, concepts and examples on the `infer' keyword with conditional types.
---

- [infer keyword](#infer-keyword)
  - [ReturnType](#returntype)
    - [Some Details](#some-details)
  - [Back to ReturnType](#back-to-returntype)
  - [References](#references)
  - [Examples Explained](#examples-explained)
    - [Utility Type FirstArg](#utility-type-firstarg)

# infer keyword

[TypeScript 2.8 introduced Conditional Types](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-8.html), and with it, the `infer` keyword. In this post, we'll investigate how to understand and use the `infer` keyword through several examples. We'll mostly create and use *type utilities* for this purpose.

**INFO**: Utility types, or type helpers (like `ReturnType<T>` or `Nullable<T>`) **work on types**. They take and return types. They do not take or return values. They work on type context, not in expression (value) context.

## ReturnType

The `infer` keyword can only be used with conditional types. The quintessential example of it  is use is with the utility type `ReturnType`:

```typescript
type ReturnType<T> =
  T extends (...args: any[]) => infer R
  ? R
  : any;
```

Given some type `T`, if it looks like a function, then return its inferred return type `R`; otherwise return `any`.

### Some Details

Technically, `(...args: any[])` and `(...args: any)` are the same thing. By definition, `any` being a *top type* which includes all types in the known and unknown universes, also also includes `any[]` (or `Array<any>`). However, `any[]` more correctly **conveys intent** that we are dealing with an array of arguments.

Also, we could probably write the utility type `ReturnType<T>` to return `unknown` instead of `any`:

```typescript
type ReturnType<T> =
  T extends (...args: any[]) => infer R
  ? R
  : unknown;
```

Or even `never` (the empty type/set ∅):

```typescript
type ReturnType<T> =
  T extends (...args: any[]) => infer R
  ? R
  : never;
```

The difference would be when passing something that was NOT a function.

## Back to ReturnType

One very important thing to note is that `ReturnType<T>` **takes a type**, not a value.

```typescript
type F1 = ReturnType<() => void>;
// → void

type F2 = ReturnType<() => string | string[] | undefined>;
// → string | string[] | undefined
```

Note the type parameter passed to `ReturnType<T>`. We are passing a **type**, not a value. Both `() => void` and `() => string | string[] | undefined` are function types, not function values.

- [TS Playground function type](https://www.typescriptlang.org/play?#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNkmUFBEAE8OPAgAJTxEAB4AFQA+CABeUAgIVIg8AA9EPHJaCAAKcRridBNuCFIogG0AXQBKbMyzQn50BNyIAH5BvOx4QgBrQlQXQgBuCOjY3ABGbISk5MqurMzpVDMydKXIPIA9YeWYuJwAJk3ElN3uiFpEdF6TCAAfd8+33afwgkykvF6eBOZ2Yl2uQA)

We can pass a function value and see it does not work:

```typescript
/**
 * Retrieves the value of the property `age` on the given object.
 *
 * @param o Any object that contains the property `age`.
 * @return The age or `undefined` if not available.
 */
function getAge(o: { age?: number }): number | undefined {
  return o?.age;
}

type GetAgeReturnType = ReturnType<getAge>;
//
// ERROR:
//
// 'getAge' refers to a value, but is being used as a type here.
//
```

OK. We need to provide the *type* of  `getAge()`. Well, we can use `typeof` type operator, which in `TypeScript` can also be used in *type context* (not only in *expression context*) to get the type of the function:

```typescript
type GetAgeReturnType = ReturnType<typeof getAge>;
// → number | undefined
```

- [TS Playground typeof function value](https://www.typescriptlang.org/play?#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNkmUFBEAE8OPAgAJTxEAB4AFQA+CABeUAgIVIg8AA9EPHJaCAAKcRridBNuCFIogG0AXQBKbMyzQn50BNyIAH5BvOx4QgBrQlQXQgBuCOAAKhXclYSk9DMZPAqUOOliS3g41F4IQ4gOdFRY9GiIAANiEzxniEUr5DjzaTKX2EACs8KpxBsIJCAAIcOrEAC2XzghCiQNBqh+xEQEAUSmIvQOvxudweT1e72eEIgm2h6CS8CI+WJb3OA2ekykvF6eDInzMl1mOOIxzM1mEljw1JWYF4k1U9kIEHeiFg70qqGwAG8mu9hthCPAEcICBAAL4dA1Gk0DAA+EE5eG5hF5EC1Q3piEZStQw3ErKWZoi0ViEAA4kk1XhEl6iKkYnEslsUiG8BdlZH3uklpA8gA9YagIA)

## Examples Explained

### Utility Type FirstArg

Here we have a utility type that returns the type of the first argument of the given function type:

```typescript
type FirstArg<FnType> =
  FnType extends (p1: infer P1, ...args: any[]) => any
  ? P1
  : never;
```

`FirstArg` utility type takes a type (not a value), and try to see if it looks like a function type. Note that it tries to match a first argument `p1` plus any potential remaining arguments `...args` and the return `any`. The remaining arguments and the return type must be there to satisfy the required syntax, but what matters is the portion `p1: infer P1`. If it successfully matches a function type, then the conditional returns the inferred type `P1`, otherwise, return `never`.

The identifiers `p1` and `P1` could be any other names, like simply `p` and `P`, or `first` and `First`, `foo` and `Bar`, etc.

Let's see what happens if we pass types that are NOT function types:

```typescript
type T0 = FirstArg<string>;

type T1 = FirstArg<number | null | undefined>;

type T2 = FirstArg<Record<string, number>>;
```

Since the provided types are not function types, the conditional fails to match a function type, and `T0`, `T1` and `T2` are all of the type `never`. There is no way to infer the first parameter of something that is not even a function.

What about this:

```typescript
type T3 = FirstArg<() => void>;
```

We do pass it a function type, except it has no arguments. `never` is returned only if what we pass is not a function type. Here, it **is** a function type. But it is impossible infer a first parameter that doesn't exist. TypeScript infers it as unknown in this case.

Finally, some examples that actually return the type of the first argument:

```typescript
type T4 = FirstArg<(x: number) => void>;

type T5 = FirstArg<(xs: number[], s: string) => void>;

declare function g(s: string, n: number): void;

type T6 = FirstArg<typeof g>;
```

These all return the type of the first argument correctly. Special note to `T6`. Remember that we must provide a type, not a value. That is why we use `typeof g` here.

## References

- [TypeScript 2.8 Release Notes](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-8.html)
- [TypeScript typeof type operator](https://www.typescriptlang.org/docs/handbook/2/typeof-types.html)
