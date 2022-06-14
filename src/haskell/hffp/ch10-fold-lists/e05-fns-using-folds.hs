{-# LANGUAGE NoMonomorphismRestriction #-}

-- Direct recursion, not using ‘&&’.
myAnd' :: [Bool] -> Bool
myAnd' [] = True
myAnd' (x:xs) =
  if x == False
  then False
  else myAnd xs

-- Direct recursion using ‘&&’.
myAnd'' :: [Bool] -> Bool
myAnd'' [] = True
myAnd'' (x:xs) = x && myAnd' xs

-- Fold, not point-free.
myAnd''' :: [Bool] -> Bool
myAnd''' = foldr f True
  where f = (\x acc ->
               if x == False
               then False
               else acc)

-- Both ‘myAnd’ and the folding function are point-free.
myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True


-- Direct recursion not using ‘||’.
myOr' :: [Bool] -> Bool
myOr' [] = False
myOr' (x:xs) =
  if x == True
  then True
  else myOr' xs

-- Direct recursion using ‘||’.
myOr'' :: [Bool] -> Bool
myOr'' [] = False
myOr'' (x:xs) = x || myOr'' xs

-- Fold, not point-free.
myOr''' :: [Bool] -> Bool
myOr''' = foldr f False
  where f = (\x acc ->
               if x == True
               then True
               else acc)

-- Both ‘myOr’ and the folding function are point-free.
myOr :: [Bool] -> Bool
myOr = foldr (||) False


-- Direct recursion not using ‘||’.
myAny' :: (a -> Bool) -> [a] -> Bool
myAny' _ []     = False
myAny' f (x:xs) =
  if f x == True
  then True
  else myAny' f xs

-- Direct recursion using ‘||’.
myAny'' :: (a -> Bool) -> [a] -> Bool
myAny'' _ []     = False
myAny'' f (x:xs) = f x || myAny' f xs

-- Fold, not point-free.
myAny''' :: (a -> Bool) -> [a] -> Bool
myAny''' f = foldr g False
  where g = (\x acc ->
               if f x == True
               then True
               else acc)


myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (||) False . map f



myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e xs = myAny (== e) xs


myEl :: Eq a => a -> [a] -> Bool
myEl e = foldr (||) False . map (== e)

myEl' :: Eq a => a -> [a] -> Bool
myEl' e = foldr (\x acc -> acc || x == e) False


myRev :: [a] -> [a]
myRev = foldr (\x acc -> acc ++ [x]) []

myRev' :: [a] -> [a]
myRev' = foldl (flip (:)) []


myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x acc -> f x : acc) []


myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x acc ->
                      case f x of
                        True -> x : acc
                        False -> acc) []

squinsh :: [[a]] -> [a]
squinsh = foldr (\xs acc -> xs ++ acc) []


-- Why ‘(a -> [b])’ instead of ‘(a -> b)’?
squinshMap :: (a -> [b]) -> [a] -> [b]
squinshMap f = foldr (\x acc -> f x ++ acc) []
--
-- λ> squinshMap (flip (:) []) [1..3]
-- [1,2,3]
--

squinshMap' :: (a -> [b]) -> [a] -> [b]
squinshMap' f = foldr ((++) . f) []

squinshAgain :: [[a]] -> [a]
squinshAgain = squinshMap id


myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy p xs = foldr (\x acc ->
                          if p x acc == GT
                          then x
                          else acc) (last xs) xs


myMininumBy :: (a -> a -> Ordering) -> [a] -> a
myMininumBy p xs = foldr (\x acc ->
                            if p x acc == LT
                            then x
                            else acc) (last xs) xs


