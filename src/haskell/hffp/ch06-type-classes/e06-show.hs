{-# LANGUAGE NoMonomorphismRestriction #-}

data Mood = Blah

instance Show Mood where
  show _ = "<< Blah >> "


data Thing = Foo | Bar

instance Show Thing where
  show Foo = "[[Foo]]"
  show Bar = "{{Bar}}"
