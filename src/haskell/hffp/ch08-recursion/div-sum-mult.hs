{-# LANGUAGE NoMonomorphismRestriction #-}

divBy :: Integral a => a -> a -> (a, a)
divBy num denom = go num denom 0
  where go n d count
          | n < d = (count, n)
          | otherwise = go (n - d) d (count + 1)


mysum :: Integer -> Integer
msum x = go x 0
  where go n acc
          | n == 0 = acc
          | otherwise = go (n - 1) (acc + n)

mymult :: Integer -> Integer -> Integer
mymult x y = go x y 0
  where go n m acc
          | m == 0 = acc
          | otherwise = go n (m - 1) (acc + n)

