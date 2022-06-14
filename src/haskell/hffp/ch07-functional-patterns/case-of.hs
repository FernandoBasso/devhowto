{-# LANGUAGE NoMonomorphismRestriction #-}
import GHC.Int (Int8)

funcZ :: (Eq a, Num a) => a -> [Char]
funcZ x =
  case (+) x 1 == 1 of
    True  -> "AWESOME"
    False -> "wut‽"

pal :: [Char] -> [Char]
pal xs =
  case xs == reverse xs of
    True -> "Yes!"
    _    -> "No..."

pal' :: [Char] -> [Char]
pal' xs =
  case b of
    True  -> "Yes!"
    False -> "No..."
  where
    b :: Bool
    b = (==) xs (reverse xs)

fnCif :: Ord a => a -> a -> a
fnCif x y = if (x > y) then x else y

fnC :: Ord a => a -> a -> a
fnC x y =
  case x > y of
    True  -> x
    False -> y

ifEvenAdd2 :: Integral a => a -> a
ifEvenAdd2 n = if even n then (n+2) else n

caseEvenAdd2 :: Integral a => a -> a
caseEvenAdd2 n =
  case even n of
    True  -> (+) n 2
    False -> n

nums :: (Ord a, Num a) => a -> Int8
nums x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    EQ -> 0

