
{
  open Parser
  exception Error of char
}

let foo = "max"
let bar = "min"
let ws = [' ' '\t']
let wsn = [' ' '\t' '\n']
let wslpar = ws | ['(']
let wsnrpar = wsn | [')']

rule token = parse
   | wslpar foo wsnrpar as lxm
       { FUNC(lxm) }
   | wslpar bar wsnrpar as lxm
       { FUNC(lxm) }
   |  wsn
       { token lexbuf }
   | eof
       { EOF }
   | _
       { token lexbuf }
   | _ as c
       { raise (Error c) }