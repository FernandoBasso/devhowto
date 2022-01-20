# PureScript Functions

Import `Prelude` and other stuff to play around with these examples in the REPL.

!!! tip "REPL or module‽"

    If you see `>` it means to run the code in the REPL, otherwise, assume it is in a module.

!!! danger "Bad function names‽"

    Some of these functions have non-meaningful names on purpose. The idea is that we know what a function does by careful scrutiny of the signature and implementation as a way to force ourselves to read and understand each bit.


## Lambda Expressions

Applying a lambda expression right then and there:

```
> (\n -> (mod n 2)) 6
0

> (\n -> (n `mod` 2)) 5
0
```

Saving lambda expression to a variable:

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
## Aliasing functions to infix symbols

> f1 n = eq 0 (mod n 2) 
> f2 n = eq (mod n 2) 0

> f1 4
true

> f2 4
true
```



In `f1` we `eq` compare `0` with the application `(mod n 2)`. In `f2` we `eq` compare `eq (mod n 2)` with`0`.



## Aliasing functions to infix symbols



Making an alias to `mod`:

```purescript
infixr 4 mod as %

f2 :: Int -> Boolean
f2 = eq 0 <<< (_ % 2)


f3 :: Int -> Boolean
f3 = (_ % 2) >>> eq 0
```

