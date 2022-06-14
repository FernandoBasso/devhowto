

s :: [Char]
s = "May the force be with you."

w :: String
w = "The force is strong with this one."

fname :: String
fname = "Lara"

lname :: [Char]
lname = "Croft"

fullname :: String
fullname = fname ++ " " ++ lname


main :: IO ()
main = do
  putStrLn s
  putStrLn w
  putStrLn fullname



