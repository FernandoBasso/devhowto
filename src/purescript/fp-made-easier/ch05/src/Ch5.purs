module Ch5 where

import Prelude (Unit, show)
import Effect (Effect)
import Effect.Console (log)

flip :: ∀ (a :: Type) (b :: Type) (c :: Type). (a -> b -> c) -> b -> a -> c
flip f x y = f y x

const :: ∀ a b. a -> b -> a
const x _ = x

test :: Effect Unit
test = do
  log (show (flip const 1 2))

