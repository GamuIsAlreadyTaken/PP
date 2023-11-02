
let next (x, y) = 
  if (x + y - 1) mod 2 = 0
    then (x + 1, max (y - 1) 1)
    else (max (x - 1) 1, y + 1);; 

let rec steps_from p n =
  if n = 0 then p
  else steps_from (next p) (n-1);;

let pair n = steps_from (1,1) n;;