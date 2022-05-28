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
