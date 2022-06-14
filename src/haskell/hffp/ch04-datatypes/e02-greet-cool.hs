{-# LANGUAGE NoMonomorphismRestriction #-}

module Greet where

greetIfCool :: String -> IO ()
greetIfCool coolness =
  if cool coolness
  then
    putStrLn "eyyyy. What's sakin'?"
  else
    putStrLn "pshhhh..."
  where cool v =
          v == "downright frosty yo"
--
-- λ> greetIfCool "hey"
-- pshhhh...
-- λ> greetIfCool "downright frosty yo"
-- eyyyy. What's sakin'?
--

