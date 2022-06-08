module Factorial1 where

import Prelude

fact :: Int -> Int
fact 0 = 1
fact n = (*) n (fact (n - 1))
