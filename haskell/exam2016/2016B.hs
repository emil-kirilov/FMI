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