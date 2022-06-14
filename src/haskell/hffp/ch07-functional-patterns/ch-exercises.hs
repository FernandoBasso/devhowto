{-# LANGUAGE NoMonomorphismRestriction #-}

module ExercisesCh07 where

tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = div x 10
        d     = mod xLast 10

tensDig :: Integral a => a -> a
tensDig x = d
  where
    parts = divMod x 10
    d     = mod (fst parts) 10

hunsD :: Integral a => a -> a
hunsD x = d
  where
    parts = divMod x 100
    d     = mod (fst parts) 10

foldBool :: a -> a -> Bool -> a
foldBool x y b =
  case b of
    True  -> x
    False -> y

foldBool' :: a -> a -> Bool -> a
foldBool' x _ False = x
foldBool' _ y True  = y

--
-- Params are:
-- • a function from a to b
-- • a tuple (a, c)
-- • a return tuple of (b, c)
--
g :: (a -> b) -> (a, c) -> (b, c)
g aToB (a, c) = (aToB a, c)

-- roundTrip :: (Show a, Read a) => a -> a
-- roundTrip a = read (show a)

-- roundTrip :: (Show a, Read a) => a -> a
-- roundTrip = read . show

roundTrip :: (Show a, Read b) => a -> b
roundTrip = read . show

main :: IO ()
main = do
  print (roundTrip 1 :: Word)
  print (id 1)

--
-- On the REPL, we must say what type to read as.
--
-- λ> read "1"
-- *** Exception: Prelude.read: no parse
--
-- We need to tell that we want to read "1" as some concrete type of number:
--
-- λ> read "1" :: Word
-- 1
--

