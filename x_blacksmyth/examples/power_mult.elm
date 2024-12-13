type Nat = Z () | S Nat

power : Nat -> Nat -> Nat
power base exp =
  case exp of
    Z _ ->
      S (Z ()) -- Base case: anything to the power of 0 is 1

    S exp_ ->
      mult base (power base exp_) -- Missing `mult` call

specifyFunction power
  [ (0, 0, 1)  -- 0^0 is conventionally defined as 1
  , (1, 0, 1)  -- 1^0 = 1
  , (2, 0, 1)  -- 2^0 = 1
  , (2, 1, 2)  -- 2^1 = 2
  , (2, 2, 4)  -- 2^2 = 4
  , (2, 3, 8)  -- 2^3 = 8
  , (3, 2, 9)  -- 3^2 = 9
  , (3, 3, 27) -- 3^3 = 27
  , (4, 2, 16) -- 4^2 = 16
  ]
