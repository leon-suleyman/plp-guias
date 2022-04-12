module Arbol23 where

data Árbol23 a b = Hoja a | Dos b (Árbol23 a b) (Árbol23 a b) | Tres b b (Árbol23 a b) (Árbol23 a b) (Árbol23 a b) deriving Eq

{- Funciones para mostrar el árbol. -}

instance (Show a, Show b) => Show (Árbol23 a b) where
    show = ("\n" ++) . (padTree 0 0 False)

padlength = 5    
    
padTree:: (Show a, Show b) => Int -> Int -> Bool -> (Árbol23 a b)-> String
padTree nivel acum doPad t = case t of 
                  (Hoja x) -> initialPad ++ stuff x
                  (Dos x i d) -> initialPad ++ stuff x ++ 
                                                 pad padlength ++ rec x False i ++ "\n" ++
                                                 rec x True d ++ "\n"
                  (Tres x y i m d) -> initialPad ++ stuff x ++ --(' ':tail (stuff y)) ++
                                                      pad padlength ++ rec x False i ++ "\n" ++
                                                      pad levelPad ++ stuff y ++ pad padlength ++ rec x False m ++ "\n" ++
                                                      rec x True d ++ "\n" 
  where l = length . stuff
        levelPad = (padlength*nivel + acum)
        initialPad = (if doPad then pad levelPad else "")
        rec x = padTree (nivel+1) (acum+l x)

                      
stuff:: Show a => a -> String
stuff x = if n > l then pad (n-l) ++ s else s
  where s = show x
        l = length s
        n = padlength
                      
pad:: Int -> String
pad i = replicate i ' '
              
foldNat::a->(a->a)->Integer->a
foldNat caso0 casoSuc n | n == 0 = caso0
            | n > 0 = casoSuc (foldNat caso0 casoSuc (n-1))
            | otherwise = error "El argumento de foldNat no puede ser negativo."

{- Funciones pedidas. -}

--foldA23::
foldA23 = undefined

--Lista las hojas de izquierda a derecha.
hojas::Árbol23 a b->[a]
hojas = undefined

esHoja::Árbol23 a b->Bool
esHoja = undefined

mapA23::(a->c)->(b->d)->Árbol23 a b->Árbol23 c d
mapA23 = undefined

--Ejemplo de uso de mapA23.
--Incrementa en 1 el valor de las hojas.
incrementarHojas::Num a =>Árbol23 a b->Árbol23 a b
incrementarHojas = mapA23 (+1) id


--Trunca el árbol hasta un determinado nivel. Cuando llega a 0, reemplaza el resto del árbol por una hoja con el valor indicado.
--Funciona para árboles infinitos.
truncar::a->Integer->Árbol23 a b->Árbol23 a b
truncar = undefined

--Evalúa las funciones tomando los valores de los hijos como argumentos.
--En el caso de que haya 3 hijos, asocia a izquierda.
evaluar::Árbol23 a (a->a->a)->a
evaluar = undefined
