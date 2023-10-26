
let f n = if n mod 2 = 0 then n / 2 else 3 * n + 1;;

let rec orbit n = 
  if n = 1 then "1"
  else string_of_int n ^ ", " ^ orbit (f n);;


let orbit' m = (*Recursiva terminal*)
  let rec aux (t, n) = 
    if n = 1 then t
    else
      let f_n = f n in  
      aux (t ^ ", " ^ string_of_int f_n, f_n) in
  aux (string_of_int m, m);;

let rec length n = (*n > 0*)
  if n = 1 then 0
  else 1 + length (f n);;

let rec top n = 
   if n = 1 then 1
   else max n (top (f n));;

let rec length'n'top n = 
    if n = 1 then (0, 1)
    else let l, t = length'n'top (f n)
         in 1 + l, max n t;;
(* 
let length'n'top n = 
  let rec aux n (l, m) = 
    if n = 1 then (l, m)
    else aux (f n) (1 + l, max n m) in
  aux n (0, 0);; *)

let rec longest_in n m = 
  let len_n = length n