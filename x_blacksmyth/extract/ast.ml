
open Printf

type expr =
 | ENil
 | EFunc   of string

let rec pprint_header = function
 | "plus" -> sprintf "plus : Nat -> Nat -> Nat\n" ^ "plus a b =\n" ^ "    ??\n"
 | "minus" -> sprintf "minus : Nat -> Nat -> Nat\n" ^ "minus a b =\n" ^ "    ??\n"
 | _ -> sprintf "error: function unknown"

let rec pprint_expr = function
 | ENil -> sprintf "ENil"
 | EFunc(x) -> pprint_header (String.trim x)

let rec pprint = function
| [] -> sprintf ""
| e1::e2 -> pprint_expr e1 ^ "\n" ^ pprint e2

let rec unduplicate = function
| [] -> []
| e1::e2 -> if List.mem e1 e2 
            then unduplicate e2
            else e1 :: unduplicate e2