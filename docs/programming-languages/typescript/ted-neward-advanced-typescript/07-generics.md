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

- We can defer type parameter decisions until later based on conditions;
- `extends` in this case serves as something of a conditional point;
- Syntax looks basically like the conditional (`? :`) operator (a.k.a. *ternary
  operator*)

```ts title="conditional type example"
--8<-- "src/typescript/ted-neward-advanced-typescript/e19-conditional-types.ts"
```

Has has been found out about 15 years ago (as of 2022) that C++ templates are
turing-complete. Ted is 99% sure that TypeScript templates are also
turing-complete. You could write your entire program entirely in terms of
generics. Compile and now you don't even have to run it because compiler has
already done all the work for you.

A lot of that thought is what went into the
[C++ boost library](https://www.boost.org/)
, which is how C++ is able to do a number of things that Java and C# can do,
but C++ can do it without a virtual machine 😲, because it can figure out a
number at these things at compile time rather than at runtime.

It is more or less what our `TypeName` type is doing. `extends` in this
particular case is basically our conditional. We can think of it as the
equality operator here, “if `T` extends string, then the returned type is
the literal "string"”. Same with the others.

Conditional types open an entire world of possibilities. I can say “this type
will be either a type A or a type B depending upon whether type A has a
particular property.” We can combine this with type constraints, so we can
say things like “either type A has to have this `length` property or the actual
type is a type B which is a proxy around type A that provides the `length`
property and does nothing.”

And that is the start of the box creaking open because you start getting into
mind-blowing techniques and possibilities.

NOTE: At this point Ted goes into typing currying and composition with an
example from a post from FreeCodeCamp. Watch
[this part at 1:00:17 in the video](https://youtu.be/wD5WGkOEJRs?t=3617).
Very bluntly this is the opening of a Pandora's box. There is a tremendous
amount of power and turing-completeness that we can wrestle with in the
TypeScrpt space.

The aforementioned FreeCodeCamp post,
[How to master advanced TypeScript patterns — Learn how to create types for curry and Ramda](https://www.freecodecamp.org/news/typescript-curry-ramda-types-f747e99744ab/),
goes into how to build currying to replace the untyped versions of currying
that we see in
[Ramda](https://ramdajs.com/).

Ted emphasizes it is a very well-written tutorial stepping you through step
by step in terms of how all of these things will combine in order to allow us
to curry. It is an extremely good way to come up to speed on some features
that TypeScript has making use of these conditional typing capabilities.

## Conclusion

Ted finishes saying he would hope the TypeScript team would take some time to
update the spec and the docs (make them complete). He said he created PDFs out
of the 1.8 spec, the handbook and the release notes, and it came about to about
470 pages 😲.

> This is NOT a trivial language.
> 
> And please, don't think that TypeScript is just JavaScript with a little
> typing thrown in.
>
> These guys are thinking a much, much longer more strategic game, and there is
> a lot more waiting in the wings. We are not done here by any stretch of the
> imagination.
