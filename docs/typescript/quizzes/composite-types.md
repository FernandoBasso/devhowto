# Composite Types

## Structural Types Again

!!! question

    ```ts
    type Game = {
      title: string;
      year: number;
    };

    const tr1: Game = {
      title: "Tomb Raider I",
      year: 1996,
    };

    const tr2: Game = {
      title: "Tomb Raider II",
    };

    const tr3: Game = {
      title: "Tomb Raider III",
      year: 1998,
      composer: "Nathan McCree",
    };
    ```

    Explain what the TypeScript type checker thinks about our `tr1`, `tr2` and `tr3` objects?

    ??? "Answer"

        `tr1` is fine. It completely matches the type `Game`.

        `tr2` is *missing a property*. The type checker thinks, “why would this developer” say it is of this type and fail to provide the expected properties to match the type? It is likely an error on their part and I will complain about it.”

        `tr3` has one *excess property*. The type checker thinks, “why would this developer” say it is of this type and and then provide more than expected properties to match the type? Why did they not create the type with that extra property in the first place? It is likely an error on their part and I will complain about it.”

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQHox4sTACiADTQyAykpgAFAEoB5NTI0AVAJroAEjLQBpVQENOMALIBJFY4ByAcXXbdB42jOWSlKiUACeAA44MO7WALZRVADewjAwUKxQuKjQAE7siCKpoTjWOahgAK6xzDg5IgC+IsK8sFA5AIyoMfGUMMmp6Zk4qAT6INUwGtasHLUwjgQANCkwxaWo7QCcmwBsy42iElIwAOpRpVGxrBAQ+TDWMOE5IJE5YTCAGARrOR8wAO4AC1YwABMGuMByOAAjhVWJCOMdmKE0gComFIp9ujhAJgE9GCLTSOQATF04gk+itBlkYKNxsxJtNZjl5gt9k0jhJTlEAdYAG7nMAwHAADzathAFQgj2er3eH1AsXCIAgtV+UB5sHBYBAUGOEEiwFYADNWDgOGDBeq0REoh8sbj8ZhWjkAMyknpJSkZam0iZTGZzRxBpYrb4bbYADmWqQVSpVZRprms6tsDmAaEhOBDB2CnNcWn0MlQZxgiBwsFqzxyUpqwGskqif3OkJg+pwhqNoTuVrSNsxZI+x1s5tYsXiHFYyZwcGRTxAvID8BwNxgIGZsTXUTnstNUpTltRx3RURFBqgEDxEiAA)

## Assign composite types of incorrect shapes

!!! question

    ```ts
    type Game = {
      title: string;
      year: number;
    };

    const tr1: Game = {
      title: "Tomb Raider I",
      year: 1996,
    };

    //
    // We are missing a property ‘year‘ which is required
    // by the type ‘Game’.
    //
    const tr2: Game = {
      title: "Tomb Raider II",
    };

    //
    // We have an extranous property ‘composer‘ that is not
    // specified in the type ‘Game’.
    //
    const tr3: Game = {
      title: "Tomb Raider III",
      year: 1998,
      composer: "Nathan McCree",
    };

    //
    // <1> No errors What‽
    //
    const tr2Bkp: Game = tr2;

    //
    // <2> No error? What‽
    //
    const tr3Bkp: Game = tr3;
    ```

    The shapes of the objects `tr2` and `tr3` **do not** match the type `Game`. Why don't we get errors when doing the assignments in 1 and 2, which clearly state both `tr2Bkp` and `tr3Bkp` are of the type `Game`?

    ??? "Answer"

        When we specify a type and provide values (either simple literals or composite types) which are incompatible with that type by describing the value expliclity, property by property, we get errors. The type checker thinks, “why is this developer specifying this type but then providing something that doesn't fullfil this type's contract?”

        On the other hand, if we already have a value (literal or composite) assigned to an identifier, and annotate that identifier to be of a certain type, we can later use that identifier and assign it to another identifier of the same type (shape really, structural typing, remember?), even when the values and shapes don't match, the type checker does not complain about it. It complained about it earlier.

        On the other hand, if you have a value annotated to be of a certain type, and even if at that point the value assigned does not satisfy the type (which causes an error at that point) we can later assign it to some other identifier requiring that certain type without getting errors.

        In this question, `tr2` is missing the property `year`, but it is still of the type `Game`. Later, when we assign `tr2` to `tr2Bkp`, the type checker thinks, “OK, `tr2` is of the type `Game`. I'm OK with this.” The same hapens with `tr3` being assigned to `tr3Bkp`.

        In short:

        ```ts
        // We get errors here.
        var o: T = { /* something that doesn't satisfy T */ };

        // No errors at this point.
        var w: T = o;
        ```

        We know `o` fails to satisfy `T`, but the type checker still sees the `var o: T` and says, "OK, `o` is of type `T`. If `w` is of type `T`, we can assign `o` to `w`.