# Recursion - Chapter 08

<!-- vim-markdown-toc GitLab -->

* [Intermission: Exercise](#intermission-exercise)
* [Chapter Exercises](#chapter-exercises)
  * [Review of types](#review-of-types)
    * [01](#01)
    * [02](#02)
    * [03](#03)
    * [04](#04)
  * [Reviewing currying](#reviewing-currying)
    * [01](#01-1)
    * [02](#02-1)
    * [03](#03-1)
    * [04](#04-1)
    * [05](#05)
    * [06](#06)
  * [Recursion](#recursion)
    * [01](#01-2)
    * [02](#02-2)
    * [03](#03-2)
  * [Fixing divBy](#fixing-divby)
  * [wordNumber](#wordnumber)

<!-- vim-markdown-toc -->

## Intermission: Exercise

Page 282.

```haskell
applyTimes :: (Eq a, Num a) => a -> (b -> b) -> b -> b
applyTimes t f acc = f . applyTimes (t - 1) f $ acc
applyTimes 5 (+1) 5
```

Evaluation:

```
applyTimes 5    (+ 1)     5
        (5 - 1)        (5 + 1)
           4              6

applyTimes 4    (+ 1)     6
        (4 - 1)        (6 + 1)
           3              7

applyTimes 3    (+ 1)     7
        (3 - 1)        (7 + 1)
           2              8

applyTimes 2    (+ 1)     8
        (2 - 1)        (8 + 1)
           1              9

applyTimes 1    (+ 1)     9
        (1 - 1)        (9 + 1)
           0              10

applyTimes 0 (+ 1) 10
                   10
```

mvaldesdeleon has a [different solution](https://github.com/mvaldesdeleon/haskell-book/blob/master/ch08/exercises.md).

⊥, or *bottom*, is a term used in Haskell to refer to computations that do not successfully result in a value.

Examples of bottom:

* error
* infinite loops
* partial function

## Chapter Exercises

Page 293.

### Review of types

#### 01

D is correct. `[[True, False], [True, True], [False, True]]`is a list of lists of `Bool`, so, the type is `[[Bool]]`.

#### 02

B is correct. `[[True, False], [True, True], [False, True]]`is a list of lists of `Bool`, so, the type is `[[Bool]]`, and `[[3 == 3], [6 > 5], [3 < 4]]` expands to `[[True], [False], [True]]`, which is a list of lists of `Bool`. Remember that the number of elements in lists is not part of the type (contraty to tuples).

#### 03

D is correct. `(++)` concatentates lists, and lists must have its constituents be of the same type.

#### 04

B is correct. Yet, A is also valid. It partially applies the function to a single argument, which returns a function awaiting the remaining argument. Same with D. C is not correct though because both lists must have constituents of the same type.

### Reviewing currying

#### 01

```
λ> appedCatty "woohoo!"
"woops mrow woohoo!"
```

#### 02

```
λ> frappe "1"
"1 mrow haha"
```

#### 03

```
λ> frappe (appedCatty "2") -- woops mrow 2 haha
"woops mrow 2 mrow haha"
```

#### 04

```
λ> appedCatty (frappe "blue")
"woops mrow blue mrow haha"
```

#### 05

```
λ> :{
*Main| cattyConny (frappe "pink")
*Main|                 (cattyConny "green"
*Main|                   (appedCatty "blue"))
*Main| :}
"pink mrow haha mrow green mrow woops mrow blue"
```

#### 06

```
λ> cattyConny (flippy "Pugs" "are") "awesome"
"are mrow Pugs mrow awesome"
```

### Recursion

#### 01

Will do `divby 7 2` instead. 15 is just too much trouble :|

```
divby   7     2
go      7     2     0
go      5     2     1
go      3     2     2
go      1     2     3
go      (3, 1)
```

#### 02

Using the “go” idiom. `go` is recursive.

```haskell
sumUpTo :: (Eq a, Num a) => a -> a
sumUpTo n = go n 0
   where go n acc
           | n == 0 = acc
           | otherwise = go (n - 1) (acc + n)
```

Using pattern matching. Also recursive.

```
sumUpTo :: Word -> Word
sumUpTo 0 = 0
sumUpTo n = (+) n $ sumUpTo (n - 1)
```

#### 03

```
--
-- Working with natural numbers because handling negative multiplier is
-- trickier than I am willing to deal with at this point in the book. 😅
--
mult :: Word -> Word -> Word
mult multiplicand multiplier = go multiplier 0
  where
    go multiplier' acc
      | multiplier' == 0 = acc
      | otherwise = go (multiplier' - 1) (acc + multiplicand)
```

### Fixing divBy

This solution I found on some repo on the web. Don't remember where from exactly...

```hs
data Div =
    Res Integer
  | ByZero
  deriving Show

negFst :: (Div, Div) -> (Div, Div)
negFst (Res x, Res y) = (Res (- x), Res y)

negSnd :: (Div, Div) -> (Div, Div)
negSnd (Res x, Res y) = (Res x, Res (- y))

--
-- Do the subtraction with the absolute values, and then negate the
-- tuple constituents according to the division rules.
--

divBy :: Integer -> Integer -> (Div, Div)
divBy num denom
  | denom == 0 = (ByZero, ByZero)
  | num < 0 && denom < 0 = negSnd $ go (-num) (-denom) 0
  | num < 0 && denom > 0 = negFst . negSnd $ go (-num) denom 0
  | num > 0 && denom < 0 = negFst $ go num (-denom) 0
  | denom < 0 = negSnd $ go num (-denom) 0
  | otherwise = go num denom 0
  where go n d acc
          | n < d = (Res acc, Res n)
          | otherwise = go (n - d) d (acc + 1)
```

My solution 1, not handling division by zero yet.

```hs
--
-- `divBy` is my implementation of `quotRem` in terms of subtraction.
--
-- Perform the subtraction on the absolute values and then negate the
-- tuple constituents according to the division rules.
--
divBy :: Numerator -> Denominator -> (Quotient, Remainder)
divBy num denom = signify $ go (abs num) (abs denom) 0
  where
    go :: Numerator -> Denominator -> Quotient -> (Quotient, Remainder)
    go n d count
      | n < d     = (count, n)
      | otherwise = go (n - d) d (count + 1)
    signify :: (Quotient, Remainder) -> (Quotient, Remainder)
    signify (q, r)
      | num < 0 && denom < 0 = (q, (- r))
      | num < 0 = ((- q), (- r))
      | denom < 0 = ((- q), r)
      | otherwise = (q, r)

--
-- Very tiresome testing this by hand, comparing with the results of
-- `quotRem`, then making sure each new guard did not introduce incorrect
-- results for other parts of the program, etc. Unit tests would save a lot of
-- time testing this, besides being a much more reliable way of asserting the
-- program correctness, reducing the likelihood of human error while manually
-- testing.
--
```

Using some (hopefully) better types and handling of problems, including returning a specific data constructor when the denominator is zero (division by zero).

```hs
{-# LANGUAGE NoMonomorphismRestriction #-}

type Numerator = Integer
type Denominator = Integer
type Quotient = Integer
type Remainder = Integer

data Division =
    Result (Quotient, Remainder)
  | DivisionByZero
  deriving Show

--
-- `divBy` is my implementation of `quotRem` in terms of subtraction.
--
-- Perform the subtraction on the absolute values and then negate the
-- tuple constituents according to the division rules.
--
divBy :: Numerator -> Denominator -> Division
divBy _   0     = DivisionByZero
divBy num denom = signify $ go (abs num) (abs denom) 0
  where
    go :: Numerator -> Denominator -> Quotient -> Division
    go n d count
      | d == 0    = DivisionByZero
      | n < d     = Result (count, n)
      | otherwise = go (n - d) d (count + 1)
    signify :: Division -> Division
    signify (Result (q, r))
      | num < 0 && denom < 0 = Result (q, (- r))
      | num < 0              = Result ((- q), (- r))
      | denom < 0            = Result ((- q), r)
      | otherwise            = Result (q, r)
--
-- λ> divBy (-7) 2
-- Result (-3,-1)
--
-- λ> divBy 7 (-2)
-- Result (-3,1)
--
-- λ> divBy 7 0
-- DivisionByZero
--

--
-- Very tiresome testing this by hand, comparing with the results of
-- `quotRem`, then making sure each new guard did not introduce incorrect
-- results for other parts of the program, etc. Unit tests would save a lot of
-- time testing this, besides being a much more reliable way of asserting the
-- program correctness, reducing the likelihood of human error while manually
-- testing.
--
```

### wordNumber

A solution from my previous study of the book:

```haskell
module WordNumber where

import Data.List (intersperse)

snums :: [[Char]]
snums = [
  "zero",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine"
  ]

--
-- A list of [(1, "one"), ... (9, "nine")].
--
tups :: [(Int, [Char])]
tups = zip [(0 :: Int) .. 9] snums

--
-- Turns a digit into a word, like 1 -> "one" or 7 -> "seven".
--
digitToWord :: Int -> String
digitToWord n = word
  where word =
          snd . head $ filter (\ tup -> fst tup == n) tups

--
-- Turns a number into a list of individual digits. Ex:
-- 1984 -> [1, 9, 8, 4].
--
digits :: Int -> [Int]
digits n = go n []
  where
    go x acc
      | x < 10 = [x] ++ acc
      | otherwise = go (div x 10) ([mod x 10] ++ acc)

--
-- Makes use of the previously defined functions to wordify a number.
--
wordNumber :: Int -> String
wordNumber n =
  concat . intersperse "-" $ map digitToWord $ digits n
--
-- λ> wordNumber 0
-- "zero"
-- λ> wordNumber 1984
-- "one-nine-eight-four"
--
```

My new solution (not better). I just did not research the web this time.

```hs
{-# LANGUAGE NoMonomorphismRestriction #-}

module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord 0 = "zero"
digitToWord 1 = "one"
digitToWord 2 = "two"
digitToWord 3 = "three"
digitToWord 4 = "four"
digitToWord 5 = "five"
digitToWord 6 = "six"
digitToWord 7 = "seven"
digitToWord 8 = "eight"
digitToWord 9 = "nine"
digitToWord _ = "unknown input"

getOnesPlace :: Int -> Int
getOnesPlace x = mod x 10

dropOnesPlace :: Int -> Int
dropOnesPlace x = div x 10

--
-- `dropOnesPlace x` causes the next iteration of the recursion to run in a
-- smaller input, tending toward something that is less than 10.
--
-- `(:) (getOnesPlace x) acc` cons the right-most digit in the number into the
-- accumulator.
--
digits :: Int -> [Int]
digits n = go n []
  where go x acc
          | x < 10    = (:) x acc
          | otherwise = go (dropOnesPlace x) ((:) (getOnesPlace x) acc)

wordNumber :: Int -> String
wordNumber n = concat . intersperse "-" . map digitToWord $ digits n
--
-- λ> wordNumber 1984
-- "one-nine-eight-four"
--
```
