# Basic Types Quiz | TypeScript

!!! info "log"

    Assume this code is in scope:

    ```ts
    const log: Console["log"] = console.log.bind(console);
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
