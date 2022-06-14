# Folding Lists - Chapter 10


<!-- vim-markdown-toc GitLab -->

* [Exercises: Understanding folds](#exercises-understanding-folds)
  * [01](#01)
  * [02](#02)
  * [03](#03)
  * [04](#04)
  * [05](#05)
    * [a](#a)
    * [b](#b)
    * [c](#c)
    * [d](#d)
    * [e](#e)
    * [f](#f)
    * [g](#g)
    * [h](#h)
    * [i](#i)
* [Exercises: Database processing](#exercises-database-processing)
* [Scans exercises](#scans-exercises)
* [Warm-up and review](#warm-up-and-review)
  * [01](#01-1)
  * [02](#02-1)
  * [03](#03-1)
  * [Rewriting functions using folds](#rewriting-functions-using-folds)
  * [The End](#the-end)

<!-- vim-markdown-toc -->

## Exercises: Understanding folds

Page 365.

### 01

B and C are correct. Both `foldr` and `foldl` will do because `(*)` is associative. Flipping `(*)` doesn’t change the results, again, because `(*)` is associative.



### 02

```haskell
foldl *' 1 [1, 2, 3]

foldl (flip (*)) 1 [1, 2, 3]

foldl (flip (*)) (flip (*) 1 1) [2, 3]

foldl (flip (*)) (flip (*) 1 1) [2, 3]

foldl (flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) [3]

foldl (flip (*)) ((flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) 3) []

((flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) 3)

((flip (*)) ((flip (*)) 1 2) 3)

((flip (*)) 2 3

6
```

Another approach:

```
foldl :: (acc -> x -> acc) -> acc -> [x] -> acc
foldl f z []     = z
foldl f z (x:xs) = foldl f (f z x) xs

f = (*)

foldl (flip f) ((flip f) 1 1) [2, 3]
acc = 1, (1 * 1)

foldl (flip f) ((flip f) 1 2) [3]
acc = 2, (1 * 2)

foldl (flip f) ((flip f) 2 3) []
acc = 6, (2 * 3)

Reaches base case, returns ‘z’, our ‘acc’.
```

### 03

C is correct.

### 04

A is correct.

### 05

#### a

Missing the “zero”, default, accumulator parameter.

Correct:

```ghci
λ> foldr (++) [] ["woot", "WOOT", "woot"]
"wootWOOTwoot"
```

#### b

Need a list of strings, not a single string.

Correct:

```ghci
λ> foldr max [] ["fear", "is", "little", "death"]
"little"
```

#### c

There is no “and” function.

Correct:

```haskell
foldr (&&) True [False, True]
```

#### d

It always returns `True`, which is incorrect. We must make the zero produce `False` instead.

```haskell
folder (||) False [False, True]
```

#### e

```ghci
λ> foldr ((++) . show) "" [1..5]
"12345"
```

Or flipping `((++) . show)`, although the result is in reverse order:

```ghci
λ> foldl (flip ((++) . show)) "" [1, 2, 3]
"321"
```

‘foldr’ applies ‘f x’. So, we apply ‘((++) . show)’ to ‘1’ first, not to ‘""’ first.

‘foldl’ applies ‘f’ to the zero/acc first, and the current ‘x’ (1, 2, 3) do not get converted to string, and are attempted to be concatenated to the ‘acc’ as a number, which is incorrect and causes errors.

#### f

Zero has the type ‘Char’, and the list is of type ‘Num’. The type of zero and the elements of the list must be the same. Possible solutions, depending on the result sought:

```ghci
λ> foldr (flip const) 'a' [1, 2, 3]
'a'

λ> foldl const 'a' [1, 2, 3]
'a'

λ> foldr const 'a' "bcd"
'b'

λ> foldr const 'a' ['b', 'c', 'd']
'b'

λ> foldr const 0 [1, 2, 3]
1
```

#### g

```ghci
λ> foldl const 0 "tacos"
0

λ> foldr (flip const) 0 "tacos"
0

λ> foldl const "" "tacos"
```

#### h

```ghci
λ> foldr (flip const) 0 "burritos"
0

λ> foldl const 0 "burritos"
0
```

#### i

```ghci
λ> foldr (flip const) 'z' [1..5]
'z'

λ> foldl const 'z' [1..5]
'z'
```

## Exercises: Database processing

Page 371.

```haskell
{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.Time

data DBItem = DbStr String
            | DbNum Integer
            | DbDate UTCTime
            deriving (Eq, Ord, Show)

theDb :: [DBItem]
theDb =
  [ DbDate (UTCTime (fromGregorian 1911 5 1)
                    (secondsToDiffTime 34123))
  , DbNum 2001
  , DbStr "Use the force!"
  , DbDate (UTCTime (fromGregorian 1921 5 1)
                    (secondsToDiffTime 34123))
  ]

otherDb = theDb ++
  [ DbNum 1
  , DbNum 10
  ]

isDbDate (DbDate d) = True
isDbDate _          = False

filterDbDate :: [DBItem] -> [UTCTime]
filterDbDate = foldr f []
  where f (DbDate d) acc = d : acc
        f _          acc = acc

filterDbNum :: [DBItem] -> [Integer]
filterDbNum = foldr f []
  where f (DbNum n) acc = n : acc
        f _         acc = acc

mostRecentDate :: [DBItem] -> UTCTime
mostRecentDate = minimum . filterDbDate

sumNums :: [DBItem] -> Integer
sumNums = sum . filterDbNum

avgNums :: (Fractional a) => [DBItem] -> a
avgNums items = (/) total len
  where total = fromIntegral $ sumNums items
        len   = fromIntegral $ length $ filterDbNum items

countDate :: [DBItem] -> Int
countDate = length . filterDbDate
```

## Scans exercises

Page 378.

```haskell
myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f q ls =
  q : (case ls of
         [] -> []
         x:xs -> myScanl f (f q x) xs)


res1 = myScanl (+) 1 [1..3]


fib :: Word -> Word
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)


fibs :: [Word]
fibs = 1 : myScanl (+) 1 fibs


fibsN :: Int -> Word
fibsN n = fibs !! n


fibs20first :: [Word]
fibs20first = take 20 fibs


fibsLT100 :: [Word]
fibsLT100 = takeWhile (< 100) fibs


fact :: Word -> Word
fact 0 = 1
fact n = n * fact (n - 1)


facts :: [Word]
facts = myScanl (*) 1 [1..]

factN :: Int -> Word
factN n = facts !! n
```



## Warm-up and review

Page 378.

### 01

```haskell
stops = "pbtdkg"
vowels = "aeiou"

all :: [Char] -> [Char] -> [(Char, Char, Char)]
all ss vs = [(s1, v, s2) | s1 <- ss, v <- vs, s2 <- ss]

startWithP :: [Char] -> [Char] -> [(Char, Char, Char)]
startWithP ss vs =
  [(s1, v, s2) | s1 <- [(head ss)], v <- vs, s2 <- ss]


nouns = ["jedi", "padawan", "kitten"]
verbs = ["fight", "run", "meow"]

allnv :: [[Char]] -> [[Char]] -> [([Char], [Char])]
allnv ns vs = [(n, v) | n <- ns, v <- vs]

```

### 02

Finds the average of the length of the words in the input string.

### 03

```haskell
-- Using ‘where’.
avgWordLen :: [Char] -> Double
avgWordLen str = (/) numWordChars lenWords
  where
    numWordChars = fromIntegral $ sum (map length (words str))
    lenWords     = fromIntegral $ length (words str)

-- Using ‘let’.
avgWLen :: [Char] -> Double
avgWLen str =
  let
    numWordChars = fromIntegral $ sum (map length (words str))
    lenWords     = fromIntegral $ length (words str)
  in
    (/) numWordChars lenWords
```

### Rewriting functions using folds

```haskell
-- Direct recursion, not using ‘&&’.
myAnd' :: [Bool] -> Bool
myAnd' [] = True
myAnd' (x:xs) =
  if x == False
  then False
  else myAnd xs

-- Direct recursion using ‘&&’.
myAnd'' :: [Bool] -> Bool
myAnd'' [] = True
myAnd'' (x:xs) = x && myAnd' xs

-- Fold, not point-free.
myAnd''' :: [Bool] -> Bool
myAnd''' = foldr f True
  where f = (\x acc ->
               if x == False
               then False
               else acc)

-- Both ‘myAnd’ and the folding function are point-free.
myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True


-- Direct recursion not using ‘||’.
myOr' :: [Bool] -> Bool
myOr' [] = False
myOr' (x:xs) =
  if x == True
  then True
  else myOr' xs

-- Direct recursion using ‘||’.
myOr'' :: [Bool] -> Bool
myOr'' [] = False
myOr'' (x:xs) = x || myOr'' xs

-- Fold, not point-free.
myOr''' :: [Bool] -> Bool
myOr''' = foldr f False
  where f = (\x acc ->
               if x == True
               then True
               else acc)

-- Both ‘myOr’ and the folding function are point-free.
myOr :: [Bool] -> Bool
myOr = foldr (||) False


-- Direct recursion not using ‘||’.
myAny' :: (a -> Bool) -> [a] -> Bool
myAny' _ []     = False
myAny' f (x:xs) =
  if f x == True
  then True
  else myAny' f xs

-- Direct recursion using ‘||’.
myAny'' :: (a -> Bool) -> [a] -> Bool
myAny'' _ []     = False
myAny'' f (x:xs) = f x || myAny' f xs

-- Fold, not point-free.
myAny''' :: (a -> Bool) -> [a] -> Bool
myAny''' f = foldr g False
  where g = (\x acc ->
               if f x == True
               then True
               else acc)


myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (||) False . map f



myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e xs = myAny (== e) xs


myEl :: Eq a => a -> [a] -> Bool
myEl e = foldr (||) False . map (== e)

myEl' :: Eq a => a -> [a] -> Bool
myEl' e = foldr (\x acc -> acc || x == e) False


myRev :: [a] -> [a]
myRev = foldr (\x acc -> acc ++ [x]) []

myRev' :: [a] -> [a]
myRev' = foldl (flip (:)) []


myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x acc -> f x : acc) []


myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x acc ->
                      case f x of
                        True -> x : acc
                        False -> acc) []

squinsh :: [[a]] -> [a]
squinsh = foldr (\xs acc -> xs ++ acc) []


-- Why ‘(a -> [b])’ instead of ‘(a -> b)’?
squinshMap :: (a -> [b]) -> [a] -> [b]
squinshMap f = foldr (\x acc -> f x ++ acc) []
--
-- λ> squinshMap (flip (:) []) [1..3]
-- [1,2,3]
--

squinshMap' :: (a -> [b]) -> [a] -> [b]
squinshMap' f = foldr ((++) . f) []

squinshAgain :: [[a]] -> [a]
squinshAgain = squinshMap id


myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy p xs = foldr (\x acc ->
                          if p x acc == GT
                          then x
                          else acc) (last xs) xs


myMininumBy :: (a -> a -> Ordering) -> [a] -> a
myMininumBy p xs = foldr (\x acc ->
                            if p x acc == LT
                            then x
                            else acc) (last xs) xs
```







### The End
