hailstone::Integer->[Integer]

hailstone n 
  | n <= 0             = []
  | n == 1             = [1]
  | n `rem` 2 ==  1    = n : hailstone ((3 * n) + 1) 
  | otherwise          = n : hailstone (n `div` 2)