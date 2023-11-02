
let rec fib n =
  if n <= 1 then n
  else fib (n-1) + fib (n-2);;

let apply_up_to fn n = 
  let rec count i =
    let fn_i = fn i in
    if fn_i > n then ()
    else 
      let _ = print_endline (string_of_int fn_i) in 
      let _ = count (i + 1) in ()
    in
  count 0;;

if Array.length Sys.argv < 2 then
  print_endline "fibto: Invalid number of arguments"
else apply_up_to fib (int_of_string Sys.argv.(1));;
