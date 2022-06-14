{-# LANGUAGE NoMonomorphismRestriction #-}

ws = ["Principalmente", "Verás", "Outros", "Inválido"]

result1 =
  foldr (\w acc -> take 3 w ++ " " ++ acc) "" ws

result2 =
  foldr (\w acc -> take 3 (w :: String)
                       ++ (acc :: String)
        ) "" ws


reducer :: String -> String -> String
-- reducer = (\w acc -> (take 3 w) ++ acc)
reducer w acc = (take 3 w) ++ acc

--
-- ‘reducer’ takes a string as each ‘w’. It is ‘foldr’ job
-- to take one string at a time from ‘ws’ and feed it to
-- folding function (‘reducer’ in this case).
--
result3 = foldr reducer "" ws


main :: IO ()
main = do
  print $ result1

  print $ result2

  print $ result3

