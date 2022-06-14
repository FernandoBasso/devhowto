{-# LANGUAGE NoMonomorphismRestriction #-}

fst' :: (,) a b -> a
fst' (a, b) = a

snd' :: (,) a b -> b
snd' (a, b) = b

tupFn :: (Int, [a]) -> (Int, [a]) -> (Int, [a])
tupFn (a, b) (c, d) = ((a + c), (b ++ d))
--
-- λ> tupFn (1900, "Tomb") (96, "Raider")
-- (1996,"TombRaider")
--

