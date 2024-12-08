
open Printf

type expr =
  | ENil
  | EFunc   of string
  | TypeLine of string
  | OtherLine of string

let rec pprint_expr = function
  | ENil -> sprintf "ENil"
  | EFunc(x) -> sprintf "" ^ x ^ ""
  | TypeLine(x) -> sprintf "" ^ x ^ ""
  | OtherLine(x) -> sprintf "" ^ x ^ ""

let rec pprint = function
  | [] -> sprintf ""
  | e1::e2 -> pprint_expr e1 ^ "\n" ^ pprint e2

let rec detype = function
  | [] -> []
  | (TypeLine(x))::e2 -> detype e2
  | e1::e2 -> e1 :: detype e2

let rec deother = function
  | [] -> []
  | (OtherLine(x))::e2 -> deother e2
  | e1::e2 -> e1 :: deother e2