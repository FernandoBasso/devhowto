{-# LANGUAGE NoMonomorphismRestriction #-}

mySum :: [Integer] -> Integer
mySum [] = 0
mySum (x:xs) = x + mySum xs

myLength :: [a] -> Integer
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myProduct :: [Integer] -> Integer
myProduct [] = 1
myProduct (x:xs) = x * myProduct xs

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs


myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ z [] = z
myFoldr f z (x:xs) = f x (myFoldr f z xs)

--
-- In all functions above, the base case is the identity for that
-- function.
--


f list = myFoldr (\x f -> concat ["(", x, " + ", f, ")"]) " 0" list
--
-- λ> f $ map show [10,15..25]
-- "(10 + (15 + (20 + (25 +  0))))"
--

display op x y = concat ["(", x, op, y, ")"]
--
-- λ> f = display " + "
-- λ> foldr f "0" $ map show [1..4]
-- "(1 + (2 + (3 + (4 + 0))))"
--
-- fλ> foldl f "0" $ map show [1..4]
-- "((((0 + 1) + 2) + 3) + 4)"
--

--
-- ‘myAny’ returns ‘False’ as the base case. Returns ‘True’ and
-- stops the fold evaluation as soon as a ‘True’ is found.
--
-- As soon as ‘f x’ returns and ‘b’ is not evaluated, the folding
-- stops. Folding only does further processing when the second
-- argument _is_ evaluated.
--
myAny :: (a -> Bool) -> [a] -> Bool
myAny f xs = foldr (\x b -> f x || b) False xs
--
-- λ> myAny even [1..3]
-- True
--



-- MarcelineQV
myAny' f xs = foldr (\x b -> (||) (f x) b) False xs

-- merijn
myAny'' f xs = foldr (||) False (map f xs)



