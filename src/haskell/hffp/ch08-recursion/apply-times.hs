{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- NOTE: Doesn't work with negative numbers because we are doing
-- ‘times - 1’, so, if ‘times’ is negative, we never reach zero.
-- Rather, we continue going to further negative numbers, never
-- reaching the base case when times is zero.
--


applyTimes :: (Eq a, Num a) => a -> (b -> b) -> b -> b
applyTimes 0 _ val = val
applyTimes times f val = f (applyTimes (times - 1) f val)
--
-- λ> applyTimes 3 (+1) 0
-- 3
--

--
-- Using explicit composition.
--
applyTimes' :: (Eq a, Num a) => a -> (b -> b) -> b -> b
applyTimes' 0 _ val = val
applyTimes' times f val = f . applyTimes (times - 1) f $ val

--
-- Takes a number of times, a value, and increments that
-- value that number of times.
--
incTimes :: (Eq a, Num a) => a -> a -> a
incTimes times n = applyTimes' times (+1) n
