# Basic Types Quiz | TypeScript

## Question 1

!!! question

    ```ts
    const foo = undefined;
    const bar = null;

    if (foo) log("yes"); else log("no");
    if (bar) log("yes"); else log("no");
    ```

    Can we use `foo` and `bar` inside the conditional even though they are not booleans?

    ??? "Answer"

        Yes, we can. In this kind of conditional context, values are first coerced to booleans and then the condition is evaluated. Other values are also coerced:

        ```ts
        if (someNumber) f();
        if (someArray) g();
        if (someObject) h();
        // etc.
        ```

## Question 2

!!! question

    ```ts
    var g: boolean = false;
    let h: boolean = true;

    g = undefined;
    h = null;
    ```

    Are the last two lines valid?

    ??? "Answer"

        No, they are not valid. The literal types `undefined` and `null` DO NOT count as boolean values (they belong to the `undefined` and `null` types). Also note that `var` and `let` make no difference for the types here (sometimes `const` vs `let/var` causes different types, but not here).

## Question 3

!!! question

    What is another name for composite types? Why does that other name make sense?


    ??? "Answer"

        Composite types are also known as *shapes*. *Shapes* is a name that makes sense because it describe things like:

        - the structural feature of a type, including:

            - names and types of an object's properties

                - names and types of a function's parameters

            - indexes and types of an array's elements

## Question 4

!!! question

    Why are shapes important?

    ???+ "Answer"

        Because TypeScript uses a **structural type system**, which means the structure of types matter (instead of names of types, as in nominative typed languages, which means pretty much all other languages).

## Question 5

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

    Can we assign `jedi`, which is of type `Jedi` to `yoda`, which is of the type `Profile`? Why?

    ??? "Answer"

        Yes, we can. TypeScript uses *structural typing* (not *nominative typing), which in this case means the types (could be interfaces as well) `Profile` and `Jedi` are *interchangeable* because both have the same *shape* (structure). The names of the types are not that important for type-checking here. They are important for readability and to convey intent.
