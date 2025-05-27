---
description: Exercism Bird Watcher Clojure notes and solutions.
---

# Bird Watcher

## Clojure 1

- [Bird Watch Clojure learning exercism in Exercism](https://exercism.org/tracks/clojure/exercises/bird-watcher).

### Solution

```{code} clojure
(def last-week
  "last-week :: Vector<Integer>

  Returns the last week's count of bird visits per day. The order of
  the elements are from the oldest to the newest. For example, the
  count for the first day is the first element and today's (the most
  recent day) is the last element."
  [0 2 5 3 7 8 4])

(defn today [birds]
  "today :: Integer

  Returns today's count of birds."
  (peek birds))

(defn inc-bird [birds]
  "inc-bird :: Vector<Integer> -> Vector<Integer>

  Returns a new collection with today's count incremented by one."
  (update birds (- (count birds) 1) inc))

(defn day-without-birds? [birds]
  "day-without-birds? :: [Integer] -> Boolean

  Returns true if there is a day without visits; false otherwise."
  (not (every? pos? birds)))

(defn n-days-count [birds n]
  "n-days-count :: (Vector<Integer>, Integer) -> Integer

  Returns the count of visits fir the first n days."
  (reduce + 0 (take n birds)))

(defn busy-days [birds]
  "busy-days :: Vector<Integer> -> Integer

  Returns the count of days that had five or more visits."
  (count (filter #(>= % 5) birds)))

(defn odd-week? [birds]
  "odd-week? :: Vector<Integer> -> Boolean

  Returns true if the odd pattern of 1's and 0's occur for the entire week."
  (cond
    (= (count birds) 1) true
    (false? (every? #(or (= % 0) (= % 1)) (take 2 birds))) false
    (not= (first birds) (second birds)) (odd-week? (rest birds))
    :else false))
```

#### odd week?

An odd week is one where we have alternating 1's and 0 counts.

This solution recurses through the input vector and checks whether the first and second elements are indeed only 1 and 0, and also that the first element is not equal to the second element (that is, if the first element is 0, the other must be 1 and vice-versa).

If those two conditions are satisfied, recurse again with the rest of the vector.

At some point, and if the two conditions have always been satisfied, there will be a a single remaining element on the vector.
This is the base case where we return `true`.

All other cases mean some condition was not not satisfied so we return `false`.

## Clojure

### last-week

```clojure
(def last-week
  "last-week :: [Integer]"
  [0 2 5 3 7 8 4])
```

Simply hard-codes and returns a vector of seven elements.

### today

```clojure
(defn today [birds]
  "today :: Victor<Integer>"
  (peek birds))
```

Today's count is the last element of the vector, and `peek` returns the last element of a vector.

### inc-bird

`inc-bird` is supposed to increment today's bird visit count.

```clojure
(defn inc-bird [birds]
  "inc-bird :: Vector<Integer> -> Vector<Integer>"
  (update birds (- (count birds) 1) inc))
```

Here we use `update` to update the last element of the vector `birds`.
The last element is at `(count birds)` minus 1, so we can do `(dec (count birds))` to get the index of the last element, and then apply `inc` on that element.

```text
user=> (def birds [1 0 3 5 7 4 2])
#'user/birds
user=> birds
[1 0 3 5 7 4 2]
user=> (count birds)
7
user=> (dec (count birds))
6
user=> (update birds (dec (count birds)) inc)
[1 0 3 5 7 4 3]
```

The last element was 2, and it got incremented to 3.

Note that these two expressions do the same thing:

```text
(- (count birds) 1)
(dec (count birds))
```

### day-without-birds?

Return `true` if there was a day with 0 visits; `false` otherwise.

```clojure
(defn day-without-birds? [birds]
  "day-without-birds? :: Vector<Integer> -> Boolean"
  (not (every? pos? birds)))
```

Here we use `every?` and `pos?` to check if every element in `birds` is a positive number.
Zero is _not_ positive:

```text
user=> (pos? 0)
false
```

So, if every value is positive, the `every?` expression returns `true`, which is why we use `not` to say that there was no day without birds.

### n-days-count

```clojure
(defn n-days-count [birds n]
  "n-days-count :: (Vector<Integer>, Integer) -> Integer"
  (reduce + 0 (take n birds)))
```

Take the first `n` elements from `birds` and `reduce` to a sum of the values with `+` and the initial 0 for the accumulator.

An alternative to reduce would be `apply`:

```clojure
(apply + (take n birds))
```

Note that `+` defaults to zero (as zero is the identity of addition), so the expression above is safe:

```text
user=> (+)
0
user=> (apply + [])
0
user=> (apply + [1 2 3])
6
user=> (take 2 [1 2 3])
(1 2)
user=> (apply + (take 2 [1 2 3]))
3
```

### busy-days

```clojure
(defn busy-days [birds]
  "busy-days :: Vector<Integer> -> Integer"
  (count (filter #(>= % 5) birds)))
```

For this case we filter only counts which are equal to or greater than five, and then count the resulting vector.

```text
user=> (filter #(>= % 5) [1 9 3 7 4])
(9 7)
user=> (count (filter #(>= % 5) [1 9 3 7 4]))
2
```

### odd-week?

```clojure
(defn odd-week? [birds]
  "odd-week? :: Vector<Integer> -> Boolean"
  (cond
    (= (count birds) 1) true
    (false? (every? #(or (= % 0) (= % 1)) (take 2 birds))) false
    (not= (first birds) (second birds)) (odd-week? (rest birds))
    :else false))
```

An odd week is one where we have alternating 1's and 0 counts.

This solution recurs through the input vector and checks whether the first and second elements are indeed only 1 and 0, and also that the first element is not equal to the second element (that is, if the first element is 0, the other must be 1 and vice-versa).

If those two conditions are satisfied, recur again with the rest of the vector.

At some point, and if the two conditions have always been satisfied, there will be a single remaining element on the vector.
This is the base case where we return `true`.

All other cases mean some condition was not not satisfied so we return `false`.

### odd-week? with partial application

I have some other solutions on Exercism where they use `partial`.
It seems to work because the “odd week” is supposed to be precisely `[1 0 1 0 1 0 1]`.
It seems it would not possibly be `[0 1 0 1 0 1 0]`.

So first imagine we write this function:

```clojure
(defn odd-week? [birds]
  "odd-week? :: Vector<Integer> -> Boolean"
  (= [1 0 1 0 1 0 1] birds))
```

Note that we hard-code the vector that represents an odd week.

But by using `partial`, we can partially apply `=` to `[1 0 1 0 1 0 1]`, which returns a function that takes the final parameter.

```clojure
(defn odd-week?
  "odd-week? :: Vector<Integer> -> Boolean"
  (partial = [1 0 1 0 1 0 1])
```

```text
user=> (odd-week? [1 0 1 0 1 0])
false
user=> (odd-week? [1 0 1 0 1 0 1])
true
```
