
%{
   open Ast
%}

%token <string> FUNC
%token EOF

%start main
%type <expr list> main

%%

main:
  | e = rec_expr EOF
    { e }

rec_expr:
  | e1 = expr e2 = rec_expr
    { e1 @ e2 }
    (* Append leaves together. *)
  | e = expr
    { e }
    (* Pass a leaf up. *)

expr:
  | f = FUNC
    { [EFunc(f)] }
    (* Create a singleton list at the leaf. *)
