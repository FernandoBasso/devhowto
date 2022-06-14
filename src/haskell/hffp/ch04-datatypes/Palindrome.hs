module Palindrome (isPalindrome) where

--
-- Produces True if the input is a palindrome, that is, reads the
-- same forward and backwards; False otherwise.
--
-- ASSUME: input is single word, lowercase, ASCII-only strings.
--
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome s = reverse s == s

