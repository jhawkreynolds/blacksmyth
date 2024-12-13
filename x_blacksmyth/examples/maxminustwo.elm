type Nat  = Z ()  | S Nat

maxminustwo: Nat -> Nat -> Nat
maxminustwo m n =
    minus (max m n) 2


specifyFunction2 maxminustwo
  [ (3, 4, 2), (2, 1, 0), (2, 2, 0)
  , (5, 6, 4), (5, 3, 3), (3, 1, 1)
  , (3, 3, 1), (2, 1, 0), (2, 4, 2)
  ] 