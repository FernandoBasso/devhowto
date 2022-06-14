{-# LANGUAGE NoMonomorphismRestriction #-}

fact4 :: Integer
fact4 = 4 * 3 * 2 * 1

--
-- 1 is the identity value multiplication.
--
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

