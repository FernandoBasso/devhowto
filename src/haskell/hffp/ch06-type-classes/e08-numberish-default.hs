{-# LANGUAGE NoMonomorphismRestriction #-}

-- Like an interface in other langs. A type class
-- like Num or Fractional.
class Numberish a where
  fromNumber    :: Integer -> a
  toNumber      :: a -> Integer
  defaultNumber :: a

-- Like data (for now).
newtype Age =
  Age Integer
  deriving (Eq, Show)

-- Implements the interface.
instance Numberish Age where
  fromNumber n      = Age n
  toNumber (Age n)  = n
  defaultNumber     = Age 65

-- Like data (for now).
newtype Year =
  Year Integer
  deriving (Eq, Show)

-- Implements the interface.
instance Numberish Year where
  fromNumber n = Year n
  toNumber (Year n) = n
  defaultNumber = Year 1984

sumNumberish :: Numberish a => a -> a -> a
sumNumberish a a' = fromNumber summed
  where integerOfA        = toNumber  a
        integerOfAPrime   = toNumber  a'
        summed = (+) integerOfA integerOfAPrime
