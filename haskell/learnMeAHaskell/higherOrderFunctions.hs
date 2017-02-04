zip' :: [a] -> [b]-> [(a,b)]
zip' _ []    = []
zip' [] _    = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _           = []
zipWith' _ _ []          = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f x y = f y x