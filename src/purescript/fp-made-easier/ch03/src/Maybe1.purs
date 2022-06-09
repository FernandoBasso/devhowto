--
-- @TODO @FIXME, page 72
--

module Maybe where

import Prelude
import Data.Date
import Data.Date (canonicalDate, exactDate, Year)
import Data.Enum (toEnum)

data Maybe a = Just a | Nothing

data Person = Person
  { name :: String
  , birthDate :: Date
  , deathDate :: Date
  }

-- makeDate :: Int -> Int -> Int -> Maybe Date
-- makeDate year month day = case toEnum year of
--   Nothing -> Nothing
--   Just y -> case toEnum month of
--     Nothing -> Nothing
--     Just m -> case toEnum day of
--       Nothing -> Nothing
--       Just d -> exactDate y m d

-- person :: Person
-- person =
--   { name: "Joe Mama"
--   , birthDate: canonicalDate (makeDate 1972 10 2)
--   , deathDate: Nothing
--   }

{-
Can't make this work.

Found this, but no joy:

https://discourse.purescript.org/t/purescript-datetime-library-newbie-help/2154/1
-}
