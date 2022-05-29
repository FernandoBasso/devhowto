---
title: TypeScript Functions Quiz
---

# TypeScript Functions Quiz

## Q1

!!! question

    Consider:

    ```ts
    type Fn = (s: string) => string;

    const fn1: Fn = () => {
      return "one";
    };

    const fn2: Fn = (s: string, n: number): string => {
      return "two";
    };

    fn1();
    fn2();
    ```

    The identifiers `fn1` and `fn2` are annotated to the function type `Fn`, but neither implementations of `fn1` and `fn2` signature match the annotated type `Fn`. `fn1` is defined with no parameters at all, while `fn2` is declared with one extra parameter. What does the type checker have to say about these?

    ???+ "Answer"

        The type checker can see we are not making use of any argument inside the body of `fn1`, so it lets us get away with it during the definition itself. 

        This behavior exists to make sure TypeScript works similarly to the way JavaScript itself works, in which we can pass either less or more arguments to functions. If we declare a JavaScript function to take, say, two arguments, but we call the function providing only one argument, as long as we handle it correctly inside the function, then we are OK. Excess arguments are simply ignored.
        
        In `fn2`, we are declaring more arguments than allowed by the type `Fn`
        
        However, when calling the function, the type checker will complain that we are not providing the `string` parameter.

