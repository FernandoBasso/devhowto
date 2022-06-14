{-# LANGUAGE NoMonomorphismRestriction #-}

mySqr :: (Num a, Enum a) => [a]
mySqr = [x ^ 2 | x <- [1..5]]

myCube :: (Num a, Enum a) => [a]
myCube = [y ^ 3 | y <- [1..5]]

tup1 :: [(Integer, Integer)]
tup1 = [(x, y) | x <- mySqr, y <- myCube]

tup2 :: [(Integer, Integer)]
tup2 = [(x, y) | x <- mySqr,
                 y <- myCube,
                 x < 50,
                 y < 50]

qty :: Int
qty = length tup2

