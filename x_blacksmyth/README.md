# blacksmythparser

Parser toolchain for the [Blacksmyth](https://github.com/jhawkreynolds/blacksmyth) project.

## usage

Running the script ```./blacksmyth.sh``` will apply all parser steps and generate the new file.
No arguments are required.

## repository structure

The folders within this project include the following contents.

### extract

This parser stage collects all function names included in the provided changelog,
which should clarify any functions referenced in the target Elm code file
that have not been defined in the Elm file.

It generates a temporary file that contains function headers with holes
to allow Smyth to attempt to synthesize a new definition for them.

There is a known issue that the parser will interpret a code file
featuring no names of functions included in the changelog
as a parse error rather than a usage error.

### type

This parser stage extracts all type definitions from the file.
This stage is necessary because functions inserted depend on type definitions
being provided before their use in the inserted function.

Type statements, due to parser limitations, must be contained on a single line.

### other

This parser stage extracts all other lines of code from the file.
This stage is necessary because the inserted functions must precede
their usage in the rest of the program.

### examples

A collection of examples of Elm code featuring functions
that are referenced but not defined.

## credit

lexer.mll, parser.mly, main.ml: AST parsing toolchain borrowed from 
https://github.com/david-broman/ocaml-examples.

This example is generating an AST with Menhir, a parser for OCaml.

Thank you to David Broman for this skeleton code
and the helpful tutorials on lexing and parsing in OCaml on YouTube.
These files have been modified to fulfill our project's specific demands,
but I want to provide appropriate credit for the starting point
since I had not used ocamllex + menhir before this project.
