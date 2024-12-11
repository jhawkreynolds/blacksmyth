
{
  open Parser
  exception Error of char
}

let funcs = "max" | "min" | "compare" | "plus" | "append"
let ws = [' ' '\t']
let wsn = [' ' '\t' '\n']
let wslpar = ws | ['(']
let wsnrpar = wsn | [')']

rule token = parse
   | wslpar funcs wsnrpar as lxm
       { FUNC(lxm) }
   |  wsn
       { token lexbuf }
   | eof
       { EOF }
   | _
       { token lexbuf }
   | _ as c
       { raise (Error c) }