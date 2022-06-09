module NewTypes3 where

import Prelude

data FirstName = FirstName String
data MiddleName = MiddleName String
data LastName = LastName String
data FullName = FullName String

fullName :: FirstName -> MiddleName -> LastName -> FullName
fullName (FirstName f) (MiddleName m) (LastName l) =
  FullName (f <> " " <> m <> " " <> l)

s :: FullName
s = fullName (FirstName "Leia") (MiddleName "Orgnana") (LastName "Skywalker")

{-

Then, to use it, we cannot simply pass three generic strings.
We must construct the proper data with the data constructors:

fullName (FirstName "a") (MiddleName "b") (LastName "c")

}
