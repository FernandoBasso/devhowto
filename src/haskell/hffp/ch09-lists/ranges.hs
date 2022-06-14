{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- The "enum from to" functions return empty list if the starting point is
-- less than the ending point. Remember that sum (or) data constructors behave
-- like a number line. So, things to the left are “less than” things on the
-- right.
--
-- λ> :info Bool
-- data Bool = False | True
--
-- λ> enumFromTo True False
-- []
--
-- λ> enumFromTo False True
-- [False,True]
--
eftBool :: Bool -> Bool -> [Bool]
eftBool False _    = []
eftBool True False = [True, False]
eftBool _ _        = []

--
-- A very explicit and manual way of ranging over the tree possible data
-- constructors of `Ordering`.
--
eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd LT EQ = [LT, EQ]
eftOrd EQ LT = [EQ, LT]
eftOrd EQ GT = [EQ, GT]
eftOrd GT EQ = [GT, EQ]
eftOrd LT _  = [LT, EQ, GT]
eftOrd GT _  = [GT, EQ, LT]

--
-- Using recursion.
--
eftOrdering :: Ordering -> Ordering -> [Ordering]
eftOrdering ini end = run ini []
  where
    run current acc
          | (<) end current = []
          | (==) current end = (++) acc [current]
          | otherwise = run (succ current) ((++) acc [current])

eftInt :: Int -> Int -> [Int]
eftInt ini end = go ini end []
  where
    go current final acc
        | final < current = []
        | current == final = (++) acc [current]
        | otherwise = go (succ current) final ((++) acc [current])

eftChar :: Char -> Char -> [Char]
eftChar ini end = loop ini []
  where
    loop current acc
          | (<) end current   = []
          | (==) current end = (++) acc [current]
          | otherwise = loop (succ current) ((++) acc [current])

