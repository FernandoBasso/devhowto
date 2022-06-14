{-# LANGUAGE NoMonomorphismRestriction #-}


-- Write a function that takes inputs from stops and vowels and makes
-- 3-tuples of all possible stop-vowel-stop combinations.

stops = "pbtdkg"
vowels = "aeiou"

-- List comprehensions do iterate over all possibilities, unlike zip or
-- zipWith.
all :: [Char] -> [Char] -> [(Char, Char, Char)]
all ss vs = [(s1, v, s2) | s1 <- ss, v <- vs, s2 <- ss]

startWithP :: [Char] -> [Char] -> [(Char, Char, Char)]
startWithP ss vs =
  [(s1, v, s2) | s1 <- [(head ss)], v <- vs, s2 <- ss]


nouns = ["jedi", "padawan", "kitten"]
verbs = ["fight", "run", "meow"]

allnv :: [[Char]] -> [[Char]] -> [([Char], [Char])]
allnv ns vs = [(n, v) | n <- ns, v <- vs]

-- Finds the average of the length of the words.
seekritFunc :: [Char] -> Int
seekritFunc x =
  div (sum (map length (words x)))
      (length (words x))


-- Using ‘where’.
avgWordLen :: [Char] -> Double
avgWordLen str = (/) numWordChars lenWords
  where
    numWordChars = fromIntegral $ sum (map length (words str))
    lenWords     = fromIntegral $ length (words str)

-- Using ‘let’.
avgWLen :: [Char] -> Double
avgWLen str =
  let
    numWordChars = fromIntegral $ sum (map length (words str))
    lenWords     = fromIntegral $ length (words str)
  in
    (/) numWordChars lenWords
