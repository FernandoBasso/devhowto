{-# LANGUAGE NoMonomorphismRestriction #-}

eftBool :: Bool -> Bool -> [Bool]
eftBool False _ = [False, True]
eftBool True  _ = [True, False]


eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd LT EQ = [LT, EQ]
eftOrd EQ LT = [EQ, LT]
eftOrd EQ GT = [EQ, GT]
eftOrd GT EQ = [GT, EQ]
eftOrd LT _  = [LT, EQ, GT]
eftOrd GT _  = [GT, EQ, LT]

--
-- ‘ini’ must be less than ‘end’. Does not handle randing down, or
-- negative values.
--
eftInt :: Int -> Int -> [Int]
eftInt ini end = go (ini + 1) [ini]
  where go current acc
          | end < current = []
          | current == end = acc ++ [current]
          | otherwise = go (current + 1) (acc ++ [current])


--
-- Only handles ranges “going up”.
--
eftChar :: Char -> Char -> [Char]
eftChar ini end = go (succ ini) [ini]
  where go current acc
          | end < current = []
          | current == end = acc ++ [current]
          | otherwise = go (succ current) (acc ++ [current])

