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
foldA23 :: (a -> c) -> (b -> c -> c -> c) -> (b -> b -> c -> c -> c -> c) -> Árbol23 a b -> c
foldA23 casoHoja casoDos casoTres arbol = case arbol of
                                            Hoja a -> casoHoja a
                                            Dos b1 ab1 ab2 -> casoDos b1 (rec ab1) (rec ab2)
                                            Tres b1 b2 ab1 ab2 ab3 -> casoTres b1 b2 (rec ab1) (rec ab2) (rec ab3)
                                            where rec = foldA23 casoHoja casoDos casoTres

--Lista las hojas de izquierda a derecha.
hojas::Árbol23 a b -> [a]
hojas = foldA23 (\a -> [a]) (\_ ls1 ls2 -> ls1 ++ ls2) (\_ _ ls1 ls2 ls3 -> ls1 ++ ls2 ++ ls3)

esHoja::Árbol23 a b->Bool
esHoja = foldA23 (const True) (\_ _ _ -> False) (\_ _ _ _ _ -> False) 

mapA23::(a->c)->(b->d)->Árbol23 a b->Árbol23 c d
mapA23 f g = foldA23 (\a -> Hoja (f a)) (\b1 ab1 ab2 -> Dos (g b1) ab1 ab2) (\b1 b2 ab1 ab2 ab3 -> Tres (g b1) (g b2) ab1 ab2 ab3)  

--Ejemplo de uso de mapA23.
--Incrementa en 1 el valor de las hojas.
incrementarHojas::Num a =>Árbol23 a b->Árbol23 a b
incrementarHojas = mapA23 (+1) id


--Trunca el árbol hasta un determinado nivel. Cuando llega a 0, reemplaza el resto del árbol por una hoja con el valor indicado.
--Funciona para árboles infinitos.
applyFunctionToBranches :: (Árbol23 a b -> Árbol23 a b) -> Árbol23 a b -> Árbol23 a b
applyFunctionToBranches f ab = case ab of 
                                  Hoja a -> Hoja a
                                  Dos b1 ab1 ab2 -> Dos b1 (f ab1) (f ab2)
                                  Tres b1 b2 ab1 ab2 ab3 -> Tres b1 b2 (f ab1) (f ab2) (f ab3) 

truncar::a->Integer->Árbol23 a b->Árbol23 a b
truncar value n  = foldNat ( \_ -> Hoja value) (applyFunctionToBranches) n

--Evalúa las funciones tomando los valores de los hijos como argumentos.
--En el caso de que haya 3 hijos, asocia a izquierda.
evaluar::Árbol23 a (a->a->a)->a
evaluar = foldA23 (\a -> a) (\f1 res1 res2 -> f1 res1 res2) (\f1 f2 res1 res2 res3 -> f2 (f1 res1 res2) res3)
