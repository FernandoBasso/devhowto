---
title: TypeScript Type Assertions (a.k.a Type Casting)
---

# TypeScript Type Assertions (a.k.a. Type Casting)

!!! note
    *Type assertions* (also known as type casting) are useful and sometimes really (really!) necessary, but **dangerous if used incorrectly**. I'm not against using them (I don't think it is even possible to *never* use them). I just hope some of these questions help people have a better appreciation of how, where and why they are dangerous.

    I also intend to add some questions to show situations where they are probably inevitable and can be put to good use.

## Type Assertion, Numbers and Strings

!!! question

    ```ts
    const a = 1 * ("1" as any);
    const b = 1 + ("1" as unknown as number);
    ```

    What are the inferred types of `a` and `b`? What about their values? Explain.

    ??? "Answer"

        Both `a` and `b` are of the type `number`. Their values, however, are the string `"11"` for `a`, and the number `1` for `b`.

        If we remove the type assertions, we get vanilla JavaScript, and that are the results that JavaScript will give us. Fair and square!

        If we lie to TypeScript about the types, it is our fault. Just because we say some value is of a certain type, it doesn't make the value really be of that certain type.

        Remember, types go away after transpilation. You are left with vanilla JavaScript.

        - [TS Playground](https://www.typescriptlang.org/play?#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYb1gBDSjACMMAFQwuBGQRgSI6sAE8hwgPT6YxmAD0A-KPExm0uQGolKtRpgBXMAGswIAO5h1TTA3AFtmHAAnPUMTM0thYi4JABobPSA)

## Increase a number

!!! question

    Imagine we want to increase a number. We create a function called `add1` which takes the number we want to increase. Sometimes we pass it a number, but sometimes we'll pass it a value that is retrieved from an input field and it comes as a numeric string like `"1"`. Because of those usage cases, our function takes either a `number` **or** a `string` (of course there are other design choices we could have made, but let's stick with this one for this exercise).

    ```ts
    function add1(n: number | string) {
        return n as number + 1;
    }
    ```

    We assert (cast) `n` to be a number so we can add the 1 to `n` without TypeScript type checker complaining about incompatible types. But our thinking is flawed here.

    What is the inferred return type of `add1()` and what is the return value of `add1(1)` and `add1("1")? Explain.

    ??? "Answer"

        The inferred return type of `add1` is `number`.

        ```ts
        add1(1);   // → 2
        add1("1"); // → 11
        ```

        The return type is `number` but we get a `string` in the second case?

        Yes, we do. And it is **our fault**.

        If the function takes a `number` **or** a `string`, then we should account for that with logic rather than lying about the types, making dangerous, wrong use of type assertions.

        REPEAT THIS COMMANDMENT WITH ME: **Thou shalt not blindly use type assertions to make the compiler happy about the types without careful consideration and contemplation of the implications it entails.**

        - [TS Playground](https://www.typescriptlang.org/play?#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQHox4sTAAGYGTHYwoACxwwAZgFcwwKK3AxmOBAHdqILXA4WAtuo0AnELZgBDTSEeuNrEza5TFVZgFRh7N0gpRVhWCHcYaEd2RAAaGBwANxwwRQ1ElxxVFPhWAGt1AgBGAhgvGAIAJgJ+OscYRxw3ODgATwSwLVtjR2iAFRU3WPig-tUHHT0DXLdgYBwAByh45hBVAaGRtoSklJEJUTEAKivhGCuYAEldRzcIHHi5BWZ+qvo7h4AmAAAQ2blergA3mAAL4wCbqQbDHDtKAgRQvLrvf73EGdKBaRyQeFqDHAV7vGxIkY4q6SbS6fSGNwcDhVLhgVDUlEwAA+iSgyTAiH4XMOPMhdw6RUJuRW8W57QA1DAqiIYZdbsIAOrqSbZZTot7vRywHhvKCtL6GozqDyK+gwABCWlg806dUJymCYDKJTimjgblMOBsak6-x1k2m3vU7A0KM6NnxsuUvQ26hA+RkLLZXH4CkiNiCU0U8Xm0oJRJgmW6Wkz2dz7KqBfcnFkTa41RaAH4YABRAAeGyD7EjdNEvFg-SonZb52kMCXAD0e5PMLAAF6Udys9ndoTRJcwVeiYhcXrpTdCIA)

        There are several ways we could have converted `n` to a `number` in case it was a `string`. It depending on the code style a project uses, preferences, and/or if we are dealing with integers or floats. Some examples:

        ```text
        +n + 1;
        Number(n) + 1;
        Number.parseInt(n, 10) + 1;
        Number.parseFloat(n) + 1;
        ```

        This way, we are converting the actual **value** to a number instead of just lying about its type.

        So, there you have it. We can think we have a certain type, but the actual value when executing the code may be of some other type.

        !!! error "type assertions"

            BEWARE of dangerous, or plain wrong use of *type assertions*. Use type assertions at your own risk.

            YOU HAVE BEEN WARNED!

        Of course, we could still check that the converted number is not `NaN`, but that is beyong the scope of this question.

        Here's a more advisable solution:

        ```ts
        function add1(n: number | string): number {
          return Number(n) + 1;
        }
        ```

        - [TS Playground](https://www.typescriptlang.org/play?#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQHox4sTAAGYGTHYwoACxwwAZgFcwwKK3AxmOBAHdqILXA4WAtuo0AnELZgBDTSEeuNrEza5TFVZgFRh7N0gpRVhWCHcYaEd2RAAaGBwANxwwRQ1ElxxVFPhWAGt1AgBGAhgvGAIAJgJ+OscYRxw3ODgATwSwLVtjR2iAFRU3WPig-tUHHT0DXLdgYBwAByh45hBVAaGRtoSklJEJUTEAKivhGCuYAEldRzcIHHi5BWZ+qvo7h4AmAAAQ2blergA3mAAL4wCbqQbDHDtKAgRQvLrvf73EGdKBaRyQeFqDHAV7vGxIkY4q6SbS6fSGNwcDhVLhgVDUlEwAA+iSgyTAiH4XMOPMhdw6RUJuQAcuLHBzWgBqGBVEQwy63YQAdXUk2yynRb3ejlgPDeUFaX2NRnUHm5jnoMAAQlpYPNOnVCcpgmAyiU4po4G5TDgbGpOv89ZNpn71OwNCjOjZ8bLlL0NuoQPkZCy2Vx+ApIjYglNFPF5tKCUSYJluloc3mC+yqsX3JxZK2uNUWgB+GAAUQAHhtQ+wY3TRLxYP0qD32+dpDBVwA9fvRQBJhDBGjPMLAAF6Udys9l9oTRVcwDfbhpVGqiYhcXrpQ+XiQwHeNdKNIA)

