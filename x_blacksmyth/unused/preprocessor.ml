
type bool =
| True
| False

type nat =
| O
| S of nat

type aE =
| Num of nat
| Add of aE * aE
| Sub of aE * aE
| Hole

type changelogStatus =
| Unchanged
| Added
| Removed
| Modified

type transformation =
| L1_to_core
| Core_to_L2

(** val changelogMapping : aE -> changelogStatus **)

let changelogMapping = function
| Num _ -> Unchanged
| Add (_, _) -> Unchanged
| _ -> Removed

(** val included : transformation -> aE -> bool **)

let included t ae =
  match changelogMapping ae with
  | Unchanged -> True
  | Added -> (match t with
              | L1_to_core -> False
              | Core_to_L2 -> True)
  | _ -> False

(** val preprocess : transformation -> aE -> aE **)

let rec preprocess t ae = match ae with
| Num n -> (match included t ae with
            | True -> Num n
            | False -> Hole)
| Add (x, y) ->
  (match included t ae with
   | True -> Add ((preprocess t x), (preprocess t y))
   | False -> Hole)
| Sub (x, y) ->
  (match included t ae with
   | True -> Sub ((preprocess t x), (preprocess t y))
   | False -> Hole)
| Hole -> Hole
