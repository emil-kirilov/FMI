--makes all the possible concatenations described in the problem
concat'::[Char]->[[Char]]->[[Char]]
concat' word list
  | list == []                                    = []
  | compare word (head list) == EQ                = concat' word (tail list)
  | compare (head word) (last (head list)) == EQ  = [head list ++ tail word] ++ concat' word (tail list)
  | otherwise                                     = concat' word (tail list)

--removes nested lists and makes a new big one containing all the data 
unfold::[[[Char]]]->[[Char]]
unfold list
  | list == []          = []
  | head list == []     = unfold (tail list)
  | otherwise           = head list ++ unfold (tail list)

--finds the longest word in a list
selectLongestWord::[[Char]]->[Char]
selectLongestWord list = snd $ maximum $ map (\x -> (length x, x)) list

longestWord::[[Char]]->[Char]
longestWord list = longestWord' list list 

--I need this method because I am using the original list for further concatenations
longestWord'::[[Char]]->[[Char]]->[Char]
longestWord' list original 
  | list == []           = []
  | length newList == 0  = selectLongestWord list
  | otherwise            = longestWord' newList original 
  where newList = unfold $ map (\el -> concat' el list) original