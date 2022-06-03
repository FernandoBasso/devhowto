---
title: Functions | PureScript
description: Learn about PureScript functions, their practical use, examples, tips and insights.
---

# PureScript Function

## Intro Notes

Assume `import Prelude` unless otherwise noted.

!!! tip "REPL or module‽"

    If you see `>` as the first character in a line, it means we are in the REPL, otherwise, assume it is in a module.

!!! danger "Bad function names‽"

    Some of these functions have non-meaningful names on purpose. The idea is that we know what a function does by careful scrutiny of the signature and implementation as a way to force ourselves to read and understand each bit.

    If we say `add1 = ...`, we immediately know this functions adds 1 to its argument. If we name it `f` or `g`, we have to read the signature and implementation carefully to understand its ideas and what it does.

    That is a terrible idea for production code, but a very good approach to study, practice, ponder about stuff, and *learn*.

## Lambda Expression

Applying a lambda expression right then and there:

```
> (\n -> (mod n 2)) 6
0

> (\n -> (n `mod` 2)) 5
0
```

Note that functions are not *printable*; they do not have an instance of the type class `Show`:

```purs
(\n -> n) # (1)
```

It produces an error that we cannot "print" something that does not implement `Show`.

```purs-repl
> (\n -> n)

Error found:
in module $PSCI
at <internal>:0:0 - 0:0 (line 0, column 0 - line 0, column 0)

No type class instance was found for

    Data.Show.Show (t2 -> t2)

The instance head contains unknown type variables. Consider adding a type annotation.

while solving type class constraint

PSCI.Support.Eval (t2 -> t2)

while applying a function eval
of type Eval t1 => t1 -> Effect Unit
to argument it
while checking that expression eval it
has type Effect t0
in value declaration $main

where t0 is an unknown type
    t1 is an unknown type
    t2 is an unknown type

See https://github.com/purescript/documentation/blob/master/errors/NoInstanceFound.md for more information,
or to contribute content related to this error.
```

Assigning a lambda expression to a variable:

```purs
> f = (\n -> mod n 2)
> f 3
1
```

```
module Data.Examples where

import Prelude

isEven :: Int -> Boolean
isEven n = mod n 2 == 0

f1 :: Int -> Boolean
f1 = eq 0 <<< (_ `mod` 2)
```

Verifying if a number is even:

```
## Aliasing functions to infix symbol

> f1 n = eq 0 (mod n 2)
> f2 n = eq (mod n 2) 0

> f1 4
true

> f2 4
true
```

In `f1` we `eq` compare `0` with the application `(mod n 2)`. In `f2` we `eq` compare `eq (mod n 2)` with `0`.

## Aliasing functions to infix symbol

Making an alias to `mod`:

```purs
infixr 4 mod as %

f2 :: Int -> Boolean
f2 = eq 0 <<< (_ % 2)

f3 :: Int -> Boolean
f3 = (_ % 2) >>> eq 0
```

## Currying and Partial Application

Let’s define a function that “takes two arguments”:

```purs
f :: Int -> Int -> Int
f x y = (+) x y
```

The function `f` is curried by default. It is the default PureScript (and Haskell) behavior that all functions are curried by default (unless you make some tuple magic to de-curry a function).

### The Quintessential “add 1” Example

In fact, `f` does NOT take two arguments. It takes one argument, and returns a function that takes the other argument, which then returns the final, sum result.

The *add 1* quintessential partial application example:

```
> :type f
Int -> Int -> Int

> g = f 1

> :type g
Int -> Int

> g 5
6
```

Partially apply `f`, that is, pass one argument. It returns a function with that argument already applied. `g` now is the partially applied `f`.

As we see, `increment` has the value 1 partially (or pre) applied, so, when we later apply `increment 5`, the body of the function `(+) x y` becomes `(+) 1 5` and therefore the result 6.

We can apply all arguments at once, but that just seems like “all at once”:

```purs
> f 1 2
3
```

But this is what is really happening (more or less 😅)
```purs
> (f 1) 2
3

> f 1 $ 2
3
```

!!! tip "Currying and Partial Application"

    When we define a function, we say it is a curried function if it has this property of not requiring all arguments at once upon application. PureScript and Haskell functions are curried by default. No especial syntax or anything else is needed to get curried functions.

    So, **currying** happens (automatically) when we define functions.

    After a function exists, we can *apply the function to arguments*. If we apply less than the total number of arguments the function requires to be fully applied, we say we *partially applied the function*.

    Therefore, **partial application** happens when applying (invoking, calling) the function (if less than the total number of argument a function requires to be fully applied are provided).

    A partially applied function returns a function which some of the parameters applied, still awaiting for the remaining parameters to fully realize the function application, which then produces the final value or result.

    Also note that the returned function from a partial application is itself curried.

### Example with replace

With Object Oriented languages with create specializations from generalizations  mostly through the use of inheritance and interfaces. In functional languages, we do this mostly through composition and partial application.

Consider the function `replace` from the `Data.String` module:

```purs
> import Data.String
> :type replace
Pattern -> Replacement -> String -> String

> replace (Pattern " ") (Replacement "-") "Tomb Raider I 1996"
"Tomb-Raider I 1996"
```

`replace` replaces any `Pattern` with some `Replacement`. We could make it more specialized by partially applying its `Pattern` argument.

```
> replaceSpaces = replace (Pattern " ")

> :type replaceSpaces
Replacement -> String -> String

> replaceSpaces (Replacement "-") "Tomb Raider I 1996"
"Tomb-Raider I 1996"
```

Now, the function `replaceSpaces` is a specialized version of the more generic `replace`, in which it always replaces *spaces* with some `Replacement`.

We could further specialize `replace` by partially applying the first two arguments. In this case, the `Pattern` and the `Replacement` specialize the function, and the remaining argument is the `String` to which the substitution will be performed on:

```purs
> replaceSpacesWithHyphen = replace (Pattern " ") (Replacement "-")

> :type replaceSpacesWithHyphen
String -> String

> replaceSpacesWithHyphen "Tomb Raider I 1996"
"Tomb-Raider I 1996"
```

Since `replaceSpaces` exist, we could specialize from that instead of from the original `replace`:

```
> replaceSpaces = replace (Pattern " ")

> replaceSpacesWithHyphen = replaceSpaces (Replacement "-")

> replaceSpacesWithHyphen "Tomb Raider I 1996"
"Tomb-Raider I 1996"
```

!!! info "Examples in JavaScript"

    I have some examples of creating specialized functions from generic functions through the use of currying and partial application in this [Code Sandbox project](https://codesandbox.io/s/webinar-functional-programming-in-javascript-ts0jt?file=/src/replace1.js). It is talk I sometimes give to introduce or motivate coworkers about functional programming.

Here's one example using `replaceAll` with proper type signatures:

```purs
import Data.String.Pattern (Pattern(..), Replacement(..))
import Data.String.Common (replaceAll)

replaceSpaces :: Replacement -> String -> String
replaceSpaces r s = replaceAll (Pattern " ") r s

replaceSpacesWithHyphens :: String -> String
replaceSpacesWithHyphens s = replaceSpaces (Replacement "-") s
```
