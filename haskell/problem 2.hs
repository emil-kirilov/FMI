--special::Integer

prime n = prime' n 2 

prime' n k 
  |n < k           = error "invalid input" 
  |n == k          = True
  |n `rem` k == 0  = False
  |otherwise       = prime' n (k + 1)

touplesToNumbers arr = map (\x -> (fst x) + 2 * (snd x)* (snd x) ) arr

removeDuplicates [] = []
removeDuplicates (x:xs) = [x] ++ removeDuplicates (filter (\el -> el /= x) xs)

--odd, complex, can be represented by the sum of a prime number and twice the square of a natural number
notSpecial = removeDuplicates $ touplesToNumbers [(i, j) | i <- [2..99], prime i, 
                                                           j <- [1..6], odd (i + 2 * j * j), 
                                                           not (prime (i + 2 * j * j)), 100 > i + 2 * j * j, 9 < i + 2 * j * j]   

--odd, complex
special = [ i | i <- [11,13..99], not (prime i)] 
                                                           
numberOfSpecials = length notSpecial - length notSpecial 