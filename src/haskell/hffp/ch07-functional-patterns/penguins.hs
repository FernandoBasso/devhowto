{-# LANGUAGE NoMonomorphismRestriction #-}

data Location =
    Galapagos
  | Antarctica
  | Australia
  | SouthAfrica
  | SouthAmerica
  deriving (Eq, Show)

data Penguin =
  Peng Location
  deriving (Eq, Show)

isSouthAfrica :: Location -> Bool
isSouthAfrica SouthAfrica = True
isSouthAfrica _           = False


gimmeLocation :: Penguin -> Location
gimmeLocation (Peng location) = location

humboldt = Peng SouthAmerica
gentoo = Peng Antarctica
macaroni = Peng Antarctica
little = Peng Australia
galapagos = Peng Galapagos


galapagosPenguin :: Penguin -> Bool
galapagosPenguin (Peng Galapagos) = True
galapagosPenguin _                = False

antarcticPenguin :: Penguin -> Bool
antarcticPenguin (Peng Antarctica) = True
antarcticPenguin _                = False

antarcticOrGapapagos :: Penguin -> Bool
antarcticOrGapapagos p =
     (galapagosPenguin p)
  || (antarcticPenguin p)
