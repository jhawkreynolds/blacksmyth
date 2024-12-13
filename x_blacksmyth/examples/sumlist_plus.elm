type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

sumList : NatList -> Nat
sumList list =
  case list of
    Nil _ ->
      Z ()

    Cons (x, xs) ->
      plus x (sumList xs) -- Missing `plus` call

specifyFunction sumList
  [ (Nil (), Z ())
  , (Cons (Z (), Nil ()), Z ())
  , (Cons (S (Z ()), Cons (Z (), Nil ())), S (Z ()))
  , (Cons (S (S (Z ())), Cons (S (Z ()), Nil ())), S (S (S (Z ()))))
  , (Cons (S (S (Z ())), Cons (S (S (Z ())), Cons (Z (), Nil ()))), S (S (S (S (Z ())))))
  ]
