{-# LANGUAGE NoMonomorphismRestriction #-}

--------------------------------------------------------------------------------
data TisAnInteger = TisAnInteger

instance Eq TisAnInteger where
  (==) TisAnInteger TisAnInteger = True

--------------------------------------------------------------------------------
data TwoIntegers = Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two x y) (Two x' y') = (==) x x' && (==) y y'

--------------------------------------------------------------------------------
data StringOrInt =
    TisAnInt   Int
  | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt n) (TisAnInt n') = (==) n n'
  (==) (TisAString s) (TisAString s') = (==) s s'
  (==) _ _ = False

--------------------------------------------------------------------------------
data Pair a = Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair x y) (Pair x' y') =
    (==) x x' && (==) y y'

--------------------------------------------------------------------------------
data Tuple a b = Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple x y) (Tuple x' y') =
    (==) x x' && (==) y y'

--------------------------------------------------------------------------------
data Which a = ThisOne a | ThatOne a

instance Eq a => Eq (Which a) where
  (==) (ThisOne x) (ThisOne x') = (==) x x'
  (==) (ThatOne x) (ThatOne x') = (==) x x'
  (==) _           _            = False

--------------------------------------------------------------------------------
data EitherOr a b = Hello a | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello x)   (Hello y)   = (==) x y
  (==) (Goodbye x) (Goodbye y) = (==) x y
  (==) _           _            = False

-- @TODO: Produces a warning about defaulting constraint to ()
-- if run with :set -Wall.
