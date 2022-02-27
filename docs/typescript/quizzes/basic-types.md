# Basic Types Quiz | TypeScript

!!! info "log"

    Assume this code is in scope:

    ```ts
    const log: Console["log"] = console.log.bind(console);
    ```

## The `any` “type”

!!! question

    Explain the `any` type.

    ??? "Answer"

        The `any` type is a top type. All other types are part of it. But the catch is that when used, (explicitly or implicitly when we don't provide a type and TypeScript can't infer one), it essentially *untypes* the thing it is being used on. So, yeah, we call it a type, but it is so generic that in practice it is like not typing and not allowing type inference to work either.


## What is the type?

!!! question

    ```ts
    var p;
    let q;
    ```

    What are the types of `p` and `q`? Explain.

    ??? "Answer"

        Both `p` and `q` are of the type `any`, which essentially means **untyped**. In places where TypeScript inference cannot possibly work and we don't specify a type ourselves, the `any` “type” is the default.

        We quote “type” because `any` is is a “type” which means *any type is OK here*, but which is not really a type. It is more or less like the value `NaN`. The type of the value `NaN` is `number`, but a value of `NaN` is not a number; it is equal to nothing, not even itself.

        In short, `any` “is a type”, which means *any type is OK*, which essentially *untypes* the identifier it is used with.

        The snippet above is the same as:

        ```ts
        var p: any;
        let q: any;
        ```

## Booleans and conditionals, `undefined`, `null`

!!! question

    ```ts
    const foo = undefined;
    const bar = null;

    if (foo) log("yes"); else log("no");
    if (bar) log("yes"); else log("no");
    ```

    Can we use `foo` and `bar` inside the conditional even though they are not booleans? What is the output of the snippet above.

    ??? "Answer"

        Yes, we can. In this kind of conditional context, values are first coerced to booleans and then the condition is evaluated. Other values are also coerced:

        ```ts
        if (someNumber) f();
        if (someArray) g();
        if (someObject) h();
        // etc.
        ```
        The output is of the snippet in the question is:

        ```text
        no
        no
        ```

## Assign `undefined` and `null` to boolean type

!!! question

    ```ts
    var g: boolean = false;
    let h: boolean = true;

    g = undefined;
    h = null;
    ```

    Are the last two lines valid?

    ??? "Answer"

        No, they are not valid. The literal types `undefined` and `null` DO NOT count as boolean values (they belong to the `undefined` and `null` types).

        Sure, they can be used in conditionals where booleans are expected, but that is because they are first coerced to actual booleans before the condition itself being evaluated.

        !!! tip "var vs let vs const and type inference"

        Sometimes `const` vs `let/var` causes types to be inferred differently, but not here. See the next question.

## Assigning different types

!!! question

    ```ts
    let w: string = 1;
    ```

    Explain what the compiler thinks about the snippet above.

    ??? "Answer"

        TypeScript complains about it. It kindly let's us know that “type 'number' is not assignable to type 'string'.” It has reason to believe we are out of our minds. Why would we be assigning a value of type `number` to a variable we said to be of the type `string`?

        And remember, the **value** of `w` is still the `number` 1. So, we may lie about the types, but the executed JavaScript will go its merry way (because what is executed is JavaScript, not TypeScript) and then we'll have to pretend that we are surprised when things break.

        - [TS Playground](https://www.typescriptlang.org/play?#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQDcAhgCcYAB1TQp7RJRgBGEQHpNMGAD0A-KOJdZQ4dpiAkwnUwuEmGACuAW2Y4pAGkchYBNQT89EA)

## Type inference with primitives and `var`, `let` and `const`

!!! question

    ```ts
    var x = "ha";
    let y = "dou";
    const z = "ken";
    ```

    What are the inferred types of `x`, `y`, and `z`? Explain.

    ??? "Answer"

        `x` and `y` are of the primitive type `string`, while `z` is of the literal type `"ken"` (the particular string “ken”).

        The reason is that both `var` and `let` allow reassignment, so we could replace `x` and `y` with other strings, but because we used `const` for `z`, we can't possible change its value; its value will forever and ever be the particular string `"ken"` and that is why `z`'s type is inferred to be that particular literal type rather than the generic `string` type as with the other two cases.

        - [TS Playground](https://www.typescriptlang.org/play?#code/G4QwTgBAHhC8ECIAWIEG4BQB6LEID0B+DDAGwFMAXCATzkQBMB7AV3W1wOIwGMmA7AM7UAXvQQBrcv3Y48eIkA)

## Type inference with functions, `var`, `let` and `const`

!!! question

    ```ts
    var f = () => 1;
    let g = () => 2;
    const h = () => 3;
    ```

    What are the inferred types of `f`, `g` and `h`?

    ??? "Answer"

        They are both of the type `() => number`, that is, a function that returns `number`.

        Unlike the previous question where `const z = "ken"` causes TypeScript to infer that `z` is of the particular literal type `"ken"`, `h` is not of the particular `() => 3`, that is, a function that always return the particular number 3.

        The reason is that TypeScript inspects literal values and the return values of functions (it knows `h` returns a number), but it doesn't inspects the entire function logic to make sure our function implementation will always return the specific number 3.

        - [TS Playground](https://www.typescriptlang.org/play?#code/G4QwTgBAZhC8EAoCUcB8ECMBuAUAejwggD0B+HHAGwFMAXCAczkRVnQCZcCiyKBjAPYA7AM70AFs2RoIAZi6EiJUkA)

## Composite types

!!! question

    What is another name for composite types? Why does that other name make sense?


    ??? "Answer"

        Composite types are also known as *shapes*. *Shapes* is a name that makes sense because it describe things like:

        - the structural feature of a type, including:

        - names and types of an object's properties

        - names and types of a function's parameters

        - indexes and types of an array's elements

## Importance of composite types

!!! question

    Why are shapes important?

    ??? "Answer"

        Because TypeScript uses a **structural type system**, which means the structure of types matter (instead of names of types, as in nominative typed languages, which means pretty much all other languages).

## Structural typing

!!! question

    ```ts
    type Profile = {
      name: string;
      skill: string;
    };

    type Jedi = {
      name: string;
      skill: string;
    };

    const jedi: Jedi = {
      name: "Yoda",
      skill: "The Force",
    };

    const yoda: Profile = jedi;
    ```

    Can we assign `jedi`, which is of type `Jedi` to `yoda`, which is of the type `Profile`? Explain.

    ??? "Answer"

        Yes, we can. TypeScript uses *structural typing* (not *nominative typing*), which in this case means the types `Profile` and `Jedi` are *interchangeable* because both have the same *shape* (structure). The names of the types are not that important for type-checking here. They are important for readability and to convey intent.

## Left-hand vs right-hand typing

!!! question

    Explain the difference between *left-hand* and *right-hand* typing and give some examples.

    ??? "Answer"

        Left-hand typing occurs when we annotate a *name* (identifier) with the colon followed by a type syntax:

        ```ts
        let foo: SomeType = someValue;
        ```

        Note that the type declaration happens on the left of the assignment operator. That is why it is called *left-hand typing*. Also, we used explicit typing here. Left-hand typing has to be explicit. Always.

        Right-hand typing happens when we do not explicitly use the colon syntax, but rather let type inference kick in, or when we use `as` type assertions (or its alternative `<TypeCast>` syntax). Both happen to the right hand side of the assignment operator. Some examples:

        ```ts
        const min = -Infinity; // <1>

        let user = getUser(1); // <2>

        // <3>
        const btnSignIn =
          document.getElementById('btn-sign-in') as HTMLButtonElement | null;

        // <4>
        const btnSignUp =
          <HTMLButtonElement | null> document.getElementById('btn-sign-up');
        ```

        1. Right-hand typing with type inference (implicit typing). `min` is inferred to be of type `number`.

        2. Right-hand typing with type inference (implicit typing). `user` is either `User` or `undefined`, which are the two possible types `getUser()` can return.

        3. Right-hand typing with type assertion (explicit typing using type assertion). Here, we, the developers of the application know that if we have an element with the `id` ‘btn-sign-in’, it will certainly be of type `HTMLButtonElement`, but if it is not there, then it is `null`.

        4. Same as the previous.

        !!! info

            We used `null` instead of `undefined` if `getElementById()` fails to find an element because that is what it returns if the element isn't found.

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0&ssl=39&ssc=85&pln=39&pc=1#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYVACeABxwwAqhBwAnSjADewmDFYdUYAK4BbZkpGawAQwM5U0Re0QiAviOEB6V29cwABnoWKIby0IeBwAMygAWgALc04YCWkOek9hXlg-JQhUAEFFRXNxAB55JQA+FTwNNS0dGABGABoYCytUAgBNEA5zAhhHRurVWtQAJmbW6xgCHOisAGtzGAAVOJA+gaGRmABmCcspmcK4JYBlHGA9Ao3B0hcwvTBgKFZwGEQcKFLFLkzFAEk6t9CNoyPxUN8YAAfGCPDjhdg4DhqaqKT5XMCw-wQehhdjcLjDbT9fiUCrEiiUrFKQFCYSOUTuTwwACiAA9LJJcCEQGEYHZENEorF4hBtDJEvYUky0phYAZ2CpIv8wHiwKwJIIYMzNDAAHoAflEuAy-hUHy+-i49Tp7k0htE6RgzCgYFOrEQYBVKg4IEuVjAUHoFpZuADUAAQuJAVwAOQusCRMWeyLsWOk8whAASywAsgAZCN6KBQcChnDh6EtPRwOAiO26h2pO0AOQA8ssWahltFWCFgJmonBWPMZBBxIHzGzgjBzHAsLOElIZJn-C9wM1mMX4CAQPMQsPR7PmQAlHDmZ6uABqehwrgA6jhmK5PsB6NQQAZJOAcIH3z2ZG8TMgnHSdpzCEBlESFcIDXV5IGCZluRCSRFB-BIQBgVCQGYMMQjiZEPjAJQ5zgcQYAMSCZDRUADADeFklSJ0E3dT1ZEkFQihzAsixLMsw1-WAYX0WsKl9f1BODT5y3DKMY3jV0kw9RM9EkdNBCAA)


## Type narrowing

!!! question


    ```ts
    /**
     * Formats a numeric value to USD currency format.
     */
    function toUSD(value: number | string): string {
      if (typeof value === "number") {
        //        <1>

        return `$ ${toTWoDecimals(value)}`;
        //                         <2>
      }

      return `$ ${toTWoDecimals(Number(value))}`;
      //                                <3>
    }
    ```

    What is the type of `value` is 1, 2 and 3? Explain.

    ??? "Answer"

        One could think the type of `value` is always the union type `number | string` because that is what the parameter type annotation says. That is not the case, however.

        1. Here the type is really the union `number | string`. At this point in the body of the function, nothing causes TypeScript to think otherwise.

        2. Here, TypeScript knows that `value` has to be a number. It knows it because it sees our `typeof` comparison. Given our test in the conditional, if we are inside this `if` block, then `value` can't possibly be anything other than `number`.

        3. Our union type is `number | string`. If we get past the condition (checking that `value` is a number) and its return statement, then, `value` is definitely **not** a number. Therefore, it must be a `string`. So, here, `value` is of type `string`.

        This is called *[narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html)*. It is technique the TypeScript type checker uses to *narrow* types down. That is, to make inferences based on conditionals, type guards and other constructions that permits more generic types to be *narrowed down* to more concrete and specific types.

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQHoAVBOEwJMAGIgATgFsAhlAgw1MMAFcVzHEphQQpgO7mOOYK3VwYABzhrgOLXojtE2mBxBYNQgZOSgACxx-W3s1RwgcJzUlDWV6ULFhADM9MGAoVnBTEAAVAHUQABEYhwguADc4vRxUfUNjflRoJR8YAG8ZGCUcKD0lMBhGuGb6M3lWAA8cbgAmIWEAX1FJaVkFZXVNPzbjVmBJpqizGABVAGVK6jHhvIBPGCyDjXTZTJy8gpFMz3SoNS6tAxGEwAHxg3R8nThUB6YF8AxgMFYWRgXCgrycOBA2KmzUoFCoBDaUII-H6gwxYjEGOZGIAegB+UQs4ajcYwAAGABIYIK+mZylUanE6iScPwNvyRCzGSzVWr1WzORitoMeWMJkKRWLShVqnZalwAHKQ4xg6Zy+WKwYqjWut3MjmbUTEXEgEFcACMABZ6ABmACc-HWPuBDy4BGDYfDNKEQA)
