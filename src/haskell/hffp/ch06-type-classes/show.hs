{-# LANGUAGE NoMonomorphismRestriction #-}

data Mood = Blah | Meh

--
-- Whenever we print Blah and Meh all we get is "...".
--
instance Show Mood where
  show _ = "..."

--
-- We can also simply derive Show! 💖
--
data Thing = Foo | Bar | Tux deriving Show
