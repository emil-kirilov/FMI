divisorsOf n k
  | n < 1            = error "invalid input"
  | n == 1           = []
  | n `rem` k == 0   = [k] ++ divisorsOf (n `div` k) k
  | otherwise        = divisorsOf n (k + 1)

occurrences el list 
  | list == []       = 0
  | el == head list  = 1 + occurrences el (tail list)
  | otherwise        = occurrences el (tail list)

removeDups [] = []
removeDups (x:xs) = [x] ++ removeDups (filter (\el -> el /= x) xs)

divisors::Int->[(Int,Int)]
divisors n = map (\el -> (el, occurrences el divList)) (removeDups divList)
  where divList = divisorsOf n 2