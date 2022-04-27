import GHC.Natural (isValidNatural)
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

--ej2
curry :: ((a,b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x,y) = f x y

--No que yo sepa, porque hay que saber cuantos parametros hay que ver

--ej3
--[1,2,3]

--ej4
--no nos funciona ya que siempre va a estár buscando un 'c' para el primer 'a' y 'b'
pitagoricas = [(a,b,sqrt(a^2 + b^2)) | a <- [1..], b <-[1..a], c <- [1..(a^2+b^2)/2], c^2 == a^2 + b^2]

--ej5
isPrime :: Integer -> Bool
isPrime n = all notDividedBy [2 .. n `div` 2]
  where
    notDividedBy m = n `mod` m /= 0
primerosMilPrimos = take 1000 [x | x <- [1..], isPrime x]

--ej7

listasQueSuman :: Int -> [[Int]]
listasQueSuman 1 = [[1]]
listasQueSuman n = let listas = listasQueSuman (n-1) in
                    [n] : map (1:) listas ++ map (\xs -> head xs +1 : tail xs) listas

--ej8
listasFinitasDeEnteros = [ xs | n <- [1..], xs <- listasQueSuman n]

--ej10
--I
foldSum :: [Integer] -> Integer
foldSum = foldr (+) 0

foldElem :: Int -> [Int] -> Int
foldElem n = foldr const 0 . take n 

foldConcat :: [a] -> [a] -> [a]
foldConcat = flip $ foldl (flip (:))

--foldFilter y Map hechas en clase

--II
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun cmp = foldr1 (\x rec -> if cmp x rec then x else rec)

--III
sumasParciales :: Num a => [a] -> [a]
sumasParciales = foldr (\x rec -> x : map (+x) rec) []

--IV
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

--V
sumaAltReverse :: Num a => [a] -> a
sumaAltReverse = foldl (-) 0

--VI 
permutaciones :: [a] -> [[a]]
permutaciones = foldr (\x rec -> if null rec then [[x]] else concatMap (\xs -> [x:xs, xs ++ [x]] ) rec) []


--ej12
--entrelazar no es recursión estructural, ya que debe hacer recursión sobre dos estructuras al mismo tiempo.
--elemtos en posiciones pares, si lo es, pero se debe usar recr

--ej13
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

--a hecho en clase
--b porque necesitamos devolver la cola de la lista al encontrar la primera aparición y no tenemos forma de distinguir la primera de una segunda
--c 
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado a = recr (\x xs rec -> if x < a then x : rec else a : x : xs) [a]

--d no, porque no necesita evaluar la cola xs 
