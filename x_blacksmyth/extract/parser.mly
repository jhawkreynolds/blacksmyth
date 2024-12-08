
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
  | e = expr
    { e }

expr:
  | f = FUNC
    { [EFunc(f)] }
