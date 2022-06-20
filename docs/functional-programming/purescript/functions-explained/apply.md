---
title: apply, $ | Functions Explained | PureScript
description: Concepts, implementation and examples on the use of `apply' (the `$' operator) in PureScript
---

# apply, $

Type signature:

```haskell
apply :: ∀ a b. (a -> b) -> a -> b
```

It takes a function a from *a* to *b*, a parameter of type *a*, and returns something of the type *b*. Presumably, the given function turns *a* into *b*.

The implementation couldn't be simpler:

```haskell
apply :: ∀ a b. (a -> b) -> a -> b
apply f x = f x
```

And then we call it like this:

```repl
> apply identity 1
```

Or

```repl
> import Prelude ((/))

> apply (_ / 2.0) 5.0
2.5

> apply (2.0 / _) 5.0  
0.4
```

We partially-apply the `/` function through the use of sectioning. The result is a function that takes the remaining argument.

There is no real benefit in using `apply` like this. We mostly care about its `infixr` operation version, `$`. Let's define it:

```haskell
apply :: ∀ a b. (a -> b) -> a -> b
apply f x = f x

infixr 0 apply as $
```

Remember that 0 (zero) is the lowest possible precedence. Something of precedence 0 is evaluated last.

### Using $ (dollar symbol) infixr apply operator

We attempt this:

```repl
> import Effect.Console (log)

> log identity "hello"
... error ...
```

`log` takes a string, but we are passing it a function (`identity`). We need to parenthesize it like this:

```repl
> log (identity "hello")
hello
```

If we want to log a number, first convert it to a string (since `log` takes a string):

```repl
> import Prelude (show, identity)

> log (show (identity 1))
1
```

We can replace parentheses with `$`:

```repl
> log $ identity "hello"
hello

> log $ show $ identity 1
1
```

Because `$` is **infixr**, it associates to the right, meaning it will first evaluate things on the right, passing the result those evaluations to the things on the left, which end up being evaluated last. This should help illustrate:

```text
log (identity "hello")
log $ identity "hello"

log (show (identity 1))
log $ show $ identity 1 
```

