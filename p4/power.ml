
let rec power x y = 
  if y = 0 then 1
  else x * power x (y-1);;

let rec power' x y = 
  if y = 0 then 1
  else if y mod 2 = 0
    then power' (x * x) (y / 2)
    else x * power' (x * x) (y / 2);;

(* 
  Power es O(y), 
    cada llamada que hace reduce 'y' en 1
  mientras que power' es O(ln y),
    cada llamada que hace divide a la mitad 'y'
*)

let rec powerf x y = 
  if y = 0 then 1.
  else if y mod 2 = 0
    then powerf (x *. x) (y / 2)
    else x *. powerf (x *. x) (y / 2);;