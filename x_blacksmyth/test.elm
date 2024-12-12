type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

maxplus : Nat -> Nat -> Nat
maxplus m n =
    S ( max m n )

specifyFunction2 maxplus[
    (0,0,1), (1,0,2), (0,1,2), (1,1,2), (2,1,3), (1,2,3), (2,2,3),
    (3,4,5), (4,3,5)
]