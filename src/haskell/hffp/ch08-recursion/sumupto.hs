{-# LANGUAGE NoMonomorphismRestriction #-}

sumUpTo :: (Eq a, Num a) => a -> a
sumUpTo n = go n 0
   where go n acc
           | n == 0 = acc
           | otherwise = go (n - 1) (acc + n)

