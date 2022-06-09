
{-
Ejercicio 1

a Si, b Si, c No, d No, e Si,f Si, g No, h Si, i Si, j No?, k No?, l No?, m No?, n No?, ñ No?, o No, p Si

Probablemente esté mal hecho

Ejercicio 3

a las ultimas dos x
b No
c Si?

Ejercicio 4 

I.
a. (((u x) (y z)) (\v: Bool. v y))

b. ((((\x: Bool -> Nat -> Bool. \y: Bool -> Nat. \z: Bool. x z (y z)) u) v) w)

c. (((w (\x: Bool -> Nat -> Bool. \y: Bool -> Nat. \z: Bool. x z (y z))) u) v)

II. En la tablet (pendiente)
III. En la tablet (pendiente)
IV. En el b

Ejercicio 5

a  vacio => if true then 0 else succ(0) : if Bool then Nat else Nat -> Nat
         => 0 : Nat

b {x : Nat, y : Bool} => if true then false else (\z : Bool. z) true : if Bool then Bool else (Bool -> Bool) -> Bool -> Bool
                      => false : Bool

c vacio => if (\x : Bool. x) then 0 else succ(0) : if (Bool -> Bool) then Nat else (Nat -> Nat) No se puede demostrar porque Bool -> Bool no es de tipo Bool

d {x : Bool -> Nat, y : Bool} => x y : (Bool -> Nat) -> Nat -> Nat
                              => Nat            


Ejercicio 7


-}