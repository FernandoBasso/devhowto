{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.Time

data DBItem = DbStr String
            | DbNum Integer
            | DbDate UTCTime
            deriving (Eq, Ord, Show)

theDb :: [DBItem]
theDb =
  [ DbDate (UTCTime (fromGregorian 1911 5 1)
                    (secondsToDiffTime 34123))
  , DbNum 2001
  , DbStr "Use the force!"
  , DbDate (UTCTime (fromGregorian 1921 5 1)
                    (secondsToDiffTime 34123))
  ]

otherDb = theDb ++
  [ DbNum 1
  , DbNum 10
  ]

isDbDate (DbDate d) = True
isDbDate _          = False


-- filterDbDate :: [DBItem] -> [UTCTime]
-- filterDbDate items = go items []
--   where go [] acc = acc
--         go ((DbDate d):xs) acc = go xs (acc ++ [d])
--         go (_:xs) acc = go xs acc

filterDbDate :: [DBItem] -> [UTCTime]
filterDbDate = foldr f []
  where f (DbDate d) acc = d : acc
        f _          acc = acc


filterDbNum :: [DBItem] -> [Integer]
filterDbNum = foldr f []
  where f (DbNum n) acc = n : acc
        f _         acc = acc

mostRecentDate :: [DBItem] -> UTCTime
mostRecentDate = minimum . filterDbDate


sumNums :: [DBItem] -> Integer
sumNums = sum . filterDbNum


avgNums :: (Fractional a) => [DBItem] -> a
avgNums items = (/) total len
  where total = fromIntegral $ sumNums items
        len   = fromIntegral $ length $ filterDbNum items


countDate :: [DBItem] -> Int
countDate = length . filterDbDate


