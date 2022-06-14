{-# LANGUAGE NoMonomorphismRestriction #-}

data FooBar = Foo | Bar
  deriving Show

data DayOfWeek =
  Mon | Tue | Weds | Thu | Fri | Sat | Sun
  deriving Show

data Date = Date DayOfWeek Int
  deriving Show


instance Eq DayOfWeek where
  (==) Mon Mon   = True
  (==) Tue Tue   = True
  (==) Weds Weds = True
  (==) Thu Thu   = True
  (==) Fri Fri   = True
  (==) Sat Sat   = True
  (==) Sun Sun   = True

--
-- We need the unconditional case so we don't end up with a partial
-- function. Partial functions do not generate compile time
-- errors. Only runtime errors. Oh noes!
--
-- Remember to `:set -Wall`.
--

instance Eq Date where
  (==) (Date dayOfWeek dayOfMonth)
       (Date dayOfWeek' dayOfMonth') =
    (==) dayOfWeek dayOfWeek'
     &&
    (==) dayOfMonth dayOfMonth'
