{-# LANGUAGE NoMonomorphismRestriction #-}

-- Like an interface in other langs. A type class
-- like Num or Fractional.
class Numberish a where
  fromNumber :: Integer -> a
  toNumber :: a -> Integer

-- Like data (for now).
newtype Age =
  Age Integer
  deriving (Eq, Show)

-- Implements the interface.
instance Numberish Age where
  fromNumber n = Age n
  toNumber (Age n) = n

-- Like data (for now).
newtype Year =
  Year Integer
  deriving (Eq, Show)

-- Implements the interface.
instance Numberish Year where
  fromNumber n = Year n
  toNumber (Year n) = n

sumNumberish :: Numberish a => a -> a -> a
sumNumberish a a' = fromNumber summed
  where integerOfA        = toNumber  a
        integerOfAPrime   = toNumber  a'
        summed = (+) integerOfA integerOfAPrime
--  λ> sumNumberish  (Age 10) (Age 1)
--  Age 11
--  λ> sumNumberish  (Year 10) (Year 1)
--  Year 11
