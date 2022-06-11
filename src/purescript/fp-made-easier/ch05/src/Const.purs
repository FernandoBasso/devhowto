module Const where

import Prelude ((>), const)
import Data.Array (filter)

f1 :: ∀ a b. a -> b -> a
f1 x _ = x

f2 :: ∀ a b. a -> b -> a
f2 = \x _ -> x

f3 :: ∀ a b. a -> (b -> a)
f3 x = \_ -> x

r1 :: Array Int
r1 = filter (\n -> (>) n 2) [1, 2, 3, 4]

--
-- `filter` calls `const true 1`, then `const true 2`, etc. for each
-- element of the array. `const` will always ignore the element, and only
-- consider `true` (the first argument, since `const` always ignores the
-- its second argument`.
--
-- The result is that the predicate is always satisfied and all elements
-- are kept in the resulting array.
--
r2 :: Array Int
r2 = filter (const true) [1, 2, 3, 4]

