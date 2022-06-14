{-# LANGUAGE NoMonomorphismRestriction #-}

module RegisteredUser where

newtype Username = Username String

newtype AccountNumber = AccountNumber Integer

data User =
    UnregisteredUser
  | RegisteredUser Username AccountNumber

printUser :: User -> IO ()
printUser UnregisteredUser = putStrLn "Unregistered..."
printUser (RegisteredUser
            (Username name)
            (AccountNumber num)) =
  putStrLn $ name ++ " " ++ show num

-- λ> printUser UnregisteredUser
-- Unregistered...
--
-- λ> u = Username "Lara Croft"
-- λ> a = AccountNumber 1996
--
-- λ> printUser $ RegisteredUser u a
-- Lara Croft 1996
