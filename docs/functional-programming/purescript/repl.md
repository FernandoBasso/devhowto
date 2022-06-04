---
title: REPL Read, Eval, Print, Loop | PureScript
description: Practical examples of using the PureScript REPL to try things and inspect types and values
---

# Read, Eval, Print, Loop: REPL

**NOTE**: Assume `import Prelude` in all examples unless otherwise noted.

## Intro

It takes some practice to get familiar about when you can use one of `:type` or `:kind` to inspect types, values, expressions and constructors.

```text title="help on the repl"
$ spago repl
PSCi, version 0.14.5
Type :? for help

> :?           
The following commands are available:

    :?                        Show this help menu
    :quit                     Quit PSCi
    :reload                   Reload all imported modules while discarding bindings
    :clear                    Discard all imported modules and declared bindings
    :browse      <module>     See all functions in <module>
    :type        <expr>       Show the type of <expr>
    :kind        <type>       Show the kind of <type>
    :show        import       Show all imported modules
    :show        loaded       Show all loaded modules
    :show        print        Show the repl's current printing function
    :paste       paste        Enter multiple lines, terminated by ^D
    :complete    <prefix>     Show completions for <prefix> as if pressing tab
    :print       <fn>         Set the repl's printing function to <fn> (which must be fully qualified)

Further information is available on the PureScript documentation repository:
 --> https://github.com/purescript/documentation/blob/master/guides/PSCi.md
```

## :type

According to the help, `:type` is for **expressions**:

```text title="Use :type for expressions"
> :type 'a'
Char

> :type "w" 
String

> :type 'w'
Char

> :type "w"
String

> :type 1
Int

> :type 3.14
Number

> :type []
forall (t1 :: Type). Array t1
```

Then we try something like:

```text
> :type 1 .. 3
  Unknown operator (..)

> :type range 1 3
  Unknown operator (..)
```

Wait! `1 .. 3` **is** an expression, and so is `range 1 3`. We just need to import `range` and its synonym `..` from some module that offers a `range` function:

```text title="import range and .."
> import Data.List (range, (..))
> :type 1 .. 3
List Int

> :type range 1 3 
List Int
```

The fact is that `..` is an infix synonym (or *alias* if you will) for `range`.

Since `range` is a function, it is a value, an since `..` is a synonym for `range`, `..` is a value too. Just remember that most non alphabetic function names are generally infix, and to get info on infix *operators*, we generally need to enclose them inside parenthesis:

```text
> :type ..
Unexpected or mismatched indentation at line 1, column 1

> :type (..)
Int -> Int -> List Int
```

See how the same error and solution applies for `compose`, for example:

```text
> :type <<<  
Unexpected or mismatched indentation at line 1, column 1

> :type (<<<)
forall (t33 :: Type) (a :: t33 -> t33 -> Type) (b :: t33) (c :: t33) (d :: t33). Semigroupoid @t33 a => a c d -> a b c -> a b d
```

You can take a look at `..` in [Pursuit](https://pursuit.purescript.org/packages/purescript-arrays/6.0.1/docs/Data.Array#v:(..)), click view source and see it is defined as:

```haskell
infix 8 range as ..
```

## :kind

As seen earlier, `:kind` shows the kind of a type.

It works for the types and type constructors. For example:

```text
> :kind Array
Type -> Type
```

It means `Array` is a type constructor that is not fully realized (it means it is awaiting for more types) that takes a type which then return the fully realized type.

If we say `Array`, it is an array of what? Numbers? Chars? Strings? Or an array of lists? Or even an array of arrays? We don't know that by simply saying `Array`. It needs a further type in order to be fully realized:

```
> :kind Array Char
Type

> :kind Array String
Type

> :kind Array (Array Int)
Type
```

When `:kind <type>` returns `Type`, you may rest assured you are dealing with a fully realized type. If it returns `Type -> Type`, it is awaiting one type argument in order to be fully realized. If it says `Type -> Type -> Type`, it means it is awaiting for two more type arguments in order to be fully realized, and so on and so forth.
