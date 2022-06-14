
module Reverse where

rvrs :: [Char] -> [Char]
rvrs s = end ++ " " ++ mid ++ " " ++ ini
  where
    ini = take 5 s
    mid = take 2 $ drop 6 s
    end = drop 9 s

main :: IO ()
main = print (rvrs "Curry is awesome!")

