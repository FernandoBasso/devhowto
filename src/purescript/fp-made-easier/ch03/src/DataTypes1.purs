module DataTypes1 where

data Bool = T | F

f :: Bool
f = F

t :: Bool
t = T

data WhyCancel
  = TooManyEmails
  | NotInterested
  | Other String

answer :: WhyCancel
answer = Other "I don't like email adds..."
