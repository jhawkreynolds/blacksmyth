
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
       (* 
       Store lines that start with types as TypeLine. 
       Note that we use the character class "not newline"
       to accept anything that isn't a newline.
       *)
   | [^'\n']* as lxm
       { OTHERLINE(lxm) }
       (*
       Store all other lines as OtherLine.
       *)
   | _ as c
       { raise (Error c) }