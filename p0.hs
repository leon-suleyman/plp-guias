import Data.Bitraversable (Bitraversable)
import Distribution.Compat.Lens (_1)
import Data.List (genericLength)
--ej 2

valorAbsoluto x = if x<0 then -x else x

bisiesto year = year mod 4 == 0

factorial 0 = 1
factorial 1 = 1
factorial x = x * factorial (x-1)

--ej 3 

--a 
inverso 0.0 = Nothing
inverso fl = Just (1/fl) 

--b
aEntero (Left False) = 0
aEntero (Left True) = 1
aEntero (Right x) = x

--ej 4
--a
limpiar _ [] = []
limpiar [] xs = xs
limpiar (x:xs) ys = limpiar xs (filter (/= x) ys)

--b
difPromedio :: [Float] -> [Float]
difPromedio [] = []
difPromedio xs = let average = sum xs / genericLength xs
                 in map (flip (-) average) xs

--c
todosIguales [] = True 
todosIguales (x:xs) = filter (/=x) xs == []

--ej 5
data AB a = Nil | Bin (AB a) a (AB a)

--a 
vacioAB :: AB a -> Bool
vacioAB Nil = True 
vacioAB _ = False

--b
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (arbolL True arbolR) = negacionAB arbolL False negacionAB arbolR
negacionAB (arbolL False arbolR) = negacionAB arbolL True negacionAB arbolR

--c
productoAB Nil = 1
productoAB (arbolL x arbolR) = x * prouctoAB arbolL * productoAB arbolR
