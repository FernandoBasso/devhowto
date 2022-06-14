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

