let file = "funcs.elm"

let rec readfuncs = function
| [] -> "\n"
| e1::e2 -> e1 ^ "\n" ^ (readfuncs e2)

let listlines =
  let ic = open_in file in
    let rec read_lines acc =
    try
      try
        let line = input_line ic in
        read_lines (line :: acc)
      with End_of_file ->
        close_in ic;
        List.rev acc
    with e ->
      close_in_noerr ic;
      raise e

