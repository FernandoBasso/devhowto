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

    Explain what TypeScript type checker thinks about our `tr1`, `tr2` and `tr3` objects?

    ??? "Answer"

    `tr1` is fine. It completely matches the type `Game`.

    `tr2` is *missing a property*. The type checker thinks, “why would this developer” say it is of this type and fail to provide the expected properties to match the type? It is likely an unintentional error on their part and I will complain about it.”

    `tr3` has one *excess property*. The type checker thinks, “why would this developer” say it is of this type and and then provide more than expected properties to match the type? Why did they not create the type with that extra property in the first place? It is likely an unintentional error on their part and I will complain about it.”
