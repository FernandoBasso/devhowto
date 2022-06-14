---
title: const | Functions Explained | PureScript
description: Let's scrutinize `const` implementation, evaluation and use with practical examples.
---

# const

Type signature for `const`:

```haskell
const :: ∀ a b. a -> b -> a
```

The type signature tells us that `const` is a function that takes two fully polymorphic type parameters and always returns the first parameter, untouched.

## const v1

```haskell
const :: ∀ a b. a -> b -> a
const x _ = x
```

## const v2

```haskell
const :: ∀ a b. a -> b -> a
const = \x _ -> x
```

## const v3

```haskell
f3 :: ∀ a b. a -> (b -> a)
f3 x = \_ -> x
```

## const usage

```haskell
module Const where

import Prelude ((>), const)
import Data.Array (filter)

r1 :: Array Int
r1 = filter (\n -> (>) n 2) [1, 2, 3, 4]

r2 :: Array Int
r2 = filter (const true) [1, 2, 3, 4]
```

`filter` calls `const true 1`, then `const true 2`, etc. for each element of the array. `const` will always ignore the element, and only consider `true` (the first argument, since `const` always ignores the its second argument`.

Observe that we partially apply `const` to `true`, so, each element of the list is in turn, passed as the remaining, “missing” (second) argument to `const`, which is promptly always ignored. The result is that the predicate is always satisfied and all elements are kept in the resulting array.

