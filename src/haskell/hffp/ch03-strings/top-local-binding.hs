
discount :: Int
discount = 5

fn x = result
  where val :: Int
        val = 1
        result :: Int
        result = x + val - discount

main :: IO ()
main = do
  print $ fn 10
  -- 6

