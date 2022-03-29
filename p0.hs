import Data.Bitraversable (Bitraversable)
--ej 2

valorAbsoluto x = if x<0 then -x else x

bisiesto year = year mod 4 == 0

factorial 0 = 1
factorial 1 = 1
factorial x = x * factorial (x-1)

--ej 3 

--a 
inverso :: float -> Maybe float
inverso 0.0 = Nothing
inverso fl = 1/fl --what

--b
aEntero :: Either Int Bool -> int
aEntero False = 0
aEntero True = 1
aEntero x = x