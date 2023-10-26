(*x - y;;*)
(*Error: x is not bound to a value*)
let x = 1;;
(*val x : int = 1*)
(*x - y;;*)
(*Error: y is not bound to a value*)
let y = 2;;
(*val y : int = 2*)
x - y;;
(*- : int = -1*)
let x = y in x - y;;
(*- : int = 0*)
x - y;;
(*- : int = -1*)
(*z;;*)
(*Error: z is not bound to a value*)
let z = x + y;;
(*z : int = 3*)
z;;
(*- : int = 3*)
let x = 5;;
(*val x : int = 5*)
x + y;;
(*- : int = 7*)
z;;
(*- : int = 3*)
let y = 5 in x + y;;
(*- : int = 10*)
x + y;;
(*- : int = 7*)
let x = x + y in let y = x * y in x + y + z;;
(*- : int = 24*)
x + y + z;;
(*- : int = 10*)
function x -> 2 * x;;
(*- : int -> int = <fun>*)
(function x -> 2 * x) (2 + 1);;
(*- : int = 6*)
(function x -> 2 * x) 2 + 1;;
(*- : int = 5*)
let f = function x -> 2 * x;;
(*val f : int -> int = <fun>*)
f;;
(*- : int -> int = <fun>*)
f (2 + 1);;
(*- : int = 6*)
f 2 + 1;;
(*- : int = 5*)
f x;;
(*- : int = 10*)
let x = 100;;
(*val x : int = 100*)
f x;;
(*- : int = 200*)
let m = 1000;;
(*val m : int = 1000*)
let g = function x -> x + m;;
(*val g : int -> int = <fun>*)
g;;
(*- : int -> int = <fun>*)
g 3;;
(*- : int = 1003*)
(*g 3.0;;*)
(*Error: g expected an int but got a float*)
let m = 7;;
(*val m : int = 7*)
g 3;;
(*- : int = 1003*)
let istrue = function true -> true;;
(*val istrue: bool -> bool = <fun>*)(*Warning: pattern match is not exhaustive*)
istrue;;
(*- : bool -> bool = <fun>*)
istrue (1 < 2);;
(*- : bool = true*)
(*istrue (2 < 1);;*)
(*Exception: false could not be matched*)
(*istrue 0;;*)
(*Error: expected bool but got int*)
let iscero_v1 = function 0 -> true;;
(*val iscero_v1 : int -> bool*) (*Warning: pattern match is not exhaustive*)
iscero_v1 0;;
(*- : bool = true*)
(*iscero_v1 0.;;*)
(*Error: expected int but got float*)
(*iscero_v1 1;;*)
(*Exception: 1 could not be matched*)
let iscero_v2 = function 0 -> true | _ -> false;;
(*val iscero_v2 : int -> bool = <fun>*)
iscero_v2 0;;
(*- : bool = true*)
iscero_v2 1;;
(*- : bool = false*)
(*iscero_v2 0.;;*)
(*Error: expected int but got float*)
let all_to_true = function true -> true | false -> true;;
(*val all_to_true : bool -> bool = <fun>*)
all_to_true (1 < 2);;
(*- : bool = true*)
all_to_true (2 < 1);;
(*- : bool = true*)
(*all_to_true 0;;*)
(*Error: expected bool but got int*)
let first_all_to_true = all_to_true;;
(*val first_all_to_true: bool -> bool = <fun>*)
let all_to_true = function x -> true;;
(*val all_to_true : 'a -> bool = <fun>*)
all_to_true (1 < 2);;
(*- : bool = true*)
all_to_true (2 < 1);;
(*- : bool = true*)
all_to_true 0;;
(*- : bool = true*)
(*first_all_to_true 0;;*)
(*Error: expected bool but got int*)
