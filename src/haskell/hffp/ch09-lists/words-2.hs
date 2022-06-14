{-# LANGUAGE NoMonomorphismRestriction #-}

dropWhileSpc :: [Char] -> [Char]
dropWhileSpc = dropWhile (== ' ')

dropUntilSpc :: [Char] -> [Char]
dropUntilSpc = dropWhile (/= ' ')

isSpc :: Char -> Bool
isSpc ' ' = True
isSpc _   = False

takeUntilSpc :: [Char] -> [Char]
takeUntilSpc = takeWhile (/= ' ')

toList :: a -> [a]
toList thing = (:) thing []

myWords :: [Char] -> [[Char]]
myWords s = go s []
  where
    go :: [Char] -> [[Char]] -> [[Char]]
    go xs acc
        | (==) xs [] = acc
        | isSpc . head $ xs = go (dropWhileSpc xs) acc
        | otherwise =
            go
              (dropUntilSpc xs)
              ((++) (toList . takeUntilSpc $ xs) acc)
--
-- λ> mapM_ putStrLn $ myWords "💖 Tomb Raider - Angel of Darkness 💯"
-- 💯
-- Darkness
-- of
-- Angel
-- -
-- Raider
-- Tomb
-- 💖
--
