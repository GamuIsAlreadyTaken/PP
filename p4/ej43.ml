let reverse n = 
  let rec rev curr acc = 
    if curr = 0 
      then acc
      else rev (curr / 10) (acc * 10 + curr mod 10) 
    in
    rev n 0;;

let rec palindromo s = let length = String.length s in
  length < 2 || 
  s.[0] = s.[length - 1] && 
  palindromo (String.sub s 1 (length - 2));;

let rec mcd (x,y) = 
  if y mod x = 0 
    then x
    else mcd (y mod x, x);; 