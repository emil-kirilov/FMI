data Tree a = Empty | Node a (Tree a) (Tree a)

flattenTree :: Tree a -> [a]
flattenTree Empty = []
flattenTree (Node x left right) = flattenTree left ++ [x] ++ flattenTree right

instance Show a => Show (Tree a) where
  show tree = show $ flattenTree tree

leftOf::[Int]->[Int]
leftOf list = leftOf' list ((length list) `div` 2) 

leftOf'::[Int]->Int->[Int]
leftOf' list length
  | length <= 0   = []
  | otherwise     = [head list] ++ leftOf' (tail list) (length - 1)
  
rightOf::[Int]->[Int]
rightOf list = reverse $ leftOf' (reverse list) ((length list) `div` 2)

fenwick::[Int]->Tree Int
fenwick list 
  | length list >= 1   = Node (sum (list)) (fenwick (leftOf list)) (fenwick (rightOf list))
  | otherwise          = Empty