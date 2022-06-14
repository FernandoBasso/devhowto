{-# LANGUAGE NoMonomorphismRestriction #-}

class Numb a where
  fromNumb :: Integer -> a
  toNumb :: a -> Integer

newtype Age =
  Age Integer
  deriving (Eq, Show)

instance Numb Age where
  fromNumb n     = Age n
  toNumb (Age n) = n

newtype Year =
  Year Integer
  deriving (Eq, Show)

instance Numb Year where
  fromNumb n      = Year n
  toNumb (Year n) = n

sumNumb :: Numb a => a -> a -> a
sumNumb x y = fromNumb result
  where
    integerOfX = toNumb x
    integerOfY = toNumb y
    result     = (+) integerOfX integerOfY

