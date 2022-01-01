# Generics

**INFO**: This topic starts at [40:51 in the video](https://youtu.be/wD5WGkOEJRs?t=2451).

## Intro

Generic are those things that hurt people 🤣. They provide opportunities for
type variability:

- Traditional procedural functions allow for variability in values
  passed/returned;
- Allow for variability in the types used;
- Applicable to both class (and interfaces, he forgot to mention, or was not
  possible at the time) and functions and methods.

It is extremely hard to debug a type system. We can step through code and see
what is happening at each step. The same is not through with types. When the
compiler is doing its thing and checking types (at compile time, duh), it is
tricky to see how everything fits together.

It is probably one of the drawbacks to *extremely* statically typed
programming languages, because they make decisions based on how these types
work together, and they feel like magic, “Wait! How did you get from *a* to
*g* here‽”. If we could see the steps the compiler would take, it would be
easier to understand, but it is done in a black box.

Generics are basically the step into that world where we are where we are
thinking about types at compile time as opposed to thinking about objects at
runtime.

Fundamentally, what we are trying to do is allow for a type variable as
opposed to a runtime variable.

Arity is the number of parameters a function take. So, a two-arity function is
one that takes two parameters. When we create an array of T (`Array<T>`), we
are saying that is a one-arity generic, or one-arity parameterised type

## Generic Examples

The identify function shown in the video can be seen
[in the docs](https://www.typescriptlang.org/docs/handbook/2/generics.html)
with further reasoning and explanations.

```ts title="identity function example with generics"
--8<-- "src/typescript/ted-neward-advanced-typescript/e17-generics.ts"
```

Type parameters are part of the signature:

- The brackets tell the compiler that `T` is not a type itself, but a
  placeholder/variable;
- Therefore, the brackets and type parameter(s) must be in function/method
  signatures;
- Type parameter name only matters immediately where it is used;

## Rant about One-Capital-Letter Type Variables

Ted rants about TypeScript using C++-like type variables `T`, `U`, `V`, `W`,
etc. He understands why we like this single capitalized letter because it looks
out of place, compared to other things, but quite frankly generics can read
more easily if we are more descriptive with our type names. The Java people do
it, the C# folks do it (the short, unreadable one-capital-letter type
parameter), the TypeScript mob are doing it, but we don't have to do it.

Instead of a function that takes a `T` and returns an `U`, why not taking an
`In` and returning an `Out`? That is not the convention, and it is a sad
situation. For your own types, feel free to change the convention. Just make
sure to document it so people used to the old, traditional (and bad) way
understands the reasoning why you are doing it differently.

Again, the letters don't matter. Come up with something usefully
self-documenting and sensible.

A legit and reasonable rant. I agree with Ted.

## Generic Classes

Again, what Ted talks about here is also found
[int the docs](https://www.typescriptlang.org/docs/handbook/2/generics.html#generic-classes).

## Generic Constraints

- Indicate that we want or need a type parameter to have some functionality:
    - Property;
    - Method;
    - Inheritance relationship;
- We can restrict the type parameter using constraints:
    - `extends` requires the expression to be valid/true.

See the
[docs on generic constraints](https://www.typescriptlang.org/docs/handbook/2/generics.html#generic-constraints).

These constraints are what are really going to open up a whole variety of
options in terms of where typescript will go. For example, we can specify
defaults for type constraints.

```ts title="generic constraints with defaults"
--8<-- "src/typescript/ted-neward-advanced-typescript/e18-constraints-defaults.ts"
```

1.  Note we say `string` is the default type constraint.
2.  We do not use `<SomeType>` here because we are using strings for the
    names, and `string` is the default type constraint anyway (we could be
    explicit and do `new Names<string>([...])>` if we wanted to be
    explicit, though).
3.  Here we explicitly provide a type parameter so we don't fall in the default
    `string` because we are not using simple strings here, but an array of
    strings.


## Conditional Types
