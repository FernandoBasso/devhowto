{-# LANGUAGE NoMonomorphismRestriction #-}

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs)
  | p x = x : myFilter p xs
  | otherwise = myFilter p xs



multOf :: Int -> [Int] -> [Int]
multOf n genList =
  filter (\x -> rem x n == 0) genList

multOf3 :: [Int] -> [Int]
multOf3 = multOf 3

-- OK
r1 = (length . multOf3) [1..30]

-- OK
r2 = (length . multOf 3) [1..30]

-- Oops.
--r3 = (length . multOf) 3 [1..30]



s1 = "the brown dog was a goof"
s2 = "there is an old jedi here"

dropArticles :: [Char] -> [[Char]]
dropArticles str = filter isNotArticle $ words str
  where isNotArticle w = not $ elem w ["a", "an", "the"]
--
-- λ> dropArticles s1
-- ["brown","dog","was","goof"]
-- λ> dropArticles s2
-- ["there","is","old","jedi","here"]
--

