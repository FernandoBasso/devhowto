{-# LANGUAGE NoMonomorphismRestriction #-}

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful\
\ symmetry?"

sentences :: [Char]
sentences = firstSen ++ secondSen
            ++ thirdSen ++ fourthSen

tombRaider :: [Char]
tombRaider = "Tomb Raider - The Angel of Darkness"

shouldEqualSentences :: [[Char]]
shouldEqualSentences =
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

shouldEqualTombRaider :: [[Char]]
shouldEqualTombRaider =
  [ "Tomb"
  , "Raider"
  , "-"
  , "The"
  , "Angel"
  , "of"
  , "Darkness"
  ]

dropUntil :: Char -> [Char] -> [Char]
dropUntil chr str
  | str == "" = str
  | head str == chr = tail str
  | otherwise = dropUntil chr (dropWhile (/= chr) str)

--
-- What changes between `myWords` and `myLines` is the char used to split the
-- input into. So, we make it a parameter so we can use the same function to
-- make lists dividing input using different chars.
--
toList :: Char -> String -> [String]
toList chr str = go chr str []
  where go chr s acc
          | s == "" = acc
          | otherwise = go chr
                        (dropUntil chr s)
                        (acc ++ [takeWhile (/= chr) s])

main :: IO ()
main = do
  putStrLn $
    "Tomb Raider --: " ++
    (show $ toList ' ' tombRaider == shouldEqualTombRaider)

  putStrLn $
    "Sentences ----: " ++
    (show $ toList '\n' sentences == shouldEqualSentences)

--
-- λ> main
-- Tomb Raider --: True
-- Sentences ----: True
--
