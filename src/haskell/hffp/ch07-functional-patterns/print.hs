{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- Compare the types of `putStr`, `putStrLn` and `print`.
--

--
-- Let's write `print` ourselves.
--
-- Non-point-free, using parens.
--
print :: Show a => a -> IO ()
print a = putStrLn (show a)
-- To avoid “ambigous occurrence of ‘print’” thing:
--
-- λ> Prelude.print 1
-- 1

--
-- Composition, non-point-free.
--
print' :: Show a => a -> IO ()
print' a = (putStrLn . show) a

--
-- Composition, point-free.
--
p :: Show a => a -> IO ()
p = putStrLn . show

