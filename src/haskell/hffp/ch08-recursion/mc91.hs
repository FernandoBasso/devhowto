{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- Using ‘case ... of’.
--
mc91 :: Integer -> Integer
mc91 n =
  case n > 100 of
    True  -> (-) n 10
    False -> mc91 (mc91 ((+) n 11))


--
-- Using guards.
--
mc91' :: Integer -> Integer
mc91' n
  | n > 100 = (-) n 10
  | n <= 100 = mc91 (mc91 (n + 11))

-- λ> map mc91 [95..110]
-- [91,91,91,91,91,91,91,92,93,94,95,96,97,98,99,100


