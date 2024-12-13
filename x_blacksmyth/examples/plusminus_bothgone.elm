type Nat = Z () | S Nat

plusminus : Nat -> Nat -> Nat
plusminus a b =
  case a of
    Z _ ->
        plus b 1 -- Add 1 to b (missing `plus` function)

    S _ ->
        minus b 1 -- Subtract 1 from b (missing `minus` function)

specifyFunction2 plusminus
  [ (0, 0, 1)  -- plusminus(0, 0) = 1
  , (0, 1, 2)  -- plusminus(0, 1) = 2
  , (1, 1, 0)  -- plusminus(1, 1) = 0
  , (1, 2, 1)  -- plusminus(1, 2) = 1
  , (2, 3, 2)  -- plusminus(2, 3) = 2
  , (0, 5, 6)  -- plusminus(0, 5) = 6
  , (3, 3, 2)  -- plusminus(3, 3) = 0
  ]
