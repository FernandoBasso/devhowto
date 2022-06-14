{-# LANGUAGE NoMonomorphismRestriction #-}

trip :: Integer -> Integer
trip = \x -> (*) x 3

mTh1 x y z = x * y * z

mTh2 x y = \z -> x * y * z

mTh3 x = \y -> \z -> x * y * z

mTh4 = \x -> \y -> \z -> x * y * z


addOne :: Int -> Int
addOne = \x -> (+) x 1

addOneIfOdd :: Int -> Int
addOneIfOdd n = case odd n of
  True -> f n
  False -> n
  where
    f :: Num a => a -> a
    f = \n -> (+) n 1

addFive' :: Int -> Int -> Int
addFive' x y = (if x > y then y else x) + 5

add5 :: (Ord a, Num a) => a -> a -> a
add5 = \x -> \y -> (+) (if (>) x y then y else x) 5

mflip' :: (a -> b -> c) -> b -> a -> c
mflip' f = \x -> \y -> f y x

mflip :: (Num a, Num b, Num c) => (a -> b -> c) -> b -> a -> c
mflip f x y = f y x
