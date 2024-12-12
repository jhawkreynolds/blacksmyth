type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

mapplus : NatList -> NatList
mapplus x =
    case x of
        Nil _ ->
        Nil

        Cons (x, xs) ->
        Cons( plus x 1, mapplus xs)