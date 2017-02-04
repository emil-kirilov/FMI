intercalate'::[Char]->[[Char]]->[Char]

intercalate' phrase words 
  | length words == 1   = head words
  | otherwise           = head words ++ phrase ++  intercalate' phrase (tail words)