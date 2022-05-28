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
