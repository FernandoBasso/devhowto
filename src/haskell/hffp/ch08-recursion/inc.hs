{-# LANGUAGE NoMonomorphismRestriction #-}

inc :: Num a => a -> a
inc = (+ 1)

three :: Num a => a
three = inc . inc . inc $ 0

--
-- NOTE: Both implementations fail if initial value
-- happens to be a negative number. We would perform
-- an infinite loop.
--

--
-- My implementation.
--
incTimes :: (Eq a, Num a) => a -> a -> a
incTimes 0 n = n
incTimes times n =
  incTimes (times - 1) (n + 1)

--
-- Book implementation. The recursion invocation seems
-- less intuitive. We do not increment `n` directly.
incTimes' :: (Eq a, Num a) => a -> a -> a
incTimes' 0 n = n
incTimes' times n =
  1 + (incTimes (times - 1)) n
