{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- It is only evaluates the spine.
--
len :: [a] -> Integer
len [] = 0
len (_:xs) = (+) 1 $ len xs

--
-- Evaluates spine _and_ values because ‘+’ is strict both on
-- ‘x’ and ‘xs’.
--
mySum :: Num a => [a] -> a
mySum [] = 0
mySum (x:xs) = (+) x $ mySum xs

