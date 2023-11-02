let g1 n = 
  if n mod 2 = -1 
    then true 
    else if n >= 0 
      then if n mod 2 = 0 
        then true
        else false
      else false;;

let g2 n = 
  let and' = function
    (true, true) -> true
  | _ -> false in
  let or' = function
    (false, false) -> false
  | _ -> true in

  or' (and' (n >= 0,n mod 2 = 0), n mod 2 = -1);;