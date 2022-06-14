{-# LANGUAGE NoMonomorphismRestriction #-}

type Numerator = Integer
type Denominator = Integer
type Quotient = Integer
type Remainder = Integer

data Division =
    Result (Quotient, Remainder)
  | DivisionByZero
  deriving Show

--
-- `divBy` is my implementation of `quotRem` in terms of subtraction.
--
-- Perform the subtraction on the absolute values and then negate the
-- tuple constituents according to the division rules.
--
divBy :: Numerator -> Denominator -> Division
divBy _   0     = DivisionByZero
divBy num denom = signify $ go (abs num) (abs denom) 0
  where
    go :: Numerator -> Denominator -> Quotient -> Division
    go n d count
      | d == 0    = DivisionByZero
      | n < d     = Result (count, n)
      | otherwise = go (n - d) d (count + 1)
    signify :: Division -> Division
    signify (Result (q, r))
      | num < 0 && denom < 0 = Result (q, (- r))
      | num < 0              = Result ((- q), (- r))
      | denom < 0            = Result ((- q), r)
      | otherwise            = Result (q, r)
--
-- λ> divBy (-7) 2
-- Result (-3,-1)
--
-- λ> divBy 7 (-2)
-- Result (-3,1)
--
-- λ> divBy 7 0
-- DivisionByZero
--

--
-- Very tiresome testing this by hand, comparing with the results of
-- `quotRem`, then making sure each new guard did not introduce incorrect
-- results for other parts of the program, etc. Unit tests would save a lot of
-- time testing this, besides being a much more reliable way of asserting the
-- program correctness, reducing the likelihood of human error while manually
-- testing.
--
