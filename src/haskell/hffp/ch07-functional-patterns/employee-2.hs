{-# LANGUAGE NoMonomorphismRestriction #-}

--
-- **IMPORTANT**: Remember that when ordering things, the data constructors on
-- the left are considered “less than” the data constructors on the right.
--
data Employee =
  Coder | Manager | Veep | CEO
  deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' =
  putStrLn $
    show e
    ++ " is the boss of "
    ++ show e'

employeeRank :: (Employee -> Employee -> Ordering)
             -> Employee -> Employee -> IO ()
employeeRank f e e' =
  case f e e' of
    GT -> reportBoss e e'
    EQ -> putStrLn "Neither is boss"
    LT -> (flip reportBoss) e e'

myCompare :: Employee -> Employee -> Ordering
myCompare Coder Coder = EQ
myCompare Coder _     = GT
myCompare _     Coder = GT
myCompare e     e'    = compare e e'

-- λ> employeeRank compare Coder CEO
-- CEO is the boss of Coder
--
-- λ> employeeRank myCompare Coder CEO
-- Coder is the boss of CEO
