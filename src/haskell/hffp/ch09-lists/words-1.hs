{-# LANGUAGE NoMonomorphismRestriction #-}

myWords :: [Char] -> [[Char]]
myWords str = go str []
  where go s acc
          | s == "" = acc
          | head s == ' ' = go (tail s) acc
          | otherwise = go
                        (dropWhile (/= ' ') s)
                        (acc ++ [takeWhile (/= ' ') s])
--
-- [λ> myWords "Tomb Raider - The Angel Of Darkness"
-- ["Tomb","Raider","-","The","Angel","Of","Darkness"]
--
