# Intro

Here are quizzes (questions and answers, really) about useful or tricky parts of TypeScript. Some questions may also cover the relation to JavaScript (we may say something is of some type, but its value may actually be of some other type, think about type assertions, for example).

## Identifier names

One important note is that **some times we intentionally use bad identifiers** (names of variables, functions, types, interfaces, whatever) **on purpose**, so that we are forced carefully think in terms of types and code, deeply contemplating their implications. Good names, like `add1` or `filter` give away what the code is doing (of course this is what we do for production code), but may defeat the purpose of a question or exercise.

Take a look at this piece of Haskell code:

```hs
h :: Integer -> Integer
h 0 = 1
h n = n * h (n - 1)
```

What does the function `h` do? What if I write it this way?

??? example "Same code with better name"

    ```hs
    factorial :: Integer -> Integer
    factorial 0 = 1
    factorial n = n * factorial (n - 1)
    ```

Let's try another one:

```hs
f :: (Eq a, Num a) => a -> a
f n = go n 0
  where go n acc
          | n == 0 = acc
          | otherwise = go (n - 1) (acc + n)
```

What does the function `f` do? Let's add a good name.

??? example "Again, with a better name"

    ```hs
    sumUpTo :: (Eq a, Num a) => a -> a
    sumUpTo n = go n 0
      where go n acc
              | n == 0 = acc
              | otherwise = go (n - 1) (acc + n)
    ```

If we just see a nice name, it primes our brain to think like “Yeah, I understand this”, but some times, **we don't understand**. Again, for real, production code, spend whatever time it takes to come up with the best possible names. But when studying, depending on the purpose of the given question, exercise or situation, occasionally the good naming of identifiers defeats the whole goal.