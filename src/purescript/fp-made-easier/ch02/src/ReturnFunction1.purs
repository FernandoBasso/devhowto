module ReturnFunctions1 where

import Prelude

import Data.String.Common (toUpper, toLower)
import Effect (Effect)
import Effect.Console (log)

isEven :: Int -> Boolean
isEven n = mod n 2 == 0

upperLower :: Int -> (String -> String)
upperLower n = if isEven n then toUpper else toLower

main :: Effect Unit
main = do
  log $ upperLower 0 "Should output in uppercase."
  log $ upperLower 1 "SHOULD OUTPUT IN LOWER CASE."
