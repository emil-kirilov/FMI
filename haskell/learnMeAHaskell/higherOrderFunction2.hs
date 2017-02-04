map' :: (a -> b) -> [a] -> [b]
map' _ []     = []
map' f (x:xs) = f x : map' f xs

quicksort :: (Ord a) => [a] -> [a]
quicksort []      = []
quicksort (x:xs) =
    let smallerOrEqual = filter (<= x) xs
        bigger = filter (> x) xs
    in quicksort smallerOrEqual ++ [x] ++ quicksort bigger 

chain :: Int -> [Int]
chain 1 = [1]
chain n
    | even n     = n : chain (n `div` 2)
    | otherwise  = n : chain (n * 3 + 1)

numLongChains :: Int
numLongChains = length (filter (\ xs -> length xs > 15) (map chain [1..100]))
--numLongChains = length (filter isLong (map chain [1..100]))
    --where isLong xs = length xs > 15

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldr (\ x acc -> if x == y then True else acc) False ys

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 max