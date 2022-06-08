module NewTypes2 where

import Prelude

type FirstName = String
type MiddleName = String
type LastName = String

fullName :: FirstName -> MiddleName -> LastName -> String
fullName f m l = f <> " " <> m <> " " <> l

