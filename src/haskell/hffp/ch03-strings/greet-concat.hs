
myGreeting :: String
myGreeting = (++) "hello" " world!"

hello :: String
hello = "hello"

world :: [Char]
world = "world!"

tomb :: String
tomb = "Tomb"

raider :: [Char]
raider = "Raider"

main :: IO ()
main = do
  putStrLn myGreeting
  putStrLn sndGreeting
  putStrLn tombRaider
  where
    sndGreeting :: [Char]
    sndGreeting = (++) hello ((++) " " world)
    tombRaider :: String
    tombRaider = (++) tomb $ (++) " " raider


