{-# LANGUAGE NoMonomorphismRestriction #-}

------------------------------------------------------------------------------

--
-- Be mindful of the order of operations. Multiplication is performed first.
--
dodgy :: Int -> Int -> Int
dodgy x y = x + y * 10

oneIsOne :: Int -> Int
oneIsOne = dodgy 1

oneIsTwo :: Int -> Int
oneIsTwo = (flip dodgy) 2

-- dodgy 1 1  11
-- dodgy 2 2  22
-- dodgy 1 2  21
-- dodgy 2 1  12
--
-- oneIsOne 1     11
-- oneIsOne 2     21
--
-- oneIsTwo 1     21
-- oneIsTwo 2     22
--
-- oneIsOne 3     31
-- oneIsTwo 3     23


myAbs' :: Int -> Int
myAbs' n = if n < 0 then (negate n) else n

myAbs :: Int -> Int
myAbs n
  | n < 0     = (- n)
  | otherwise = n


