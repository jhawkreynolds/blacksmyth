# blacksmythparser

concept.v: Coq code for preprocessor criteria

preprocessor.ml: preprocessor OCaml code extracted from Coq

lexer.mll, parser.mly, main.ml: AST parsing toolchain borrowed from 
https://github.com/david-broman/ocaml-examples.

This example is generating an AST with Menhir, a parser for OCaml.

Thank you to David Broman for this skeleton code
and the helpful tutorials on lexing and parsing in OCaml on YouTube.
These files will be modified to fulfill
our project's specific demands,
but I want to provide appropriate credit for the starting point
since I had not used ocamllex + menhir before this project.
