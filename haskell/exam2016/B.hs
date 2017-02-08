import Data.List (maximumBy)
import Data.Ord (comparing)

--Задача 1 - Дидо
transpose:: [[a]]->[[a]]
transpose ([]:_) = []
transpose x = (map head x) : transpose (map tail x)

hasColumn :: [[Int]] -> Int
hasColumn m = length [ row | row <- m, equalsRowAll row (transpose m)] 
  where equalsRowAll row m = any (\list -> all (`elem` list) row) m

--Задача 2 - Емо
combine :: (a -> c -> d) -> (a -> b -> c) -> (a -> b) -> (a -> d)
combine f g h = \ x -> f x $ g x $ h x
--combine f g h = \x -> f x (g x (h x))

check :: Int -> Int -> [(Int->Int)] -> [(Int->Int->Int)] -> Bool
check from to uns bins = any id [ areSame (combine f g h) ff | f <- bins, g <- bins, h <- uns, ff <- uns]
  where areSame f g = all (\ x -> f x == g x) [from..to]

--Задача 3
--maxCycle [[1,2],[2,3],[3,1,4],[4,2]] 1 → [1,2,3,1]
type Graph = [[Int]]

--all the vertices
vertices :: Graph -> [Int]
vertices g = map head g

--all the neighbours of a given vertex
neighbours :: Int -> Graph -> [Int]
neighbours v g = tail $ head [ list | list <- g, (head list) == v]

--given a lists of paths the function returns the longest path 
maxLength :: [[Int]] -> [Int]
maxLength = maximumBy $ comparing length

-- генериране на всички пътища в граф (!)
allPaths :: Graph -> [[Int]]
allPaths g = concat [ allPathsStartingWith [v] g | v<-(vertices g) ]

allPathsStartingWith :: [Int] -> Graph -> [[Int]]
allPathsStartingWith path g = path : concat [ allPathsStartingWith newPath g | newPath<-allExpansions]
  where allExpansions = [ path ++ [u] | u<-(vertices g), not $ u `elem` path, u `elem` (neighbours (last path) g) ]

maxCycle :: Graph -> Int -> [Int]
maxCycle g v = maxLength [ p++[v] | p<-allPaths g, v == head p, v `elem` (neighbours (last p) g) ]