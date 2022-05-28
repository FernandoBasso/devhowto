# Basic Types

**NOTE**: Assume `import Prelude` in all examples unless otherwise noted.

## Q1

!!! question

    ```purs
    n :: Number
    n :: 1
    ```

    What is the problem?

    ??? "Answer"

        The type `Number` requires a decimal part. Make it `1.0` and it works.

        The literal `1` is considered an `Int`.  As a reference, this is the error produce by the code in the question:

        ```text
          Could not match type

            Int

          with type

            Number

        while checking that type Int
          is at least as general as type Number
        while checking that expression 1
          has type Number
        in value declaration n1
        ```

## Q2

!!! question

    How is `Int` represented internally? Why does it exist? Give an example of its usage where it differs from `Number`.

    ??? "Answer"

        The runtime representation of `Int` is a normal JavaScript number (just like `Number`.

        It exists to allow integer operations to be defined differently so that the results are always integers.

        ```purs
        > div 7 2
        3

        > mod 7 2
        1

        > div 7.0 2.0
        3.5

        > mod 7.0 2.0
        0.0
        ```
## Q3

!!! question

    What is the syntax for the `Char` type? How to write a unicode code point for a char using escape sequences?

    ??? "Answer"

        We use single quotes:

        ```purescript
        charZ :: Char
        charZ = 'Z'
        ```

        The escape sequence to for unicode code points is `\x<hex>`, for example:

        ```purs
        check :: Char
        check = '\x2714'
        -- → ✔
        ```
