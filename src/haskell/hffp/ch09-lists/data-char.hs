{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.Char

dropUppers :: [Char] -> [Char]
dropUppers = filter $ not . isUpper


capitFst :: [Char] -> [Char]
capitFst str = [toUpper . head $ str] ++ tail str

-- More elegante. Uses pattern-matching, which simplifies
-- things and makes the body of the function cleaner.
capitFst' :: [Char] -> [Char]
capitFst' (x:xs) = [toUpper x] ++ xs


capit :: [Char] -> [Char]
capit [] = []
capit (x:xs) = [toUpper x] ++ capit xs

-- The exercise wants us to use ‘head’ instead of
-- pattern-matching on the first cons cell of the spine.

-- Using pattern-matching anyway.
upFst :: [Char] -> Char
upFst (x:_) = toUpper x

upFst' :: [Char] -> Char
upFst' s = toUpper $ head s

upFst'' s = toUpper . head $ s

upFst''' = toUpper . head

