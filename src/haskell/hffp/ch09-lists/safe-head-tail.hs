{-# LANGUAGE NoMonomorphismRestriction #-}

-- Can make ‘myTail’ safer by pattern-matching on the empty list,
-- but what about ‘myHead’? There seems to be impossible unlfess
-- we use ‘Maybe’.

myHead (x : _) = x

myTail :: [a] -> [a]
myTail [] = []
myTail (_ : xs) = xs


safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x


safeTail        :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:[]) = Nothing
safeTail (_:xs) = Just xs

