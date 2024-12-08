Require Coq.extraction.Extraction.
Extraction Language OCaml.

Inductive AE : Type :=
    | EInt (n:nat)
    | Neg (x:AE)
    | Add (x:AE) (y:AE)
    | Sub (x:AE) (y:AE)
    | Mul (x:AE) (y:AE)
    | Div (x:AE) (y:AE)
    | Hole
.

Inductive ChangelogStatus : Type :=
    | Unchanged
    | Added
    | Removed
    | Modified
.

Inductive Transformation : Type :=
    | L1_to_core
    | Core_to_L2
.

Definition changelogMapping (ae:AE) : ChangelogStatus :=
    match ae with 
    | Num n => Unchanged
    | Add x y => Unchanged
    | Sub x y => Removed
    | Mul x y => Unchanged
    | Div x y => Unchanged
    | Hole => Removed
end.

Definition included (t:Transformation) (ae:AE) : bool :=
    match changelogMapping (ae) with
    | Unchanged => true
    | Added =>
        match t with
        | L1_to_core => false
        | Core_to_L2 => true 
        (* Only allow on second translation *)
        end
    | Removed => false
    | Modified => false
end.

Fixpoint preprocess (t:Transformation) (ae:AE) 
  : AE :=
if included t ae then
    match ae with
    | Num n => Num n
    | Neg x => Neg (preprocess t x)
    | Add x y => Add (preprocess t x) (preprocess t y)
    | Sub x y => Sub (preprocess t x) (preprocess t y)
    | Mul x y => Mul (preprocess t x) (preprocess t y)
    | Div x y => Div (preprocess t x) (preprocess t y)
    | Hole => Hole
    end
else Hole.

Compute preprocess
L1_to_core
(
Add 
    (Num 1) 
    (Sub 
        (Num 1) 
        (Num 1)
    )
    
).


(* Extraction "preprocessor.ml" preprocess. *)