# Two Fer

- [Two-Fer Exercism Challenge](https://exercism.org/tracks/typescript/exercises/two-fer)

## Unit Tests

```ts
import { twoFer } from "./two-fer";

describe("TwoFer", () => {
  it("no name given", () => {
    const expected = "One for you, one for me.";
    expect(twoFer()).toEqual(expected);
  });

  it("a name given", () => {
    const expected = "One for Alice, one for me.";
    expect(twoFer("Alice")).toEqual(expected);
  });

  it("another name given", () => {
    const expected = "One for Bob, one for me.";
    expect(twoFer("Bob")).toEqual(expected);
  });
});
```

## v1 Ternary Conditional Operator

Using the [Conditional (Ternary) Operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator) in a very standard way.

```ts
/**
 * An implementation of the two-fer Exercism TypeScript challenge.
 *
 * @param name The optional name to include in the sentence.
 * @returns The sentence with the name or ‘you’ by default.
 */
export function twoFer(name?: string): string {
  const who: string = name ? name : "you";
  return `One for ${who}, one for me.`;
}
```

We could also have inlined the ternary inside the `${ ... }` expression, without
the `who` extra variable:

```ts
return `One for ${name ? name : 'you'}, one for me.`;
```

## v2 Default Operator (logical OR ||)

Or using a the
[Default Operator, Logical OR || Operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_OR), which is an old-school technique (but beware
of falsy values):

```ts
return `One for ${name || "you"}, one for me.`;
```

## v3 Nullish Coalescing Operator ??

With the
[Nullish Coalescing Operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Nullish_coalescing_operator)
only `undefined` and `null` are actually considered falsy values.

```ts
return `One for ${name ?? "you"}, one for me.`;
```

