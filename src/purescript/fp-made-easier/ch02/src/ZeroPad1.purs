module ZeroPad1 where

import Prelude

import Data.String.CodeUnits (fromCharArray)
import Data.Array (cons)

repeatChar :: Char -> Int -> String
repeatChar c n = fromCharArray $ go n []
  where
    go :: Int -> Array Char -> Array Char
    go 0 acc = acc
    go num acc = cons c (go (num - 1) acc)


padLeft :: Char -> Int -> String -> String
padLeft chr len str = repeatChar chr len <> str

zeroPad :: Int -> String -> String
zeroPad len str = padLeft '0' len str
