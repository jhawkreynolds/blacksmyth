
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
   |  ['\n']
       { token lexbuf }
   | eof
       { EOF }
   | "type" [^'\n']* as lxm
       { TYPELINE(lxm) }
   | [^'\n']* as lxm
       { OTHERLINE(lxm) }
   | _ as c
       { raise (Error c) }