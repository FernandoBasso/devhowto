---
description: Exercism Bird Watcher Clojure notes and solutions.
---

# Bird Watcher

## Clojure

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
