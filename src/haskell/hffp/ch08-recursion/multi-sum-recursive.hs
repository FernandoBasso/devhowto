{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- Multiply using recursive summation.
--
mult :: Integral a => a -> a -> a
mult x y = go x y 0
  where go n m acc
          | m == 0 = acc
          | otherwise = go n (m - 1) (acc + n)

