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
numLongChains = length $ filter (\ xs -> length xs > 15) $ map chain [1..100]
--numLongChains = length (filter isLong (map chain [1..100]))
    --where isLong xs = length xs > 15

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldr (\ x acc -> if x == y then True else acc) False ys

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 max

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []
--reverse' = foldl (\ acc x -> x : acc) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\ x acc -> if p x then x : acc else acc) []

sqrtSums :: Int
sqrtSums = (length . takeWhile (<1000) . scanl1 (+) $ map sqrt [1..]) + 1 --scanl1 will count the first 2 elements for one

--ghci> map ($ 3) [(4+), (10*), (^2), sqrt]
--[7.0,30.0,9.0,1.7320508075688772]

negateAll :: (Num a) => [a] -> [a]
negateAll list = map (negate . abs) list