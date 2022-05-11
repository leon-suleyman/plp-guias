
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


--Ejercicio 12 ???

elementosEnPosicionesPares :: [a] -> [a] --No es estructural pero no se justificarlo
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs then [x]
                                    else x:elementosEnPosicionesPares (tail xs)


entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys then x:(entrelazar xs [])
                           else x:head ys:entrelazar xs (tail ys)


--Ejercicio 13

--a
recr::(a->[a]->b->b)->b->[a]->b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna x = recr (\y ys recu -> if x == y then ys else y:recu) []

--b 

-- Porque foldr no brinda acceso al resto de la lista en cada recursion

--c 
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado x = recr (\y ys recu -> if x < y then x:(y:ys) else y:recu) []

--d
-- No porque no se hace recursion sobre una lista

--Ejercicio 15

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (Main.uncurry f)

armarPares :: [a] -> [b] -> [(a,b)]
-- armarPares [] _ = []
-- armarPares _ [] = []
-- armarPares (x:xs) (y:ys) = (x,y) : armarPares xs ys

armarPares = foldr (\x recu ys -> if null ys then [] else (x,head ys) : recu (tail ys) ) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f $ armarPares xs ys


--Ejercicio 17

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
-- generateFrom stop next xs | stop xs = init xs
--                           | otherwise = generateFrom stop next (xs ++ [next xs])

generateFrom stop next xs = last $ takeWhile (not.stop) $ iterate (\xs ->  xs ++ [next xs]) xs


generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop base next = generate stop (\xs -> if null xs then base else next $ last xs)

factoriales :: Int -> [Int]
factoriales n = generate (\xs -> length xs > n) (\xs -> if null xs then 1 else (length xs + 1)* last xs)

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase (\xs -> length xs > n) x f


--Ejercicio 18

foldNat :: Integer -> (Integer -> b -> b) -> b -> b
foldNat 0 _ z = z
foldNat n f z = f n (foldNat (n-1) f z )

potencia :: Integer -> Integer -> Integer
potencia b e = foldNat e (\_ p -> b * p) 1

--Ejercicio 20

type Conj a = (a -> Bool)

vacio :: Conj a
vacio = const False

agregar :: Eq a => a -> Conj a -> Conj a
agregar e c = \x -> x == e || c x

interseccion :: Conj a -> Conj a -> Conj a
interseccion c1 c2 = \e -> c1 e && c2 e

unionConj :: Conj a -> Conj a -> Conj a
unionConj c1 c2 = \e -> c1 e || c2 e

conjFuncInf :: Conj (Integer -> Integer)
conjFuncInf f = f 0 == 0

singleton :: Eq a => a -> Conj a
singleton e = \x -> x == e

--No se puede definir un map para Conj porque habría que poder computar la función inversa de la función que se quiere aplicar a los elementos del conjunto
--para evaluarla y ver si el elemento que se quiere ver si está en el nuevo conjunto tiene una preimagen en el conjunto original.

--Ejercicio 22

data AHD tInterno tHoja = Hoja tHoja
                          | Rama tInterno (AHD tInterno tHoja)
                          | Bin (AHD tInterno tHoja) tInterno (AHD tInterno tHoja)

foldAHD :: (tH -> b) -> (tI -> b -> b) -> (b -> tI -> b -> b) -> AHD tI tH -> b
foldAHD fHoja fRama fBin arbol = case arbol of   Hoja tH -> fHoja tH
                                                 Rama tI ahd -> fRama tI (rec ahd)
                                                 Bin ahd tI ahd' -> fBin (rec ahd) tI (rec ahd')
                                 where rec = foldAHD fHoja fRama fBin

mapAHD :: (a -> b) -> (c -> d) -> AHD a c -> AHD b d
mapAHD fInterno fHoja = foldAHD (\tH -> Hoja (fHoja tH)) (\tI ahd -> Rama (fInterno tI) ahd) (\ahd tI ahd' -> Bin ahd (fInterno tI) ahd')
