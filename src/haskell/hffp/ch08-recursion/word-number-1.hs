{-# LANGUAGE NoMonomorphismRestriction #-}

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
  concat . intersperse "-"
  $ map digitToWord
  $ digits n

--
-- λ> wordNumber 0
-- "zero"
-- λ> wordNumber 1984
-- "one-nine-eight-four"
--

