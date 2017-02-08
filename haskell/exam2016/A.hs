import Data.List (maximumBy, delete)
import Data.Ord (comparing)

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

--Задача 2
check' :: Int -> Int -> [(Int -> Int)] -> [(Int -> Int -> Int)] -> Bool
check' a b uns bins = any id [ matches (combine f g h) ff [a..b] | f <- uns, g <- uns, h <- bins, ff <- uns ]
  where matches f1 f2 range = all (\x -> f1 x == f2 x) range


--Задача 3 - Емо
--maxPath [[1,2,4],[2,3],[3,2],[4]] 1 → [1,2,3]
type Graph = [[Int]]

--all the vertices
vertices :: Graph -> [Int]
vertices g = map head g

--all the neighbours of a given vertex
neighbours :: Graph -> Int -> [Int]
neighbours g v = tail $ head [ list | list <- g, (head list) == v]

--given a lists of paths the function returns the longest path 
maxLength :: [[Int]] -> [Int]
maxLength = maximumBy $ comparing length

maxPath :: Graph -> Int -> [Int]
maxPath graph u = maxPathHelper graph [u] (delete u (vertices graph))

maxPathHelper :: Graph -> [Int] -> [Int] -> [Int]
maxPathHelper graph path unused = if null possibiles then path else maxLength possibiles 
  where possibiles = [ maxPathHelper graph (path ++ [u]) (delete u unused) | u <- unused, canBeInPath u]
        canBeInPath u = u `elem` (neighbours graph (last path))