# Hello Haskell, chapter 02


<!-- vim-markdown-toc GitLab -->

* [Exercises: Comprehension Check](#exercises-comprehension-check)
  * [01, playing with exprs](#01-playing-with-exprs)
  * [02 writing a function](#02-writing-a-function)
  * [03 function using `pi'](#03-function-using-pi)
* [Exercises: Parentheses and Association](#exercises-parentheses-and-association)
  * [01 add, multiply](#01-add-multiply)
  * [02 perimeter, multiply and add](#02-perimeter-multiply-and-add)
  * [03 divide and add](#03-divide-and-add)
* [Exercises: Heal the Sick](#exercises-heal-the-sick)
  * [01 area space after dot](#01-area-space-after-dot)
  * [02 unbound variable, unused variable](#02-unbound-variable-unused-variable)
  * [03 indentation mishap](#03-indentation-mishap)
* [Exercises: A Head Code](#exercises-a-head-code)
  * [let expressions](#let-expressions)
    * [01 let](#01-let)
    * [02 let](#02-let)
    * [03 let](#03-let)
    * [04 let](#04-let)
  * [Rewrite to where](#rewrite-to-where)
    * [01 where](#01-where)
    * [02 where](#02-where)
    * [03 where](#03-where)
* [Chapter Exercises](#chapter-exercises)
  * [Parenthesization](#parenthesization)
    * [01](#01)
    * [02](#02)
    * [04](#04)
  * [Equivalent expressions](#equivalent-expressions)
    * [01](#01-1)
    * [02](#02-1)
    * [03](#03)
    * [04](#04-1)
    * [05](#05)
  * [More fun with functions](#more-fun-with-functions)
    * [01 waxOn](#01-waxon)
    * [02, 03](#02-03)
    * [04 let waxOn](#04-let-waxon)
    * [05 waxOn and triple](#05-waxon-and-triple)
    * [waxOff](#waxoff)
* [The End](#the-end)

<!-- vim-markdown-toc -->

## Exercises: Comprehension Check

Page 35.

### 01, playing with exprs

```ghci
λ> half x = (/) x 2
λ> square x = (*) x x

λ> square (half 3)
2.25
```



### 02 writing a function

```ghci
λ> f n = 3.14 * (n * n)
λ> f 5
78.5
λ> f 10
314.0
λ> f 2
12.56
λ> f 4
50.24
```

3.14 does not change. That value is hardcoded inside the function body. The value that is multiplied inside parentheses do change, so, we make it a parameter.

### 03 function using `pi'

```ghci
λ> f n = pi * (n * n)
λ> f 2
12.566370614359172
λ> f 4
50.26548245743669
```

## Exercises: Parentheses and Association

Page 39.

### 01 add, multiply

a and b produce different results. Parentheses here does make a difference.

### 02 perimeter, multiply and add

No change. Parenthesizing multiplication around an addition does not change anything. The multiplication would have been performed first anyway.

### 03 divide and add

Here, doing 2 + 9 before the division does change the result.

## Exercises: Heal the Sick

Page 45.

### 01 area space after dot

There is a space after the dot in "3. ".

```haskell
area x = 3.14 * (x * x)
```

### 02 unbound variable, unused variable

The function bounds `x` but attempts to use `b`, which is not in scope. Fix: use `x` inside the body of the function:

```haskell
double x = x * 2
```

### 03 indentation mishap

There is a horrible, monstrous whitespace before `y` causing GHCi to throw a fit.

```haskell
x = 7
y = 10
f = x + y
```





https://www.quora.com/How-do-I-use-the-dollar-sign-separator-in-Haskell

https://stackoverflow.com/questions/940382/what-is-the-difference-between-dot-and-dollar-sign



## Exercises: A Head Code

Page 59.

### let expressions

#### 01 let

`let x = 5 in x` produces 5. The `in x` is like a return statement in this case. We bind 5 to `x` and “return” x.

#### 02 let

Similar to the previous one. Produce `x * x`, which is 25.

#### 03 let

Produces 30. We use `let` to bind two values for `x` and `y`, and both are in scope for the `in` clause.

#### 04 let

Similar to the previous one. Just that the `in` clause ignores `y`, and the result is 6.

### Rewrite to where

#### 01 where

```haskell
ex1 = result
  where x       = 3
        y       = 1000
        result  = x * 3 + y
```

#### 02 where

```haskell
ex2 = result
  where
    y       = 10
    x       = 10 * 5 + y
    result  = x * 5
```

#### 03 where

```haskell
ex3 = result
  where
    x       = 7
    y       = negate x
    z       = y * 10
    result  = z / x + y
```

## Chapter Exercises

Page 60.

### Parenthesization

Page 61.

#### 01

```ghci
λ> 2 + 2 * 3 - 1
7
λ> 2 + (2 * 3) - 1
7
λ> (2 + (2 * 3)) - 1
7
```

#### 02

```ghci
λ> (^) 10 $ 1 + 1
100
λ> ((^) 10) $ (1 + 1)
100
```

#### 04

```ghci
λ> 2 ^ 2 * 4 ^ 5 + 1
4097
λ> (2 ^ 2) * (4 ^ 5) + 1
4097
λ> ((2 ^ 2) * (4 ^ 5)) + 1
4097
```

### Equivalent expressions

Page 61.

#### 01

The expression `1 + 1` is the same as the expression  2.

#### 02

The expression `10 ^ 2` is the same as the expression `10 + 9 * 10`, because `9 * 10` is reduced first, which is 90, which is then added to 10. Both expressions produce the value 100.

#### 03

These are different. `400 - 37` means “subtract 37 from 400, which is 363. `(-) 37 400` means “from 37, subtract 400, which results in -363.

#### 04

`div`  does integral division, while `/` does fractional division. Therefore, ``100 `div` 3`` results in 33 (discarding the fractional part), and `100 / 3` results in `33.333333333333336`.

#### 05

The results will be different because of the order of evaluation.

### More fun with functions

#### 01 waxOn

```ghci
λ> z = 7
λ> y = z + 8
λ> x = y ^ 2
λ> waxOn = x * 5
λ> 10 + waxOn
1135
λ> (+10) waxOn
1135
λ> (-) 15 waxOn
-1110
λ> (-) waxOn 15
1110
```

#### 02, 03

```ghci
λ> triple x = x * 3
λ> triple waxOn
3375
```

#### 04 let waxOn

```haskell
waxOn =
  let
    z = 7
    y = z + 8
    x = y ^ 2
  in x * 5
```

#### 05 waxOn and triple

```haskell
waxOn =
  let
    z = 7
    y = z + 8
    x = y ^ 2
  in x * 5

triple n = n * 3
```

#### waxOff

```haskell
waxOn =
  let
    z = 7
    y = z + 8
    x = y ^ 2
  in x * 5

triple n = n * 3

waxOf n = triple n
```



## The End

