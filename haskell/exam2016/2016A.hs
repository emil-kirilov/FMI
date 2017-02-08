--Задача 1 - Емо
transpose:: [[a]]->[[a]]
transpose ([]:_) = []
transpose x = (map head x) : transpose (map tail x)

equalColRow :: [Int] -> [Int] -> Bool
equalColRow col row
  | col == []      = True
  | otherwise      = elem (head col) row && equalColRow (tail col) row

findColums :: [[Int]] -> Int
findColums matrix = sum $ map sum $ map (\col -> isItThere col) (transpose matrix)
  where isItThere col = map (\ row -> if equalColRow col row then 1 else 0) matrix

-- Задача 1
equalColAll :: [Int] -> [[Int]] -> Bool
equalColAll col matrix = any (\row -> all (`elem` row) col) matrix

findColums' :: [[Int]] -> Int
findColums' matrix = length [col | col <- transpose matrix , equalColAll col matrix] 

--Задача 2 - Емо 
combine :: (a -> b) -> (a -> c) -> (b -> c -> d) -> (a -> d)
combine f g h = \x -> h (f x) (g x)

check :: Int -> Int -> [(Int -> Int)] -> [(Int -> Int -> Int)] -> Bool
check from to uns bins = any id [ areSame (combine f g h) ff | f <- uns, g <- uns, h <- bins, ff <- uns ]
  where areSame f g = all (\ value -> f value == g value) [from..to]

--задача 2
check' :: Int -> Int -> [(Int -> Int)] -> [(Int -> Int -> Int)] -> Bool
check' a b uns bins = any id [ matches (combine f g h) ff [a..b] | f <- uns, g <- uns, h <- bins, ff <- uns ]
  where matches f1 f2 range = all (\x -> f1 x == f2 x) range






  