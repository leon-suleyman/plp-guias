--ej1
--I
{-
    max2 :: (Float, Float) -> Float
    normalVectorial :: (Float, Float) -> Float
    substract :: Float -> Float -> Float 
    predecesor :: Float -> Float
    evaluarEnCero :: (Float -> Float) -> Float
    flipAll :: [a -> b -> c] -> [b -> a -> c]
    flipRaro :: (a -> b -> c) -> (b -> a -> c)
-}

--II
{-
    max2 :: Float -> Float -> Float
    max2 x y | x=>y = x
             | otherwise = y
    
    normalVectorial :: Float -> Float -> Float
    normalVectorial x y = sqrt(x^2 + y^2)
    
-}