module DataTypes2 where

import Prelude

algebraProblem :: Int
algebraProblem =
  let s = 20
      b = 12
      r = 3
   in s - b - r


data WhyCancel a
  = TooManyEmails
  | NotInterested
  | Other a

becauseWithString :: WhyCancel String
becauseWithString = Other "I don't like email ads."

type Reason = { code :: Int, text :: String }

becauseWithReason :: Reason
becauseWithReason =
  { code: 7
  , text: "I don't like ads."
  }
