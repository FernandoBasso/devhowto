---
title: infer | Conditional Types | TypeScript
description: A detailed discussion, concepts and examples on the `infer' keyword with conditional types.
---

# infer keyword

[TypeScript 2.8 introduced Conditional Types](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-8.html), and with it, the `infer` keyword.

## ReturnType

`infer` can only be used with conditional types. The quintessential example of it  is use is with the utility type `ReturnType`:

```typescript
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : any;
```

Let's try a multi-line syntax:

```typescript
type ReturnType<T> =
  T extends (...args: any[]) => infer R
  ? R
  : any;
```

Given some type `T`, if it looks like a function, then return its inferred return type `R`; otherwise return `any`.

### Some Details

Technically, `(...args: any[])` and `(...args: any)` is the same thing. By definition, `any` being a *top type* which includes all types in the known and unknown universes, also also includes `any[]` (or `Array<any>`). However,  `any[]` more correctly **conveys intent** that we are dealing with an array of arguments.

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
// 'getAge' refers to a value, but is being used as a type here.
//
```

OK. We need to provide the *type* of  `getAge()`. Well, we can use `typeof` type operator, which in `TypeScript` can also be used in *type context* (not only in *expression context*) to get the type of the function:

```typescript
type GetAgeReturnType = Ret<typeof getAge>;
// → number | undefined
```

- [TS Playground typeof function value](https://www.typescriptlang.org/play?#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNkmUFBEAE8OPAgAJTxEAB4AFQA+CABeUAgIVIg8AA9EPHJaCAAKcRridBNuCFIogG0AXQBKbMyzQn50BNyIAH5BvOx4QgBrQlQXQgBuCOAAKhXclYSk9DMZPAqUOOliS3g41F4IQ4gOdFRY9GiIAANiEzxniEUr5DjzaTKX2EACs8KpxBsIJCAAIcOrEAC2XzghCiQNBqh+xEQEAUSmIvQOvxudweT1e72eEIgm2h6CS8CI+WJb3OA2ekykvF6eDInzMl1mOOIxzM1mEljw1JWYF4k1U9kIEHeiFg70qqGwAG8mu9hthCPAEcICBAAL4dA1Gk0DAA+EE5eG5hF5EC1Q3piEZStQw3ErKWZoi0ViEAA4kk1XhEl6iKkYnEslsUiG8BdlZH3uklpA8gA9YagIA)

## References

- [TypeScript 2.8 Release Notes](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-8.html)
- [TypeScript typeof type operator](https://www.typescriptlang.org/docs/handbook/2/typeof-types.html)

