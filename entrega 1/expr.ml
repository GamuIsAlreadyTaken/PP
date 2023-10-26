();;
(* - : unit = ()*)
2 + 5 * 3;;
(* - : int = 17*)
1.25 *. 2.0;;
(* - : float = 2.5*)
(*2 - 2.0;;*)
(*Type error: 2.0 is not a int*)
(*3.0 + 2.0;;*)
(*Type error: infix operator + expected 2 ints but got 2 floats*)
5 / 3;;
(* - : int = 1*)
5 mod 3;;
(* - : int = 2*)
2.0 *. 3.0 ** 2.0;;
(* - : float = 18.*)
2.0 ** 3.0 ** 2.0;;
(* - : float = 64.* *Exponentiation goes from back to front*)
sqrt;;
(* - : float -> float = <func>*)
(*sqrt 4;;*)
(*Type error sqrt expected a float*)
int_of_float;;
(* - : float -> int = <fun>*)
float_of_int;;
(* - : int -> float = <fun>*)
3.0 = float_of_int 3;;
(* - : bool = true*)
(*int_of_float -2.9;;*)
(* - : int = 3* *Type error: infix operator - expected a int got int_of_float*) 
int_of_float 2.1 + int_of_float (-2.9);;
(* - : int = 0* *int_of_float = truncate*)
truncate;;
(* - : float -> int = <fun>*)
truncate 2.1 + truncate (-2.9);;
(* - : int = 0* *function aplication has the most priority*)
floor;;
(* - : float -> float = <fun>*)
floor 2.1 +. floor (-2.9);;
(* - : float = -1.* *floor goes down negative numbers get a -1*)
ceil;;
(* - : float -> float = <fun>*)
ceil 2.1 +. ceil (-2.9);;
(* - : float = 1.*)
int_of_char;;
(* - : char -> int = <fun>*)
int_of_char 'A';;
(* - : int = 65*)
char_of_int;;
(* - : int -> char = <fun>*)
char_of_int 66;;
(* - : char = 'B'*)
Char.code;;
(* - : char -> int = <fun>*)
Char.code 'B';;
(* - : int = 66*)
Char.chr;;
(* - : int -> char = <fun>*)
Char.chr 67;;
(* - : char = 'C'*)
'\067';;
(* - : char = 'C'*)
Char.chr (Char.code 'a' - Char.code 'A' + Char.code 'M');;
(* - : char = 'm'* *Ascii offset between upper and lower is 32*) 
Char.lowercase_ascii;;
(* - : char -> char = <fun>*)
Char.lowercase_ascii 'M';;
(* - : char = 'm'*)
Char.uppercase_ascii;;
(* - : char -> char = <fun>*)
Char.uppercase_ascii 'm';;
(* - : char = 'M'*)
"this is a string";;
(* - : string = "this is a string"*)
String.length;;
(* - : string -> int = <fun>*)
String.length "longitud";;
(* - : int = 8*)
(*"1999" + "1";;*)
(*Type error: infix operator + expected int got string*)
"1999" ^ "1";;
(* - : string = "19991"*)
int_of_string;;
(* - : string -> int = <fun>*)
int_of_string "1999" + 1;;
(* - : int = 2000*)
"\065\066";;
(* - : string = "AB"*)
string_of_int;;
(* - : int -> string = <fun>*)
string_of_int 010;;
(* - : string = "10"*)
not true;;
(* - : bool = false*)
true && false;;
(* - : bool = false*)
true || false;;
(* - : bool = true*)
(1 < 2) = false;;
(* - : bool = false*)
"1" < "2";;
(* - : bool = true*)
2 < 12;;
(* - : bool = true*)
"2" < "12";;
(* - : bool = false*)
"uno" < "dos";;
(* - : bool = false*)
if 3 = 4 then 0 else 4;;
(* - : int = 4*)
if 3 = 4 then "0" else "4";;
(* - : string = "4"*)
(*if 3 = 4 then 0 else "4";;*)
(*Type error: 1 branch of type int the other of type string*)
(if 3 < 5 then 8 else 10) + 4;;
(* - : int = 12*)
