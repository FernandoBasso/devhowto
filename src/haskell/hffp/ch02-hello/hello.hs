{-# LANGUAGE NoMonomorphismRestriction #-}

sayHello :: String -> IO ()
sayHello s =
  putStrLn ("Hello, " ++ s ++ "!")

--
-- λ> :load dev.hs
--
-- λ> :t sayHello
-- sayHello :: String -> IO ()
--
-- λ> sayHello "Lara Croft"
-- Hello, Lara Croft!
--

------------------------------------------------------------------

triple :: Integer -> Integer
triple n = (*) n 3


