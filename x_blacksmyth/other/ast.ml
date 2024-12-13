
open Printf

type expr =
  | ENil
  | EFunc   of string
  | TypeLine of string
  | OtherLine of string
(* 
This expr type recycled from previous stage with new constructors. 
We have a construct for TypeLines (lines that start with a type declaration)
and for OtherLines (every other line of code).
*)

let rec pprint_expr = function
  | ENil -> sprintf "ENil"
  | EFunc(x) -> sprintf "" ^ x ^ ""
  | TypeLine(x) -> sprintf "" ^ x ^ ""
  | OtherLine(x) -> sprintf "" ^ x ^ ""
(*
Printing is simpler for this, as we just want to print the line as is.
sprintf x seems to cause a type error on compilation,
which is why this eyesore sprintf "" ^ x ^ "" is used
to coerce the expression into a string.
My knowledge of OCaml is limited,
so how x is not a string type is beyond me.
*)

let rec pprint = function
  | [] -> sprintf ""
  | e1::e2 -> pprint_expr e1 ^ "\n" ^ pprint e2

(*
Detype and Deother are helpers that trash
members of the type mentioned in their name.
The only distinction between these two parser stages
is which gets used.
*)

let rec detype = function
  | [] -> []
  | (TypeLine(x))::e2 -> detype e2
  | e1::e2 -> e1 :: detype e2

let rec deother = function
  | [] -> []
  | (OtherLine(x))::e2 -> deother e2
  | e1::e2 -> e1 :: deother e2