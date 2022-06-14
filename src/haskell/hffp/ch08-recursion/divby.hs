{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- Book example.
--
divBy :: Integral a => a -> a -> (a, a)
divBy num denom = go num denom 0
  where go n d count
          | n < d = (count, n)
          | otherwise = go (n - d) d (count + 1)

--
-- From here on,  modifications from example on the book.
--
type Numerator = Integer
type Denominator = Integer
type Quotient = Integer
type Remainder = Integer

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n d count
         | n < d     = (count, n)
         | otherwise = go (n - d) d (count + 1)


divBy :: Numerator -> Denominator -> (Quotient, Remainder)
divBy num denom = go num denom 0
  where
    go :: Numerator -> Denominator -> Quotient -> (Quotient, Remainder)
    go n d count
      | n < d     = (count, n)
      | otherwise = go (n - d) d (count + 1)
