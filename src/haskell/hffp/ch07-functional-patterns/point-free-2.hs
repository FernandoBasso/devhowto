{-# LANGUAGE NoMonomorphismRestriction #-}

module Arith where

add :: Int -> Int -> Int
add x y = (+) x y

addPF :: Int -> Int -> Int
addPF = (+)

add1 :: Int -> Int
add1 = \x -> (+) x 1

add1PF :: Int -> Int
add1PF = (+ 1)

main :: IO ()
main = do
  print (0 :: Int)
  print (add 1 0)
  print (add1 0)
  print (add1PF 0)
  print ((add1 . add1) 0)
  print ((add1PF . add1) 0)
  print ((add1 . add1PF) 0)
  print ((add1PF . add1PF) 0)
  print (negate (add1 0))
  print ((negate . add1) 0)
  print ((add1 . add1 . add1 . negate . add1) 0)

