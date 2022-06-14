{-# LANGUAGE NoMonomorphismRestriction #-}

acronym :: [Char] -> [Char]
acronym str = [c | c <- str, elem c ['A' .. 'Z']]

--
-- λ> acronym "Tomb Raider"
-- "TR"
-- λ> acronym "Tomb Raider The Last Revelation"
-- "TRTLR"
--
-- λ> acronym "National Aeronautics and Space Administration"
-- "NASA"
--

