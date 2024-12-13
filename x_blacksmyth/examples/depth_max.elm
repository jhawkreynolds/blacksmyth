type Nat = Z () | S Nat
type NatTree = Leaf () | Node (NatTree, Nat, NatTree)

depth : NatTree -> Nat
depth tree =
  case tree of
    Leaf _ ->
      S (Z ())

    Node (left, _, right) ->
      S (max (depth left) (depth right)) 

specifyFunction depth
  [ (Leaf (), S (Z ()))
  , (Node (Leaf (), 10, Leaf ()), S (S (Z ())))
  , (Node (Node (Leaf (), 20, Leaf ()), 30, Leaf ()), S (S (S (Z ()))))
  , (Node (Leaf (), 40, Node (Leaf (), 50, Leaf ())), S (S (S (Z ()))))
  ]
