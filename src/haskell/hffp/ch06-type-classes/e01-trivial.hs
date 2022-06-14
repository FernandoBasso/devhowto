{-# LANGUAGE NoMonomorphismRestriction #-}

data Trivial = Foo | Bar

instance Eq Trivial where
  Foo  == Foo = True
  (==) Bar Bar = True
  _    == _     = False

