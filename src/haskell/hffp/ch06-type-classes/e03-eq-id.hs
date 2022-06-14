{-# LANGUAGE NoMonomorphismRestriction #-}

-- Polymorphic params.
data Identity a = Identity a
  deriving Show

instance Eq a => Eq (Identity a) where
  (==) (Identity v) (Identity v') = v == v'

data NoEq = NoEqInst deriving Show
