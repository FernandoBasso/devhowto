module NewTypes1 where

import Prelude

fullName :: String -> String -> String -> String
fullName f m l = f <> " " <> m <> " " <> l

quigon :: String
quigon = fullName "Qui" "Gon" "Jinn"

ahsoka :: String
ahsoka = fullName "Ahsoka" "" "Tano"
