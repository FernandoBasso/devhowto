
exclaim :: String -> String
exclaim s = s ++ ['!']
--
-- λ> exclaim "Tomb Raider"
-- "Tomb Raider!"
--

-- The 5th char is on index 4.
take5thChar :: String -> Char
take5thChar s = (!!) s 4
--
-- λ> take5thChar "Croft Manor"
-- 't'
--

drop9 :: String -> String
drop9 s = drop 9 s
--
-- λ> drop9 "Curry is awesome!"
-- "awesome!"
-- λ> drop9 "Croft is arriving!"
-- "arriving!"
--


thirdLetter :: String -> Char
thirdLetter s = (!!) s 3
--
-- λ> thirdLetter "Lara"
-- 'a'
--


letterIndex :: Int -> Char
letterIndex i = (!!) "A perfect organism. I admire its purity." i
--
-- λ> letterIndex 0
-- 'A'
-- λ> letterIndex 10
-- 'o'
--

rvrs :: [Char] -> [Char]
rvrs s = end ++ " " ++ mid ++ " " ++ ini
  where
    ini = take 5 s
    mid = take 2 $ drop 6 s
    end = drop 9 s
--
-- λ> rvrs "Curry is awesome!"
-- "awesome! is Curry"
--

