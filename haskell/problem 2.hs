--special::Integer

prime n = prime' n 2 

prime' n k 
  |n < k           = error "invalid input" 
  |n == k          = True
  |n `rem` k == 0  = False
  |otherwise       = prime' n (k + 1)

touplesToNumbers arr = map (\x -> (fst x) + 2 * (snd x) ) arr


removeDuplicates (x:xs) 
  |x elem xs = removeDuplicates xs
  |otherwise = x:(removeDuplicates xs)

   