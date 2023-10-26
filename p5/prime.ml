let is_prime n =
  let rec check_from i =
  i >= n ||
  (n mod i <> 0 && check_from (i+1))
  in check_from 2;;


let rec next_prime n = (* n > 1*)
  if is_prime (n + 1)
    then n + 1
    else next_prime (n + 1);;

let rec last_prime_to n = (* n > 1*)
  if is_prime n 
    then n
    else last_prime_to (n - 1);;

let is_prime2 n = 
  let sqrti i = int_of_float (sqrt (float_of_int i)) in
  let rec check_from = function 
    (_, _, true) -> false
  | (_, true, _) -> true
  | (i, _, _) -> check_from (i + 1, i + 1 >= sqrti n, n mod i = 0) in
  check_from (2, false, false);;