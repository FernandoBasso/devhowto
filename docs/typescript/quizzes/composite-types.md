---
title: TypeScript Composite Types Quiz
---

# TypeScript Composite Types Quizz

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

**NOTE**: The next question is based on, and a continuation of this one.

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
    // <1> No error? What‽
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

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYQHox4sTACiADTQyAykpgAFAEoB5NTI0AVAJroAEjLQBpVQENOMALIBJFY4ByAcXXbdB42jOWSlKiUACeAA44MO7WALZRVADewjAwUKxQuKjQAE7siCKpoTjWOahgAK6xzDg5IgC+IsK8sFA5AIyoMfGUMMmp6Zk4qAT6INUwGtasHLUwjgQANCkwxaWo7QCcmwBsy42iElIwAOpRpVGxrBAQ+TDWMOE5IJE5YTCAGARrOR8wAO4AC1YwABMGuMByOAAjhVWJCOMdmKE0gComFIp9ujhAJgE9GCLTSOQATF04gk+itBlkYKNxsxJtNZjl5gt9k0jhJTlEAdYAG7nMAwHAADzathAFQgj2er3eH1AsXCIAgtV+UB5sHBYBAUGOEEiwFYADNWDgOGDBeq0REoh8sbj8ZhWjkAMyknpJSkZam0iZTGZzRxBpYrb4bbYADmWqQVSpVZRprms6tsDmAaEhOBDB2CnNcWn0MlQZxgiBwsFqzxyUpqwGskqif3OkJg+pwhqNoTuVrSNsxZI+x1s5tYsXiHFYyZwcGRTxAvID8BwNxgIGZsTXUTnstNUpTltRx3RURFBqgEDxR1z0gAQhVYNq-os0tYANbneAgECv+6tVEwI1sAQP58mQYJrxgfQgSlcEKk4ZcoGHaxmBnGAtAsGBa3rFVPjadpfljXAoGnZEIGTa4TWXI9-2Pft4g+S9JAJPCb1fcJ3XJPD2UkTkZH5A8JUQUEAAM2iJYTV2YAArdtNSlK4bjuYTvmE58MjBKVoFYOA4FXI0URwI8+2ErFhPoSCaJteTkxBRjmidQkiVY9jojJXoxJEPMQFbGFWEQVC4HYZcAH5Tg1QBeAkOHjpA+NoXV+HkpXAE9RRyB4uDg19HzAZ8RTFbVJX4T5Y2VVVpReWp3i4FNdU5DgQGXMAAHIK2Fa5NQPa0MTtAd+HMwxy2fHtj2sqAQVCkwQD+ahxhwYLHUgZ0XWcjj3NdTzpFcbyIF8-zkUCsAQrC5NIogktbG1RDiNw4lsXuOxYtdO6oG8mo9N7bqsQ+Z9hyFfiUUEgFqJwZEjWmXSXtbciIE7FFkw+20vqGjUNIMuEEZgbVDqtXAbkYyC+3YI1ahwMBgCierl0xnUYFfYEf3YGBUUhczHH0psoeRVNeWsOAKiicEQH049jmxJG4cFIWDIxnr4ju9TrlZuTVwqZkwYqOBNXZqIwe0o9vJNYVpdoys1ylQFSeNvsQXbd9mTaU1zUh1E4HCGBJUYoA)

## More on assigning composite types of incorrect shapes

**NOTE**: This question is based on, and a continuation of the previous question.

!!! question

    ```ts
    type Game = {
      title: string;
      year: number;
    };

    const fakk2 = {
      title: "Heavy Metal: F.A.K.K. 2",
      platforms: ["linux", "mac", "windows"],
    }

    const hitman = {
      title: "Hitman: Codename 47",
      year: 2000,
      platforms: ["windows"],
    };

    const game1: Game = fakk2; // <1>

    const game2: Game = hitman; // <2>
    ```

    Contrary to 1 and 2 on the previous question, we do indeed get type errors on 1 and 2 in this question. Why?

    ??? "Answer"

        In this case, the objects `fakk2` and `hitman` are not explicitly type-annotated; here, we let type inference decide the types of `fakk2` and `hitman` objects:

        ```ts
        const fakk2: {
          title: string;
          platforms: string[];
        }

        const hitman: {
          title: string;
          year: number;
          platforms: string[];
        }
        ```

        Neither inferred type matches the type `Game`. It is different from the snippet from the previous question where the explicit type annotation of the (wrongly shaped) objects `tr2` and `tr3` caused further assignment of those objects to appear OK.

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYVACeABxwwA4gEMAtjKoBvYTBhRWUXKmgAndohGbxOeQdRgArouY4DIgL4jhvWADN5Aax8AmShh1TW1dHFQCAAkLADdxGABZHCh5OFQAMXoAQXoAaXz6GH8CABoNGEk4eShPEANFCFRCOHYbAA8ymAJFeWAuggB3dg4QQYgycudRDxgACx1esCCQrR09bqjF+TBUDA4cMCUZABYAdjKK80tUfwAGB-LNKpq6hqaYQmHOMYnSKbcs0QxwAjKgFMogt4-P5AZhYMDlP5wccggsoEs3EA)

## Can we really pass these as parameters?

!!! question

    ```ts
    const user = {
      id: 1,
      name: "John Doe",
    };

    const jedi = {
      name: "Ahsoka Tano",
      skills: ["The Force", "Lightsaber"],
    };

    type WithName = {
      name: string;
    };

    function getName(obj: WithName): string {
      return obj.name;
    }

    // <1>
    log(getName(user));

    // <2>
    log(getName(jedi));
    ```

    Neither `user` nor `jedi` are of the type `WithName`. Can we pass them to `getName()` in 1 and 2? Explain.

    ??? "Answer"

        Yes, we can. TypeScript is all about **structural typing**. If we say the parameter `obj` has to be of type `WithName`, and we pass objects that, among other things, has the property `name` with a value of type `string`, then the type checker is happy.

        TypeScript does type inference for both `user` and `jedi`. It sees they both have a property `name` with a string value. So, it knows that the inferred types of these two objects *structurally* match the type `WithName`, therefore, [Everything's Alright](https://youtu.be/Cdux5CnfPI) and [All Is Full of Love](https://youtu.be/u0cS1FaKPWY).

        When we use the type `WithName`, we are saying we care about the property `name`. It has to exist and be a string. Other excess properties are OK. Our function is defining a contract stating it requires anything that satisfies `name: string`. Both `user` `jedi` do satisfy that contract.

        - [TS Playground](https://www.typescriptlang.org/play?jsx=0#code/MYewdgzgLgBANiA5gLhgYXBEcCmBtAIgUQIF0YBeGUSbHAOmPoCMBLMAEwAoatcBKANwAoYb1gBXCDgBOlGAG9hMGKw6oAjABplMMAEMAtjlQEAUiAAWYGABEQOAjoC+IsZlgArHB1bylKgbGpgCCllgA1vowACr6YCBOuhARrHBwEKiEMZY4MABiIDLAjlowBAAyrIiWUBD6zLJkLm5QAJ4ADnkA6qxQlgByRnlUAXrDqNAy7IgirqIAZhJgwFCs4DCIOFBDxlwgzJ6ovf27OPyTUNNgiIq6MtsSMjYHnvRBOHOiAPTfMAA8GgAfMJiFwtjthlwpLJ+EIfn9-gAmEFgiFnLjeXxwty-YS-GDdPLAeIwDr6CAQGCADAIYTJqTB4hwaVjWAyoCAaeiofwGY0STCYCAFjAphJVk99HAYO0OjN6PjvkA)


## Excess and missing property checks

!!! question

    Explain excess and missing property checks? When do they occur? Equally important, whey do they not occur?

    ??? "Answer"

        Excess and missing property checks happen when we say a composite type (like an object) is of some type, but provide excess properties (extraneous properties not present in the type definition), or fail to provide required properties. These excess and missing property checks only happen when doing *direct assignment*. They do not occur when the assignment is not a direct assignment.

        ```ts
        type Xenomorph = {
          height: number;
          speed: number;
        };

        // Direct assignment. Excess/missing property checks kick in.
        const x1: Xenomorph = { height: 2.1 };

        // Not a “direct assignment”. No property checks here.
        const x2: Xenomorph = x1;

        declare function f(x: Xenomorph): void;

        // No property checks.
        f(x1);

        // No property checks.
        f(x2);

        // Direct assignment. Property checks kick in!
        // Missing ‘height’ property.
        f({ speed: 11 });

        // Direct assignment. Property checks kick in!
        // Extraneous ‘power’ property.
        f({ height: 2.1, speed: 11, power: 143 });
        ```

        A direct assignment is when we explicitly assign properties. A non-direct (or indirect?) assignment is when we re-assign something to a different reference.

        Take a look and play around with these:

        - [TS Playground from the code above](https://www.typescriptlang.org/play?jsx=0#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNlPUFAFQlpECEtUE2wAYUUGSzwAbQAieJMsgF0IAF4IKLS8cVzxYTNyAAoy1HSASgBuCJBPGABRAA85PHoIAAV0VA4CRABPCCTkPDkAa1ouiABZM3pakxGxifRp2fmllY0IABEzdAXY2C2TQgBbPCVVgDlFAFoyK5uIOtqP2uqmaEDEZgez1enVA0wmEAAGi9UI8MBxkMUIABvUAQVh4CFsbCEeCPYQEdp42gTPBkYmk8nodoAX3ankuwNi4MhL0Q4ggfQG9GAj02tG2EA4e0mMzkx2WEEWZiWEFq4kiqVivQAjNgkYQUWiMSUsfjCYhsAAmcTaiCsjrMD5ciCAHAIgX9uU9eYBcAn5H0l0oOsvltHx13VZS1lr1yNR6HRmJ1bKkcms1wgvHghFU9kIGbqvRjBrj6Oa2GkqDMZDZkH9UvGMtKIfVvAL2raDogdcDhzlC2WLYLlo77N+qjB9y9Sn5owbQab-dDSpVtQAhJ4NltCDtABgE83NgEwCANz6aD03UvC07Da23MkeQDkeydQvm7E-BxeK5WLVWEdeQPpEHQUg8FQeBQx3DhUBcAgj3rfZT1AVtTX3EwiQga1tQAGggC8rwgG8cKgmCsAIgAWABmO0OyAA)
        - [TS Playground with another Xenomorph example 😅 and some extra notes](https://www.typescriptlang.org/play?jsx=0#code/PTBQIAkIgIIQQVwC4AsD2AnAXBAYgU3QDsBDQgE1QgCFiBnW1cYaCZRRAB1sxADMCS5VACM6DAHRk8AN2ABjVIUTE5iMJBhtO3PgNIVR9VOIDmAS0QAbYsPFnUwKdLQB3RA6YstXHsBf-JGVd3QNlPUFAFQlpECEtUE2wAYUUGSzwAbQAieJMsgF0IAF4IKLS8cVzxYTNyAAoy1HSASgBuCJBPGABRAA85PHoIAAV0VA4CRABPCCTkPDkAa1ouiABZM3pakxGxifRp2fmllY0IABEzdAXY2C2TQgBbPCVVgDlFAFoyK5uIOtqP2uqmaEDEZgez1enVA0wmEAAGi9UI8MBxkMUIABvUAQVh4CFsbCEeCPYQEdp42gTPBkYmk8nodoAX3aTE8AAkCHgIC4ecRrhAgTdLDNwQ9thA8P1BrQIBw9pMzIMADS85BmOTITwuMyWSwQRDoCEmAhSmVDBXjSYzLULZbidllWLESzKwjYJGEFFojElHF4+aExDYABM4gAjCrcRBqXhadgI1GYxxUHysBAIwAWADM0dZHXUzFg5Hxgr5YMFj02tElVv2iGVtDVLg1Wt5eoNroYniNJrN9ZtpWOy3+1a2hB2g4OtpHctqnlqho1crkdDwzUdnWdEAAjvB4x7EcjUeh0ZiA-jg9gs+IAKz5tmdSAAFRXEF48EIqnshENxEWQYwQgaRXQPCBUF4ZceThHlAAwCL0fTPZBAEwCLcwE-b9G0UeVjSURC6ixK8TDYNU41pCBmU9E9fWabBpFQMwyGxGNcjqAADRCIFqXhUEwAAdQggxIkMIAAEixYS2GZQTyLpcSsTk5l2LaUBmULTluRbflBQ4cFJ2A0DLHA1tNQxFw6FwmR7HgWhRU8ORrmIRBaXECA302bi5W9F0hV+VQwXuJ4XkQNV9CFVAgLeAB5F9e2NExTXQc0BktRUZ2He1aHQ0AFVqRACNdd1VPZSBYEsBh5X0nZiBAsCYOQZzeUshVrNQWzRVKJyXLINy4P3Q8UM8Rq5XSNLrQOJtl1Ic0JlUWk1WEJBcImw47ROTwKAgGKXwgRZNUWbi-3mQUCRQAgcry-DkTqAaXhK0rizkVK5WnNa50rGCEqSijWxeCLJWFVRPHFYKlEW5afPVf7rlsyVata6QbLs21utpTw6lB2lQSMg8crK2MzGraxkpQSVGo4CZog7FAIHHWsDLe2csvx5gAEkoNqzCfxw5RALlWrcYapqRrpjAeTeqaUFITxpTmnq1XOmZHmIGZyQgAArWzYghb1rl66hlr+v9BfqrzPHput0sbVVptiXV9TiMxAM6tdbIlsZhHSR4BcQTx0C-RtnjcqhugAdVgAAlboIKg2hVfhiBzGkf6ha82PYxRGCpgmHV5j-Cx06hpz9RmSC7cNHOKnZUAgA)
