let p = let pi = 2. *. asin 1. in function 
	x when x >= 0. -> 2. *. pi *. x
;;
let area = let pi = 2. *. asin 1. in function
	x when x >= 0. -> pi *. x *. x
;;
let absf = function
	 x when x >= 0. -> x
	|x -> -.x
;;
let even = function x -> x mod 2 = 0;;

let next3 = function x -> if x mod 3 = 0 
	then x 
	else x + (3 - x mod 3)
;;
let is_a_letter = function c -> Char.code c >= Char.code 'A' && Char.code c <= Char.code 'z';;

let string_of_bool = function 
	 true -> "verdadero" 
	|false -> "false";;
