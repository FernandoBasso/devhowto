{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- Point-free style.
--
f :: [Integer] -> Integer
f = negate . sum

--
-- Non-point-free style. Explicit param.
--
f' :: [Integer] -> Integer
f' xs = negate . sum $ xs

--
-- Defining sum in terms of `foldr` in a non-point-free style using explicit
-- params.
--
mySum' :: Integer -> [Integer] -> Integer
mySum' acc xs = foldr (+) acc xs
-- λ> mySum' 0 [1..5]
-- 15

--
-- Now in point-free style. No explicit params.
--
mySum :: Integer -> [Integer] -> Integer
mySum = foldr (+)
-- λ> mySum 0 [1..5]
-- 15

--
-- Partially apply `mySum` with the accumulator starting at 0.
--
mySum0 :: [Integer] -> Integer
mySum0 = foldr (+) 0
-- λ> mySum0 [1..5]
-- 15

--
-- Idem, but staring the sum at 10.
--
mySum10 :: [Integer] -> Integer
mySum10 = foldr (+) 10
-- λ> mySum10 [1..5]
-- 25

--
-- Point-free style.
--
countAs :: [Char] -> Int
countAs = length . filter (== 'a')
-- λ> countAs "abracadabra"
-- 5

