module Flip1 where

f1 :: ∀ a b c. (a -> b -> c) -> (b -> a -> c)
f1 f = \x y -> f y x

f2 :: ∀ a b c. (a -> b -> c) -> b -> (a -> c)
f2 f x = \y -> f y x

f3 :: ∀ a b c. (a -> b -> c) -> b -> a -> c
f3 f x y = f y x

