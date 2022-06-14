# More Functional Patterns - Chapter 07

* [Exercises: Grab bag](#exercises:-grab-bag)
  * [01 mTh](#01-mth)
  * [02 mTh type](#02-mth-type)
  * [03](#03)
    * [a](#a)
    * [b](#b)
    * [c](#c)
* [Exercise: Variety Pack](#exercise:-variety-pack)
  * [01](#01)
  * [02](#02)
* [Exercises: Case practice](#exercises:-case-practice)
  * [01](#01)
  * [02](#02)
  * [03](#03)
* [Exercises: Artful dodgy](#exercises:-artful-dodgy)
* [Exercises: Guard duty](#exercises:-guard-duty)
  * [01](#01)
  * [02](#02)
  * [03](#03)
  * [04](#04)
  * [05](#05)
  * [06](#06)
  * [07](#07)
    * [08](#08)
* [Chapter exercises](#chapter-exercises)
  * [Multiple Choice](#multiple-choice)
    * [01](#01)
    * [02](#02)
    * [03](#03)
    * [04](#04)
    * [05](#05)
  * [Let’s write code](#let’s-write-code)
    * [01](#01)
      * [a](#a)
      * [b](#b)
      * [c](#c)
    * [02](#02)
    * [03](#03)
    * [04, 05](#04,-05)
    * [06](#06)

## Exercises: Grab bag

### 01 mTh

All the four versions are equivalent.

### 02 mTh type

Letter D is correct. Nothing is forcing the compiler to give a concrete type to the parameters. `Num a` is still the most polymorphic possible.

### 03

#### a

```haskell
-- ‘odd’ handles ‘Integral’, not ‘Num’.
add1IfOdd :: Integral a => a -> a
add1IfOdd n =
  case odd n of
    True -> f n
    False -> n
    where f = \x -> x + 1
```

#### b

```haskell
add5 :: (Num a, Ord a) => a -> a -> a
add5 = \x -> \y -> (+) 5 (if x > y then y else x)
```

#### c

```haskell
mflip :: (Num a, Num b, Num c) => (a -> b -> c) -> b -> a -> c
mflip f x y = f y x
```



## Exercise: Variety Pack

Page 237.

### 01

a. `k :: (a, b) -> a`

b. `k2 :: [Char]`

c. `k1` and `k3` will.

### 02

```haskell
f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, _, c) (d, _, f) = ((a, d), (c, f))
```

## Exercises: Case practice

Page 240.

### 01

```haskell
fnC :: Ord a => a -> a -> a
fnC x y =
  case x > y of
    True -> x
    False -> y
```

### 02

```haskell
ifEvenAdd2 :: Integral a => a -> a
ifEvenAdd2 n =
  case even n of
    True -> (+) n 2
    False -> n
```

### 03

```haskell
import GHC.Int

nums :: (Ord a, Num a) => a -> Int8
nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0
```

## Parenthesization and Associativity of (->)

```
returnLast :: a -> b -> c -> d -> d
returnLast _ _ _ d = d
```

Parenthesizing the type signature:

```
returnLast' :: a -> (b -> (c -> (d -> d)))
returnLast' _ _ _ d = d
```

It takes `a` and returns a function which takes some `b` and returns a function that takes `c` which in turn returns a function that takes `d` and finally returns `d`.

The error “The equation(s) for fn have n arguments but its type *some type* has only one” means the function actual parameters like `f x y z = ...` but the type signature implies only one parameter is taken.

```
f :: (((a -> b) -> c) -> d) -> d
f x y w z = z

λ> :load ch07-functional-patterns/HOFs.hs
[1 of 1] Compiling Main ( ch07-functional-patterns/HOFs.hs, interpreted )

ch07-functional-patterns/HOFs.hs:16:1: error:
    • Couldn't match expected type ‘d’
                  with actual type ‘p0 -> p1 -> p2 -> p2’
      ‘d’ is a rigid type variable bound by
        the type signature for:
          f :: forall a b c d. (((a -> b) -> c) -> d) -> d
        at ch07-functional-patterns/HOFs.hs:15:1-32
    • The equation(s) for ‘f’ have four arguments,
      but its type ‘(((a -> b) -> c) -> d) -> d’ has only one
    • Relevant bindings include
        f :: (((a -> b) -> c) -> d) -> d
          (bound at ch07-functional-patterns/HOFs.hs:16:1)
   |
16 | f x y w z = z
   | ^^^^^^^^^^^^^
Failed, no modules loaded.
```



## Exercises: Artful dodgy

Page 248.

```ghci
λ> dodgy 1 0
1

λ> dodgy 1 1
11

λ> dodgy 2 2
22

λ> dodgy 1 2
21

λ> dodgy 2 1
12

λ> oneIsOne 1
11

λ> oneIsOne 2
21

λ> oneIsTwo 1
21

λ> oneIsTwo 2
22

λ> oneIsOne 3
31

λ> oneIsTwo 3
2
```

## Exercises: Guard duty

### 01

All inputs would produce 'A'.

### 02

No, it would make a mess. The comparisons are relying on the order of the values and it returns on the first that matches.

### 03

B is correct.

### 04

Something that can be ordered and compared for equality, `Ord` implies `Eq`.

### 05

```haskell
pal :: Ord a => [a] -> Bool
```

### 06

C is correct.

### 07

Any type of numbers that can be compared.

#### 08

```haskell
numbers :: (Ord a, Num a, Num p) => a -> p
```





## Chapter exercises

Page 264.

### Multiple Choice

#### 01

D is correct.

#### 02

B is correct.

```haskell
f :: Char -> String
f c = [c]

g :: String -> [String]
g s = [s]

h :: Char -> [String]
h = g . f

-- λ> h 'k'
-- ["k"]
```

#### 03

D is correct.

```haskell
f :: Ord a => a -> a -> Bool
f x y = (>) x y

-- Partially-apply ‘f’.
g :: (Ord a, Num a) => a -> Bool
g = f 1
```

#### 04

B is correct.

#### 05

A is correct.

### Let’s write code

#### 01

##### a

```haskell
tensDigit :: Integral a => a -> a
tens x = d
  where
    xLast = fst . divMod x $ 10
    d     = snd . divMod xLast $ 10
```

##### b

Yes, the same type signature.

##### c

```haskell
hunsD :: Integral a => a -> a
hunsD x = d
  where
    xLast = fst . divMod x $ 100
    d     = snd . divMod xLast $ 10
```

#### 02

```haskell
foldBool :: a -> a -> Bool -> a
foldBool x _ False = x
foldBool _ y True  = y

fb :: a -> a -> Bool -> a
fb x y b =
  case b of
    False -> x
    True  -> y
```

#### 03

```haskell
g :: (a -> b) -> (a, c) -> (b, c)
g aToB (a, c) = (aToB a, c)
```

#### 04, 05

```haskell
roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)

-- The point-free version
rt :: (Show a, Read a) => a -> a
rt = read . show

main :: IO ()
main = do
  print $ roundTrip 4
  print $ id 4

  print $ rt 4
```

#### 06

```haskell
roundTrip :: (Show a, Read b) => a -> b
roundTrip = read . show

main :: IO ()
main = do
  print (roundTrip 1 :: Word)
  print (id 1)
```

