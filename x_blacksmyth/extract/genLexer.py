import sys

def read(input_file : str) -> list[str]:
    try:
        # Open the file in read mode
        with open(input_file, 'r') as file:
            # Read all lines and store them in a list
            lines = file.readlines()
            # Optionally strip newlines
            lines = [line for line in lines if line.strip() != '']

        return lines
    except FileNotFoundError:
        print(f"Error: The file '{input_file}' was not found.")
        return []
    except Exception as e:
        print(f"An error occurred: {e}")
        return []

def write(output_str : str, output_file : str ):
    try:
        with open(output_file, 'w') as file:
            file.write(output_str)
    except Exception as e:
        print(f"An error occurred: {e}")
    
def parse( funcs : list[str]) -> list[list[str]]:
    funcs_split = []
    funcs_parsed = []
    to_remove = [':', '->']
    for func in funcs:
        funcs_split.append(func.split())

    for func in funcs_split:
        new_terms = []
        for term in func:
            if term in to_remove:
                continue
            new_terms.append(term)
        funcs_parsed.append(new_terms)
    
    return funcs_parsed

# Generates a list of parameters for a function from a, b, ...
# Should include a check for reasonable number of params however does not yet
def genParams( func : list[str]):
    num_param = len(func) - 2

    base_chr = 97
    params_str = ""

    for i in range(0,num_param):
        params_str += chr(base_chr + i) + " "

    return params_str

def genLexer(funcs : list[list[str]]):
    prestring = '''   
{
 open Parser
 exception Error of char
}
'''

    poststring = '''let ws = [' ' '\\t']
let wsn = [' ' '\\t' '\\n']
let wslpar = ws | ['(']
let wsnrpar = wsn | [')']

rule token = parse
| wslpar func wsnrpar as lxm
    { FUNC(lxm) }
|  wsn
    { token lexbuf }
| eof
    { EOF }
| _
    { token lexbuf }
| _ as c
    { raise (Error c) }'''
    
    # let func = "max" | "min"

    instring = '\nlet func = '
    for i in range(len(funcs)):
        func = funcs[i]
        func_str = '"' + func[0] + '"'
        
        if(i < len(funcs)-1): func_str += ' | '
        else: func_str += '\n'

        instring += func_str
    
    return prestring + instring + poststring

def genAST(funcs : list[list[str]]):
    prestring = '''
open Printf

type expr =
 | ENil
 | EFunc   of string

let rec pprint_header = function'''

    poststring = '''
 | _ -> sprintf "error: function unknown"

let rec pprint_expr = function
 | ENil -> sprintf "ENil"
 | EFunc(x) -> pprint_header (String.trim x)

let rec pprint = function
| [] -> sprintf ""
| e1::e2 -> pprint_expr e1 ^ "\\n" ^ pprint e2

let rec unduplicate = function
| [] -> []
| e1::e2 -> if List.mem e1 e2 
            then unduplicate e2
            else e1 :: unduplicate e2'''
    
    #| "max" -> sprintf "max : Nat -> Nat -> Nat\n" ^ "max m n =\n" ^ "    ??\n"

    instring = '\n'

    for i in range(len(funcs)):
        func = funcs[i]
        func_str = ' | \"' + func[0] + '\" -> sprintf \"' + func[0] + ' : '

        for j in range(1, len(func)-1):
            func_str += func[j] + ' -> '
        func_str += func[j] + '\\n" ^ "' + func[0] + ' ' + genParams(func) + '=\\n" ^ "    ??\\n"'

        if i < (len(funcs)-1) : 
            func_str += '\n'

        instring += func_str

    return prestring + instring + poststring


input_file = sys.argv[1]
func_decl = parse(read(input_file))

outputAST = "ast.ml"
outputLexer = "lexer.mll"

write(genAST(func_decl), outputAST)
write(genLexer(func_decl), outputLexer)