module Ch5 where

import Prelude (Unit, show, const)
import Effect (Effect)
import Effect.Console (log)

flip :: ∀ (a :: Type) (b :: Type) (c :: Type). (a -> b -> c) -> b -> a -> c
flip f x y = f y x

flip_v2 :: ∀ (a :: Type) (b :: Type) (c :: Type). (a -> b -> c) -> (b -> a -> c)
flip_v2 f = \x y -> f y x

flip_v3 :: ∀ (a :: Type) (b :: Type) (c :: Type). (a -> b -> c) -> (b -> a -> c)
flip_v3 f x = \y -> f y x

test :: Effect Unit
test = do
  log (show (flip const 1 2))

