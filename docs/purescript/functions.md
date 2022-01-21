# PureScript Function

Import `Prelude` and other stuff to play around with these examples in the REPL.

!!! tip "REPL or module‽"

    If you see `>` it means to run the code in the REPL, otherwise, assume it is in a module.

!!! danger "Bad function names‽"

    Some of these functions have non-meaningful names on purpose. The idea is that we know what a function does by careful scrutiny of the signature and implementation as a way to force ourselves to read and understand each bit.


## Lambda Expression

Applying a lambda expression right then and there:

```
> (\n -> (mod n 2)) 6
0

> (\n -> (n `mod` 2)) 5
0
```

Assigning a lambda expression to a variable:

```purescript
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



In `f1` we `eq` compare `0` with the application `(mod n 2)`. In `f2` we `eq` compare `eq (mod n 2)` with`0`.



## Aliasing functions to infix symbol


Making an alias to `mod`:

```purescript
infixr 4 mod as %

f2 :: Int -> Boolean
f2 = eq 0 <<< (_ % 2)


f3 :: Int -> Boolean
f3 = (_ % 2) >>> eq 0
```


## Currying and Partial Application

Let’s define a function that “takes two arguments”:

```purescript
f :: Int -> Int -> Int
f x y = (+) x y
```

In fact, it does NOT take two arguments. It takes one argument, and returns a function that takes the other argument, which then returns the final, sum result.

Partially apply `myAdd`, that is, pass one argument. It returns a function with that argument pre (or partially) applied.

```
> :type f
Int -> Int -> Int

> g = f 1

> :type g
Int -> Int

> g 5
6
```

As we see, `increment` has the value 1 partially applied, so, when we later apply `increment 5`, the body of the function `(+) x y` becomes `(+) 1 5` and therefore the result 6.

We can apply all arguments at once, but that just seems like “all at once”:

```purescript
> f 1 2
3
```

But this is what is really happening (more or less 😅)
```purescript
> (f 1) 2
3

> f 1 $ 2
3
```

