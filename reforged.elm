type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

max : Nat -> Nat -> Nat
max a b =
    ??


maxplus : Nat -> Nat -> Nat
maxplus m n =
    S ( max m n )
 
specifyFunction2 maxplus[(0, 1, 2), (1, 2, 3), (2, 1, 3), (0, 0, 1), (3, 1, 4), (1, 1, 2), (0, 3, 4), (2, 0, 3), (3, 0, 4), (2, 3, 4), (0, 2, 3), (3, 3, 4), (2, 2, 3), (1, 0, 2), (3, 2, 4), (1, 3, 4)]

