{-# LANGUAGE NoMonomorphismRestriction #-}

data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood Woot = Blah
-- 
-- λ> changeMood Woot
-- Blah
-- λ> changeMood Blah
-- Woot
-- 
