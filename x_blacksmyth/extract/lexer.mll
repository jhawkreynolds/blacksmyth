   
{
 open Parser
 exception Error of char
}

let func = "max"
let ws = [' ' '\t']
let wsn = [' ' '\t' '\n']
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
    { raise (Error c) }