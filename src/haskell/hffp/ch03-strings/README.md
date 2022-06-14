# Strings - Chapter 3


<!-- vim-markdown-toc GitLab -->

* [Exercises: Scope](#exercises-scope)
  * [01](#01)
  * [02](#02)
  * [03](#03)
  * [04](#04)
* [Exercises: Syntax Errors](#exercises-syntax-errors)
  * [01](#01-1)
  * [02](#02-1)
  * [03](#03-1)
* [Chapter Exercises](#chapter-exercises)
  * [Reading syntax](#reading-syntax)
    * [01](#01-2)
    * [02](#02-2)
  * [Building functions](#building-functions)
    * [01](#01-3)
    * [02](#02-3)
    * [03](#03-2)
    * [04](#04-1)
    * [05](#05)
    * [06](#06)

<!-- vim-markdown-toc -->

## Exercises: Scope

Page 74.

### 01

Yes, `y` is in scope for `z`.

### 02

No, `h` is not in scope for `g`.

### 03

No, `d` is not in scope.

Note that `pi` is in scope from Prelude.

### 04

Yep, all fine and dandy.

## Exercises: Syntax Errors

Page 78.

### 01

Need to either place `++` in infix position or use parentheses around it in prefix position:

```ghci
λ> [1, 2, 3] ++ [4, 5, 6]
[1,2,3,4,5,6]
λ> (++) [1, 2, 3] [4, 5, 6]
[1,2,3,4,5,6]
```

### 02

Single quotes are for `Char`.  Replace the single quotes with double quotes or enclose each single quoted character inside a list separated by commas, like `['a', 'b', 'c']`, etc.

### 03

This one is fine.

## Chapter Exercises

Page 82.

### Reading syntax

#### 01

A is OK.

B needs to be `(++)` instead of `++` because it is in prefix position.

C is OK.

D is missing the closing double quote.

E should be `"hello" !! 4`.

F is OK.

G should take the 4 out of the string, as the first argument to `take`.

H is OK.

#### 02

- A matches D.
- B matches C.
- C matches E.
- D matches A.
- E matches B.

### Building functions

#### 01

Page 83.

* A: `"Curry is awesome" ++ "!"`
* B: `"Curry is awesome!" !! 4`
* C: `drop 9 "Curry is awesome!"`

#### 02

B:

```haskell
myAppend :: [Char] -> [Char]
myAppend s = (++) "Cury is awesome" s
--
-- λ> myAppend "!"
-- "Cury is awesome!
--
```

B:

```haskell
getCharAtIndex :: Int -> Char
getCharAtIndex idx = (!!) "Curry is awesome!" idx
--
-- λ> getCharAtIndex 4
-- 'y'
--
```

NOTE: Since `(!!)` takes an `Int`, and our function uses `(!!)`, our index parameter must also be an `Int`.

C:

```haskell
strAfterIndex :: Int -> [Char]
strAfterIndex idx = drop idx "Curry is awesome!"
--
-- λ> strAfterIndex 9
-- "awesome!"
--
```

#### 03

Page 84.

```haskell
thirdLetter :: String -> Char
thirdLetter s = (!!) s 2
--
-- λ> thirdLetter "Tomb Raider - The Last Revelation"
-- 'm'
--
```

#### 04

Page 85.

```haskell
letterIndex :: Int -> Char
letterIndex idx = (!!) "Currying is awesome!" idx
--
-- λ> letterIndex 7
-- 'g'
--
```

#### 05

Page 85.

```haskell
revStr :: String -> String
revStr str =
  let
    ini :: String
    ini = take 8 str
    mid :: String
    mid = take 2 $ drop 9 str
    end :: String
    end = drop 12 str
  in
    end ++ " " ++ mid ++ " " ++ ini
--
-- λ> revStr "Currying is awesome"
-- "awesome is Currying"
--
```

#### 06

Page 85.

```haskell
module Reverse where

revStr :: String -> String
revStr str =
  let
    ini :: String
    ini = take 8 str
    mid :: String
    mid = take 2 $ drop 9 str
    end :: String
    end = drop 12 str
  in
    end ++ " " ++ mid ++ " " ++ ini

main :: IO ()
main = print $ revStr "Currying is awesome"
--
-- λ> main
-- "awesome is Currying"
--
```

