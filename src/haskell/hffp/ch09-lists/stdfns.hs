{-# LANGUAGE NoMonomorphismRestriction #-}


myAnd :: [Bool] -> Bool
myAnd []     = True
myAnd (x:xs) = x && myAnd xs


myOr :: [Bool] -> Bool
myOr []     = False
myOr (x:xs) = x || myOr xs


myAny :: (a -> Bool) -> [a] -> Bool
myAny _ []     = False
myAny f (x:xs) = f x || myAny f xs


myElem :: Eq a => a -> [a] -> Bool
myElem _ []     = False
myElem e (x:xs) = e == x || myElem e xs


myElem' :: Eq a => a -> [a] -> Bool
myElem' e = myAny (e ==)


myRev :: [a] -> [a]
myRev []     = []
myRev (x:xs) = myRev xs ++ [x]


squish :: [[a]] -> [a]
squish []            = []
squish (xs:listOfXs) = xs ++ squish listOfXs


squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ []     = []
squishMap f (x:xs) = f x ++ squishMap f xs
--
-- λ> squishMap (\x -> "  __" ++ [x] ++ "__") "abc"
-- "  __a__  __b__  __c__"
--

squishAgain :: [[a]] -> [a]
squishAgain [] = []
squishAgain listOfXs = squishMap (\xs -> xs ++ []) listOfXs
--
-- λ> squishAgain [[1..3], [4..6]]
-- [1,2,3,4,5,6]
--

squishAgainPF :: [[a]] -> [a]
squishAgainPF = squishMap (\xs -> xs ++ [])
--
-- λ> squishAgain [[1..3], [4..6]]
-- [1,2,3,4,5,6]
--


myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [x] = x
myMaximumBy compFn (x:xs) =
  case compFn x (myMaximumBy compFn xs) of
    GT -> x
    EQ -> x
    LT -> myMaximumBy compFn xs


myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [x] = x
myMinimumBy compFn (x:xs) =
  case compFn x (myMinimumBy compFn xs) of
    LT -> x
    EQ -> x
    GT -> myMinimumBy compFn xs


myMaximum :: Ord a => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: Ord a => [a] -> a
myMinimum = myMinimumBy compare

