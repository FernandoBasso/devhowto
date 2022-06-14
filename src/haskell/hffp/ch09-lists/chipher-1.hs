{-# LANGUAGE NoMonomorphismRestriction #-}

module Chipher where

import Data.Char

--
-- Where ‘mod’ should wrap around. In this case, it is the
-- length of the alphabet plus 1.
--
wrap :: Int
wrap = ord 'z' - ord 'a' + 1 -- 26

--
-- From an alphabet ranging from 0 to 25, ‘a’ is 0, ‘b’ is
-- 1, ‘z’ is 25.
--
pos :: Char -> Int
pos c = ord c - ord 'a'


rotate :: (Int -> Int -> Int) -> Int -> Char -> Char
rotate _ _ ' ' = ' '
rotate f step c   = newChar
  where
    newPos = mod (pos c `f` step) wrap
    newChar = chr (newPos + ord 'a')


caesar :: Int -> [Char] -> [Char]
caesar step str = map (rotate (-) step) str


unCaesar :: Int -> [Char] -> [Char]
unCaesar step str = map (rotate (+) step) str


orig = "the quick brown fox jumps over the lazy dog"
caesared = "qeb nrfzh yoltk clu grjmp lsbo qeb ixwv ald"


main :: IO ()
main = do
  print $ caesar 3 orig == caesared
  print $ unCaesar 3 caesared == orig


