{-# LANGUAGE NoMonomorphismRestriction #-}

z = 7
y = z + 8
x = y ^ 2
waxOn' = x + 5

-- Using ‘where’.
waxOn = x + 5
  where
    z = 7
    y = z + 8
    x = y ^ 2

-- Using ‘let’.
waxOn'' = let z = 7
              y = z + 8
              x = y ^ 2
          in x + 5

triple n = n * 3


waxOff x = triple x

waxOff' x = triple x / 10

