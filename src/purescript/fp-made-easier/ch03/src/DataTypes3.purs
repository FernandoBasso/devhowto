module DataTypes3 where

type Jedi = { id :: Int, name :: String }

data Thing a
  = Foo
  | Bar
  | Sth a

sthStr :: Thing String
sthStr = Sth "a string"

sthInt :: Thing Int
sthInt = Sth 1

sthJedi :: Thing Jedi
sthJedi = Sth { id: 1, name: "Ahsoka Tano" }
