module Absolute (myAbs) where
--
-- Produce the input number discarding the negative sign if present.
--
myAbs :: Integer -> Integer
myAbs n = if n >= 0 then n else n * (-1)

--
-- Remember that we can replace the whole `n * (-1)` by simply `-n`
-- since `-` is also a negation operator.
--
-- • https://wiki.haskell.org/Unary_operator
--
-- `-' is syntax suggar for `negate'.
--
