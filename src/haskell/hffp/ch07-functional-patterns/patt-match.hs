{-# LANGUAGE NoMonomorphismRestriction #-}

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f (a, b) (c, d) = ((a, c), (b, d))

addEmUp :: Num a -> (a, a) -> a
addEmUp (x, y) = (+) x y

fst3 :: (a, b, c) -> a
fst3 (x, _, _) = x

mid3 :: (a, b, c) -> b
mid3 (_, b, _) = b

third3 :: (a, b, c) -> c
third3 (_, _, c) = c
