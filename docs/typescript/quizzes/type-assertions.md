# Type Assertions (a.k.a. Type Casting)

## Type Assertion, Numbers and Strings

!!! question

    ```ts
    const a = 1 * ("1" as any);
    const b = 1 + ("1" as unknown as number);
    ```

    What are the inferred types of `a` and `b`? What about their values? Explain.

    ???+ "Answer"

        Both `a` and `b` are of the type `number`. Their values, however, are the string `"11"` for `a`, and the number `1` for `b`.

        If we remove the type assertions, we get vanilla JavaScript, and that are the results that JavaScript will give us. Fair and square!

        If we lie to TypeScript about the types, it is our fault. Just because we say some value is of a certain type, it doesn't make the the value really be of that certain type.

        Remember, types go away after transpilation. You are left with vanilla JavaScript.

        - [TS Playground](https://www.typescriptlang.org/play?#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYb1gBDSjACMMAFQwuBGQRgSI6sAE8hwgPT6YxmAD0A-KPExm0uQGolKtRpgBXMAGswIAO5h1TTA3AFtmHAAnPUMTM0thYi4JABobPSA)
