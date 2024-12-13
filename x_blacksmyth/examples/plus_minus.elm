type Nat = Z () | S Nat

plusminus : Nat -> Nat -> Nat
plusminus a b =
  case a of
    Z _ ->
        plus b 1

    S _ ->
        minus b 1
