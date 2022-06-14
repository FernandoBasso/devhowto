{-# LANGUAGE NoMonomorphismRestriction #-}

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful\
\ symmetry?"

sentences = firstSen ++ secondSen
            ++ thirdSen ++ fourthSen

shouldEqual =
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

dropUntilNL :: [Char] -> [Char]
dropUntilNL str
  | str == "" = str
  | head str == '\n' = tail str
  | otherwise = dropUntilNL (dropWhile (/= '\n') str)

myLines :: String -> [String]
myLines str = go str []
  where go s acc
          | s == "" = acc
          | otherwise = go (dropUntilNL s)
                           (acc ++ [takeWhile (/= '\n') s])

main :: IO ()
main = do
  print $
    "Are they equal? "
    ++ show (myLines sentences == shouldEqual)

