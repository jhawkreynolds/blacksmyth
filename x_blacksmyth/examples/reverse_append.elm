type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

reverse : NatList -> NatList
reverse list =
  case list of
    Nil _ ->
      Nil ()

    Cons (x, xs) ->
      append (reverse xs) (Cons (x, Nil ()))
      
specifyFunction reverse
  [ (Nil (), Nil ())
  , (Cons (Z (), Nil ()), Cons (Z (), Nil ()))
  , (Cons (S (Z ()), Cons (Z (), Nil ())), Cons (Z (), Cons (S (Z ()), Nil ())))
  , (Cons (Z (), Cons (S (Z ()), Cons (Z (), Nil ()))), Cons (Z (), Cons (S (Z ()), Cons (Z (), Nil ()))))
  ]
