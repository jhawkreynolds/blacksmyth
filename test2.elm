type Nat = Z () | S Nat
type NatList = Nil () | Cons (Nat, NatList)

type NatTree = Leaf () | Node (NatTree, Nat, NatTree)

append : NatList -> NatList -> NatList
append xs ys =
  case xs of
    Nil _ ->
      ys
    Cons (head, tail) ->
      Cons (head, append tail ys)

leaves : NatTree -> NatList
leaves tree =
  case tree of
    Leaf _ ->
      []

    Node (left, x, right) ->
      ??

specifyFunction leaves
  [ ( Node
        ( Node (Leaf (), 10, Leaf ())
        , 20
        , Leaf ()
        )
    , [10, 20]
    )
  , ( Node
        ( Leaf ()
        , 10
        , Node (Leaf (), 20, Leaf ())
        )
    , [10, 20]
    )
  ]