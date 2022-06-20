---
title: Type Signatures | PureScript
description: Let's understand type signatures in PureScript (and in Haskell), how they work, how to interpret them, and see practical examples.
---

# Type Signatures

In the book Haskell From First Principles, there are lots of exercises about inferring function's implementations given its type signatures (not providing the name of the functions either).

At first, we may be baffled and think “how can one possibly infer the implementation given only a type signature?“. Looks like an impossible task at first.

## Fully Polymorphic, Unconstrained Types

Consider the type signature of this function `f`:

```haskell
f :: a -> b
```

It takes an *a* and returns a *b*. Lowercase letters denote **fully polymorphic, unconstrained types**. It is the most polymorphic a type can get. It means a value could be of any type whatsoever.

Also, `a -> b` means that *a* and *b* **can be different types**, not that they have to be different. *a* could be an integer, but *b* could also be an integer. In other words, and more concretely, `f :: a -> b` could mean `Int -> Int`, `Int -> String`, `String -> String`, `String -> Int`, `Foo -> Bar`, or any other possible combination of types.

## Example 1

Consider this function (with simplified type signature):

```haskell
f :: (a -> b) -> Array a -> Array b
```

The `(a -> b)` piece denotes a function from *a* to *b*. That is, a function that takes a value of “some type a” and returns value of “some type b”. *a*  and *b*  are said to be *fully polymorphic types*, meaning they are not constrained in any way.

Since we don't know the concrete types for *a* and *b*, it could be that they are different, but by chance, could be that they are the same type, for example:

```text
(a -> b)
(Int -> String)
(String -> Int)
(Int -> Int)
(String -> String)
```

So, if we give the function some value of type *a*, and it gives use back some value of type *b*, clearly, it does something to *a* to turn it into *b*. If it does something to *a*, clearly, the function `f` takes a function, an array of *a*, and returns an array of *b*. That means the function `f` changes the input in some way before returning it.

```spago-repl
import Data.Functor (map)

map (\x -> show x) [1, 2, 3]
["1", "2", "3"]

map (_ + 1) [1, 2, 3]   
[2,3,4]
```

In the first case, it converts the type *a* to *b*, in this case, `Int` to `String`. In the second case, it keeps takes `Int` and also returns `Int`, but adding 1 to it. In both cases, some operation was performed on *a*. One of them changed its value and type, the other just changed its value but retained its original type.

## Example 2

Consider this type signature:

```haskell
f :: a -> a
```

This type signature does not feature a function. `f` takes an *a*, and returns it. No operation is performed on *a*. Therefore, this `f` does nothing to *a*.

Another one:

```haskell
g :: a -> b -> a
```

This signature means `g` takes and *a*, and a *b*, and then simply returns *a*. Again, no function is applied to *a*, therefore, this function ignores *b* and simply gives back *a*.

What about this one:

```haskell
h :: Array a -> a
```

Again, there is no function parameter. We give `h` an array of *a*, and it returns an *a* (a single *a*, without performing any operation on *a*). So, `h` probably just gives us back one element of the given array.

