-- Емил Кирилов 61763 СИ
-- Вариант А

import Data.List(maximumBy)
import Data.Ord(comparing)

-- Задача 1 
largestInterval :: (Eq a) => (Int -> a) -> (Int -> a) -> Int -> Int -> (Int, Int)
largestInterval f g a b = toInterval [ x | x <- [a..b], f x == g x]
  where toInterval list = (head list, last list) 

-- *Main> largestInterval (\x->x) (\x->x*x) 0 3
-- (0,1)
-- *Main> largestInterval (\x->x) (\x->x) 0 3
-- (0,3)



-- Задача 2

data Tree a = Empty | Node a (Tree a) (Tree a)
-- без интернет не мога да направя дърветата сравними :с
-- ама така и така всичко ми е на хаскел ...

intervalTree (Node x left right) 
	| (left == Empty) && (right == Empty)  = [x, x]
	| right == Empty                       = (head $ intervalTree left) : [x] 
	| left == Empty                        = x : [last $ intervalTree right]  
	| otherwise                            = (head $ intervalTree left) : [last $ intervalTree right]



-- Задача 3
sumOfSquares :: [Int]
sumOfSquares = [ x*x + y*y | x <- [0..], y <- [0..]]
-- *Main> head sumOfSquares 
-- 0
-- *Main> head $ tail sumOfSquares 
-- 1
-- *Main> take 10 sumOfSquares
-- [0,1,4,9,16,25,36,49,64,81]



-- Задача 4
type Video = (String, Int)

getName (name,_) = name
getLength (_,length) = length

averageVideo :: [Video] -> String
averageVideo list = getName $ maximumBy (comparing getLength) notLongerSubstractAvg 
  where notLonger =  filter (\ vid -> (getLength vid) <= avg) list
  	substractAvg = map (\(n,l) -> (n, l - avg))
  	avg = (sum $ map (\ vid -> getLength vid) list) `div` (length list) 

-- *Main Data.List Data.Ord> averageVideo [("lolcat", 15), ("dogewow", 35), ("omgseethis", 28)]
-- "lolcat"
-- *Main Data.List Data.Ord> averageVideo [("win" ,26), ("lolcat", 15), ("dogewow", 35), ("omgseethis", 28)]
-- "win"
