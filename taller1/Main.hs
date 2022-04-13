import Arbol23
import Diccionario
import Data.Maybe
import Test.HUnit


{- Árboles de ejemplo. -}
arbolito1::Árbol23 Char Integer
arbolito1 = Tres 0 1
            (Dos 2 (Hoja 'a') (Hoja 'b'))
            (Tres 3 4 (Hoja 'c') (Hoja 'd') (Dos 5 (Hoja 'e') (Hoja 'f')))
            (Dos 6 (Hoja 'g') (Dos 7 (Hoja 'h') (Hoja 'i')))

arbolito2::Árbol23 Integer Bool
arbolito2 = Dos True (Hoja (-1)) (Tres False True (Hoja 0) (Hoja (-2)) (Hoja 4))

arbolito3::Árbol23 Integer (Integer->Integer->Integer)
arbolito3 = Dos (+) (Tres (*) (-) (Hoja 1) (Hoja 2) (Hoja 3)) (incrementarHojas arbolito3)

arbolA::Árbol23 Char Integer
arbolA = Hoja 'a'


{- Diccionarios de prueba: -}

dicc1::Diccionario Integer String
dicc1 = definirVarias [(0,"Hola"),(-10,"Chau"),(15,"Felicidades"),(2,"etc."),(9,"a")] (vacío (<))

dicc2::Diccionario String String
dicc2 = definirVarias [("inicio","casa"),("auto","flores"),("calle","auto"),("casa","escalera"),("ropero","alfajor"),("escalera","ropero")] (vacío (<))

dicc3::Diccionario Integer String
dicc3 = definirVarias [(0,"Hola"),(-10,"Chau"),(15,"Felicidades"),(2,"etc."),(9,"a")] (vacío (\x y->x `mod` 5 < y `mod` 5))

{- Función de prueba: -}

búsquedaDelTesoro::Eq a=>a->(a->Bool)->Diccionario a a->Maybe a 
búsquedaDelTesoro pistaInicial esTesoro d = let maybepistas = iterate (\mp->mp >>= \p->obtener p d) (Just pistaInicial) in foldr1 (\mp res -> mp >>= \p->if esTesoro p then mp else res) maybepistas
                        

tests :: IO Counts
tests = do runTestTT allTests

allTests = test [
  "ejercicio1" ~: testsEj1,
  "ejercicio2" ~: testsEj2,
  "ejercicio3" ~: testsEj3,
  "ejercicio4" ~: testsEj4,
  "ejercicio5" ~: testsEj5,
  "ejercicio6" ~: testsEj6,
  "ejercicio7" ~: testsEj7
  ]

testsEj1 = test [
  [True,False,True] ~=? foldA23 (const []) (\n a1 a2->n:a1++a2) (\n1 n2 a1 a2 a3->n1:(n2:a1)++a2++a3) arbolito2,
  4 ~=? 2*2
  ]
  
testsEj2 = test [
  "a" ~=? hojas arbolA,
  "abcdefghi" ~=? hojas arbolito1,
  [1,2,3,2,3,4,3,4,5,4] ~=? take 10 (hojas arbolito3),
  False ~=? esHoja arbolito1
  ]

testsEj3 = test [
  [0,1,-1,5] ~=? hojas (incrementarHojas arbolito2),
  4 ~=? 2*2
  ]

testsEj4 = test [
  hojas (truncar 0 6 arbolito3) ~=? [1,2,3,2,3,4,3,4,5,4,5,6,0,0,0,0,0],
  4 ~=? 2*2
  ]

testsEj5 = test [
  22 ~=? evaluar (truncar 0 6 arbolito3), --(1*2-3)+(2*3-4)+(3*4-5)+(4*5-6)
  4 ~=? 2*2
  ]

testsEj6 = test [
  False ~=? esVacío (definir 0 "Hola" (vacío (<))),
  4 ~=? 2*2
  ]

testsEj7 = test [
  Just "alfajor" ~=? búsquedaDelTesoro "inicio" ((=='a').head) dicc2,
  4 ~=? 2*2
  ]
