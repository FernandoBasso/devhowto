{-# LANGUAGE NoMonomorphismRestriction #-}

myflip :: (a -> b -> c) -> b -> a -> c
myflip f x y = f y x

flip' :: (a -> b -> c) -> b -> a -> c
flip' f = \ x y -> f y x

returnLast :: a -> b -> c -> d -> d
returnLast _ _ _ d = d

returnLast' :: a -> (b -> (c -> (d -> d)))
returnLast' _ _ _ d = d
