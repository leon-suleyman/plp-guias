--Ejercicio 1

--null (?)
head :: [a] -> a --devuelve el primer valor de la lista
tail :: [a] -> [a] -- devuelve todos los valores menos el primero
init :: [a] -> [a] -- devuelve todos los valores de la lista menos el ultimo
last :: [a] -> a --devuelve el ultimo valor
take :: Int -> [a] -> [a] --devuelve los primeros n valores
drop :: Int -> [a] -> [a] --devuelve la lista sin los primeros n valores
(++) :: [a] -> [a] -> [a] --concatena dos listas
--concat :: Foldable t => t [a] -> [a] (?)
(!!) :: [a] -> Int -> a --devuelve el valor de la posicion n en la lista
--elem :: Eq a => a -> t a -> Bool (?)

--Ejercicio 2

valorAbsoluto :: Float -> Float
valorAbsoluto -x = x
valorAbsoluto x = x 

bisiesto :: Int -> Bool
bisiesto x = 0 == (x mod 4)

factorial:: Int -> Int
factorial 0 = 1
factorial x = x*factorial x-1 --no anda :/ pero es asi

cantDivisoresPrimos :: Int -> Int
