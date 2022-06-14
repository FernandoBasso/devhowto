{-# LANGUAGE NoMonomorphismRestriction #-}

data Identity a =
  Identity a
  deriving Show

instance Eq a => Eq (Identity a) where
  (==) (Identity v) (Identity v') = v == v'

--------------------------------------------------------------------------------
data TisAnInteger = TisAn Integer

instance Eq TisAnInteger where
  (==) (TisAn i) (TisAn i') = i == i'

--------------------------------------------------------------------------------
data TwoIntegers = Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two x y) (Two x' y') = x == x' && y == y'

--------------------------------------------------------------------------------
data StringOrInt =
    TisAnInt Int
  | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt x) (TisAnInt x') = x == x'
  (==) (TisAString s) (TisAString s') = s == s'
  (==) _ _ = False

--------------------------------------------------------------------------------
data Pair a = Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair x y) (Pair x' y') = (x == x') && (y == y') 

--------------------------------------------------------------------------------
data Tuple a b = Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple a b) (Tuple a' b') = a == a' && b == b'

--------------------------------------------------------------------------------
data Which a = ThisOne a | ThatOne a

instance Eq a => Eq (Which a) where
  (==) (ThisOne v) (ThisOne v') = v == v'
  (==) (ThatOne v) (ThatOne v') = v == v'
  (==) _ _ = False

--------------------------------------------------------------------------------
data EitherOr a b = Hello a | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello v)   (Hello v')   = (==) v v'
  (==) (Goodbye v) (Goodbye v') = (==) v v'
  (==) _           _            = False
