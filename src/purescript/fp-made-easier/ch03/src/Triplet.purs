module Triplet where

import Prelude
import Data.Show

--
-- ‘a’, ‘b’ and ‘c’ are fully polymorphic. They can be any type
-- whatsoever.
--
data Triplet a b c = Triplet a b c deriving Show

triplet :: Triplet String Int Int
triplet = Triplet "NPC1" 3 7

zyzCoords :: Triplet Int Int Int
zyzCoords = Triplet 1 (-5) 7

-- vim: set tw=68:
