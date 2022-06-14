{-# LANGUAGE NoMonomorphismRestriction #-}

module RegisteredUser where

newtype Username =
  Username String

newtype AccountNumber =
  AccountNumber Integer

data User =
    UnregisteredUser
  | RegisteredUser Username AccountNumber


printUser :: User -> IO ()
printUser UnregisteredUser = putStrLn "😲 UnregisteredUser..."
printUser (RegisteredUser
            (Username name)
            (AccountNumber acctNum)) =
    putStrLn $ name ++ " " ++ show acctNum

main :: IO ()
main = printUser user
  where
    user = RegisteredUser
            (Username "Yoda")
            (AccountNumber 1)


