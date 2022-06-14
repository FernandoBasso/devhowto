{-# LANGUAGE NoMonomorphismRestriction #-}

myScanl :: (a -> b -> a) -> a -> [b] -> [a]
myScanl f q ls =
  q : (case ls of
         [] -> []
         x:xs -> myScanl f (f q x) xs)


res1 = myScanl (+) 1 [1..3]


fib :: Word -> Word
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)


fibs :: [Word]
fibs = 1 : myScanl (+) 1 fibs


fibsN :: Int -> Word
fibsN n = fibs !! n


fibs20first :: [Word]
fibs20first = take 20 fibs


fibsLT100 :: [Word]
fibsLT100 = takeWhile (< 100) fibs


fact :: Word -> Word
fact 0 = 1
fact n = n * fact (n - 1)


facts :: [Word]
facts = myScanl (*) 1 [1..]

factN :: Int -> Word
factN n = facts !! n
