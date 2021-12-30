# Generators

**INFO**: This topic starts at [34:43 in the video](https://youtu.be/wD5WGkOEJRs?t=2083).

Generators are effectively a way of creating iterables that aren't necessarily
tied to a collection of things. The whole purpose of a generator is to create an iterable that knows how to create an iterator that knows how to give particular values back.

Generators create iterable instances:

1.  Specifically, they create objects that know how to produce a range of
    values;
2. Popular in a number of functional/functional-object languages (F#, Scala,
   Haskell and others);
3. Sometimes called a “stream” or “sequence”;
4. TypeScript must target >= ES2015 to support this (because this is basically
  passed straight through).

In C#, the _yield return_ keyword is about generators. Java introduced _streams_, which is a similar concept. Haskell call them streams too, and one of the interesting properties of streams is that they can be infinite.

How many random numbers are there in the world? Is there ever a shortage or random numbers? So, if I wanted to get a collection of random numbers, wouldn't it make sense that we could create a thing that would give us a steady diet of random numbers every time we wanted to ask for one?

This is the kind of concept you wanna thing about when we talk about streams, particularly an infinite stream.

What I really want is a “thing” that knows how to produce the next value **on demand**. That is what an iterator does. It produces a value every time you ask for one.

Remember that iterators return a named tuple with `value` and `done`. Don't ask for “the next value after the end of the array”. That is generally bad when generators are involved.

We want an iterator that knows how to produce that value, without having to have all those values realized ahead of time. One canonical such example is reading a file, particularly if it is a large text file. We don't want to load the entire file in memory, but instead, create a generator that when passed a file name it would keep returning the next line of the file, on demand!

## Generator Example

1.  Identified by `function*` (note the *star* symbol);
1.  Invocation does not happen all at once:
    1.  Invocation creates an iterator object and returns that;
    2.  The iterator object “steps” through the function body;
    3.  Returns a value at each `yield` statement;
    4.  No more `yield`s mean the iterator returns `undefined` thereafter.

```ts title="generator example 1"
--8<-- "src/typescript/ted-neward-advanced-typescript/e13-generator.ts"
```

Compare with this:

```ts title="generator example 2"
--8<-- "src/typescript/ted-neward-advanced-typescript/e14-generator.ts"
```

1.  Note we don't call `next()` explicitly in the *for/of* loop. Because we
    invoked `namesGen()` and assigned its result to a variable, we can use that
    variable inside the *for/of* loop. Once all values are consumed, the
    generator stops returning values and the *for/of* loop stops executing.
2.  We then try to ask for more values from the generator, but it has been
    exhausted during the loop, it has no more values to produce.
3.  But if we invoke `namesGen()` again, it starts afresh.

## More Concepts about Generators

QUESTION: Why don't I just place those four names into an array?

ANSWER: Because, for started, I may not know all of these values at compile time.

As matter of fact, if you can wrap your head around the idea that a generator is a function that produces an iterator that produces a value on demand, you are about two steps away from understanding the whole reactive space. The whole reactive/observables everything. It builds on this as a starting point.

The generator is literally the producer side of an iterable.

For example, where people are getting really excited by this, particularly in the user interface space, Elm, is when you start thinking about all of the user input as an infinite stream of mouse clicks and key actions. Users will never stop doing stuff so it will always be an infinite stream, so now, given that as an assumption how to we wire up our user interface and so forth.

## Why Generators?

1.  Typically, not collection-based scenarios (such as “infinite sequences”);
2.  Construct values on demand (rather than all up-front or at once);
3.  Encapsulate the source of the data (whether collection based or not);

## Infinite Loop

!!! error "BEWARE 🔥"

    Don't try this at home! Or else 💀️...

```ts title="WARNING: INFINITE LOOP"
--8<-- "src/typescript/ted-neward-advanced-typescript/e15-nums-generator.ts"
```

The above example will reach *bottom* (in functional programming parlance). It
will never terminate.

## Some More Reasoning and History

Usually when we use infinite streams like these, we have functions or methods that know how to consume a fixed number values. The “head”, or “a slice of”, or “the first N elements”, etc. For example, in Haskell, `[1..]` produces an infinite list of numbers, but we could do things like this:

```hs title="Haskell take and takeWhile with infinite streams"
λ> take 3 [1..]
=> [1,2,3]

λ> take 7 [1,3..]
=> [1,3,5,7,9,11,13]

λ> takeWhile (< 5) [1..]
=> [1,2,3,4]
```

ECMAScript is slowly getting a lot of those functions (or we could write them
ourselves, not so difficult).

This concept is extremely functional, from the stand point that if you can
grok this then one part of Haskell that has always mystified people has
suddenly landed in place for you.

A lot of the folks that are working on the TypeScript compiler have masters and PhDs in computer science and spent a lot of time in the functional language space.

One of the original PM's for the TypeScript compiler, Luke Hoban, actually worked on the F# language for a number of years as a PM and spent a lot of time studying Scala and some other functional languages.

A lot of that crowd, Eric Meyer, Simon Paton Jones, they've weighed-in with thoughts here.

If all of this is making sense and you never looked at a functional language before, you might want to.

See
[BR Anders Heijlsberg & Luke Hoban: Introducing TypeScript](https://www.youtube.com/watch?v=3UTIcQYQ8Rw).
