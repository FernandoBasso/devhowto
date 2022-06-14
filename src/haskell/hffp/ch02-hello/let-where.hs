

f n = print plus2
  where plus2 = (+) n 2


g n = let plus2 = (+) n 2
      in print plus2


let1 = let x = 5
       in x

let2 = let x = 5
       in x * x

let3 = let x = 5
           y = 6
       in x * y

-- ‘y’ is a throw-away value. It is not used.
let4 = let x = 3
           y = 1000
       in x + 3



-- let x = 3; y = 1000 in x * 3 + y
where1 = result
  where
    x      = 3
    y      = 1000
    result = x * 3 + y


-- let y = 10; x = 10 * 5 + y in x * 5
where2 = result
  where
    y      = 10
    x      = 10 * 5 + y
    result = x * 5


letWhere3 = let x = 7
                y = negate x
                z = y * 10
            in z / x + y

where3 = result
  where
    x      = 7
    y      = negate x
    z      = y * 10
    result = z / x + y


