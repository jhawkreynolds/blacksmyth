type Nat
  = Z ()
  | S Nat

type List a
  = Nil ()
  | Cons (a, List a)

listSnoc : List a -> a -> List a
listSnoc <a> xs n =
  ??
