type Nat = Z () | S Nat

mult : Nat -> Nat -> Nat
mult p q =
  case p of
    Z _ ->
      0

    S p_ ->
      plus q (mult p_ q)

specifyFunction2 mult
  [ (0, 0, 0), (0, 1, 0), (0, 2, 0)
  , (1, 1, 1), (1, 2, 2), (1, 3, 3)
  , (2, 2, 4), (2, 3, 6), (3, 0, 0)
  ]
