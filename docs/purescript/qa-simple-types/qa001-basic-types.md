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
        ``
