---
title: Number Types | PureScript
description: Learn about PureScript number types, their use and some useful tips and considerations about them.
---

# Simple Types | PureScript

## Numbers

Numbers can be of type `Number` and `Int`. Both are represented as normal JavaScript numbers at runtime. `Int`, however, has operations defined differently so that we always get integer results:

```haskell
> div 7 2
3

> mod 7 2
1

> div 7.0 2.0
3.5

> mod 7.0 2.0
0.0
```

Note how `div 7 2` results in 3, rather than 3.5. A number *without* a decimal is always considered an `Int`, while a number *with* a decimal is always considered a `Number`. Exponential notation always means the type is `Number`:

```haskell
> 1
1

> :type 1
Int

> 1.0
1.0

> :type 1.0
Number

> 1e0
1.0

> :type 1e0
Number

> 1e-2
0.01

> :type 1e-2
Number
```

They Int-typed operations are made to return integers with some use of bitwise operators, as we can see in `.spago/prelude/v6.0.0/src/Data/Ring.js`:

```js
export const intSub = function (x) {
  return function (y) {
    return x - y | 0;
  };
};
```

## Typing a number

As we saw, 1 is `Int`, while `1.0` or `1e0` is `Number`. We cannot force a value like `1` to be `Number` simply by adding a type annotation like in Haskell.

```haskell
n :: Number
n = 1
```

The above will produce an error:

```  Could not match type
  Could not match type
    Int
  with type
    Number
while checking that type Int
  is at least as general as type Number
while checking that expression 1
  has type Number
in value declaration n
PureScript(TypesDoNotUnify)
```



## Negative Numbers

To make negative numbers, use the unary `-` operator (requires parenthesis) or the `negate` function.

```purescript
> 1 + (-1)        
0

> 1 + negate 1    
0
```



## References

- [Official Docs on PureScript Types](https://github.com/purescript/documentation/blob/master/language/Types.md).
