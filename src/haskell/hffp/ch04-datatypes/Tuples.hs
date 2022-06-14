{-# LANGUAGE NoMonomorphismRestriction #-}

module Tuples (f) where

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f (a, b) (c, d) = ((b, d), (a, c))

