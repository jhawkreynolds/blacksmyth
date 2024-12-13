type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

maxplus : Nat -> Nat -> Nat
maxplus m n =
    S ( max m n )

