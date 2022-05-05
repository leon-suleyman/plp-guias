--Ejercicio 1

max2 :: Ord a => (a,a) -> a --No currificado
max2 (x, y) | x >= y = x
            | otherwise = y

normaVectorial :: Floating a => (a, a) -> a --No currificado
normaVectorial (x, y) = sqrt (x^2 + y^2)

subtract :: Num a => a -> a -> a
subtract = flip (-)

predecesor :: Num a => a -> a
predecesor = Main.subtract 1

evaluarEnCero :: Num a => (a -> b) -> b
evaluarEnCero = \f -> f 0

dosVeces :: (a -> a) -> a -> a
dosVeces = \f -> f.f

flipAll :: [(a -> a -> b)] -> [(a -> a -> b)]
flipAll = map flip

flipRaro :: b -> (a -> b -> c) -> a -> c
flipRaro = flip flip 


--Ejercicio 2

curry :: ((a,b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y

-- currryN? No se puede pues las tuplas no se pueden modificar dinamicamente.


--Ejercicio 4

pitagoricas :: [(Integer, Integer, Integer)]
pitagoricas = [(a, b, c) | a <- [1..], b <-[1..a], c <- [1..(a^2 + b^2)], a^2 + b^2 == c^2]


--Ejercicio 5 
esPrimo :: Integer -> Bool
esPrimo n = filter (\x -> mod n x == 0) [1..n] == [1,n]

primerosMilPrimos :: [Integer]
primerosMilPrimos = [n | n <- [1..1000], esPrimo n ]

--Ejercicio 7 

listasQueSuman :: Int -> [[Int]] 
listasQueSuman 1 = [[1]]
listasQueSuman n = map (1:) (listasQueSuman $ n-1) ++ map (\(x:xs) -> x+1:xs)  (listasQueSuman $ n-1)

--Ejercicio 8
todasLasListas :: [[Int]]
todasLasListas = [ xs | n <- [1..], xs <- listasQueSuman n]

--Ejercicio 10
-- I
sumatoria :: Num a => [a] -> a
sumatoria = foldr (+) 0

elemento :: Eq a => a -> [a] -> Bool
elemento a = foldr (\y z-> a == y || z) False
--elemento a = foldl (\y z-> a == z || y) False 

union :: [a] -> [a] -> [a]
union xs ys = foldr (:) ys xs

filtrar :: (a -> Bool) -> [a] -> [a]
filtrar condicion = foldr (\y ys -> if condicion y then y:ys else ys) [] 

mapear :: (a -> b) -> [a] -> [b]
mapear f = foldr (\y ys -> f y : ys) [] 

-- II
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun fcomparacion = foldr1 (\x xs-> if fcomparacion x xs then x else xs)

-- III 
sumasParciales :: Num a => [a] -> [a] 
sumasParciales lista = reverse $ init $ foldl (\xs x -> x + head xs : xs) [0] lista

-- IV
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0 

-- V

sumaAltReversa :: Num a => [a] -> a
sumaAltReversa = foldl (flip (-)) 0

-- VI ...?

-- permutaciones :: [a] -> [[a]]
-- permutaciones =  