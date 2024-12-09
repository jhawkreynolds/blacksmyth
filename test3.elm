type Nat = Z () | S Nat

mult : Nat -> Nat -> Nat
mult p q =
  case p of
    Z _ ->
      0

    S p_ ->
      plus q (mult p_ q)

specifyFunction2 mult
  [ (2, 1, 2), (3, 2, 6), (0, 2, 0)
  , (1, 4, 4), (2, 2, 4), (3, 2, 6)
  , (1, 1, 1), (3, 3, 9), (2, 4, 8)
  ]