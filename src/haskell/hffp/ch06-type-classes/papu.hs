{-# LANGUAGE NoMonomorphismRestriction #-}

data Rocks =
  Rocks String
  deriving (Eq, Ord, Show)

data Yeah =
  Yeah Bool
  deriving (Eq, Ord, Show)

data Papu =
  Papu Rocks Yeah
  deriving (Eq, Ord, Show)

-- 1:
phew :: Papu
phew = Papu (Rocks "chases") (Yeah True)

-- 2:
truth :: Papu
truth = Papu (Rocks "chomskydoz") (Yeah True)

-- 3:
equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'

-- 4:
comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'
