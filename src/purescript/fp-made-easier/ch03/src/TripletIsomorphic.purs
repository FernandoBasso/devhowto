-- vim: set tw=68:

module TripletIsomorphic where

{-

```
$ spago install strings
```

It will be added to `spago.dhall` as a dependency.


-}

import Prelude
import Data.String.CodeUnits (toCharArray)
import Data.Array (filter, length)
import Data.String as String

data Triplet a b c = Triplet a b c

--
-- Assume c is lowercase.
--
-- Not using sectioning like in Haskell. Not sure yet if it
-- is possible in PureScript.
--
isVowel :: Char -> Boolean
isVowel c = length (filter (\e -> e == c) ['a', 'e', 'i', 'o', 'u']) > 0

--
-- Assume s is lowercase.
--
countVowels :: String -> Int
countVowels s = length $ filter isVowel (toCharArray s)

type StringStats = Triplet String Int Int


getStats :: String -> StringStats
getStats s = Triplet s (String.length s) (countVowels s)

data StrTriplet = StrTriplet String Int Int

data StrStats = StrStats
  { str :: String
  , length :: Int
  , vowelCount :: Int
  }

--
-- StrTriplet and StrStats have exactly the same types. The are
-- Isomorphic (a function from t1 to t2 can be written from t2
-- to t1 without any loss of information.
--

from :: StrTriplet -> StrStats
from (StrTriplet str len vowelCount) =
  StrStats
  { str: str
  , length: len
  , vowelCount: vowelCount
  }

to :: StrStats -> StrTriplet
to (StrStats { str, length, vowelCount }) =
  StrTriplet str length vowelCount

