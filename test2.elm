type Nat     = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)
type Cmp     = LT () | EQ () | GT ()


insert : NatList -> Nat -> NatList
insert xs n =
  case xs of
    Nil _ ->
      [n]

    Cons (head, tail) ->
      case compare head n of
        LT y1 -> 
          Cons (head, insert tail n)

        GT y1 -> 
          Cons (n, xs)

        EQ y1 -> 
          xs

specifyFunction2 insert
  [ ([1], 1, [1])
  , ([1], 2, [1, 2])
  , ([2], 0, [0, 2])
  , ([1, 2, 4], 3, [1, 2, 3, 4])
  ]