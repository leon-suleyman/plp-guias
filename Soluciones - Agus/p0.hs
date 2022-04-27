--Ejercicio 1

-- null :: Foldable t => t a -> Bool --dado un dato foldable devuelve si es o no nulo
-- head :: [a] -> a --devuelve el primer valor de la lista
-- tail :: [a] -> [a] -- devuelve todos los valores menos el primero
-- init :: [a] -> [a] -- devuelve todos los valores de la lista menos el ultimo
-- last :: [a] -> a --devuelve el ultimo valor
-- take :: Int -> [a] -> [a] --devuelve los primeros n valores
-- drop :: Int -> [a] -> [a] --devuelve la lista sin los primeros n valores
-- (++) :: [a] -> [a] -> [a] --concatena dos listas
-- concat :: Foldable t => t [a] -> [a] --concatena las listas dentro de t en una sola lista
-- (!!) :: [a] -> Int -> a --devuelve el valor de la posicion n en la lista
-- elem :: Eq a => a -> t a -> Bool --dado un elemento y un contenedor(?) de ese tipo de elementos, devuelve si se encuentra en él o no

--Ejercicio 2

-- valorAbsoluto :: Float -> Float
-- valorAbsoluto (-x) = x
-- valorAbsoluto x = x 

bisiesto :: Int -> Bool
bisiesto x = 0 == mod x 4

factorial:: Int -> Int
factorial 0 = 1
factorial x = x*factorial x-1 --no anda :/ pero es asi

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos x = length (filter (\y -> mod x y == 0) [2,3,5,7,11]) 

--Ejercicio 3

inverso :: Float -> Maybe Float 
inverso 0 = Nothing 
inverso x = Just (1/x)

aEntero :: Either Int Bool -> Int
aEntero (Left x) = x
aEntero (Right True) = 1
aEntero (Right False) = 0

--Ejercicio 4

limpiar :: String -> String -> String
limpiar x = filter (`notElem` x)

difPromedio :: [Float] -> [Float]
difPromedio xs = map (\x -> x - (sum xs /  fromIntegral (length xs))) xs

-- todosIguales :: [Int] -> Bool
-- todosIguales [] = True
-- todosIguales (x:xs) = (fromIntegral sum (x:xs)) / fromIntegral (length (x:xs)) == x 

--Ejercicio 5 

data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool 
vacioAB Nil = True 
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool 
negacionAB Nil = Nil
negacionAB (Bin a1 r a2) = Bin (negacionAB a1) (not r) (negacionAB a2)

productoAB :: AB Int -> Int 
productoAB Nil = 1
productoAB (Bin a1 r a2) = productoAB a1 * r * productoAB a2