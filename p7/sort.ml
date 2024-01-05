
let bigl = List.init 250_000 succ;;

(*
let rec insert x = function
[] -> [x]
| h::t -> if x <= h then x :: h :: t
else h :: insert x t;;

let rec isort = function
[] -> []
| h::t -> insert h (isort t);;
*)



let insert_t x l = 
  let rec aux lh = function 
  | [] -> List.rev_append lh [x]
  | h::t -> if x <= h 
                then List.rev_append lh (x :: h :: t)
                else aux (h::lh) t
  in aux [] l;;

let isort_t l = 
  let rec aux s = function 
    | [] -> s
    | h::t -> aux (insert_t h s) t 
  in aux [] l;;

let rlist n = List.init n (fun _ -> Random.int n);;

let lc1 = List.init 10_000 succ;;
let lc2 = List.init 20_000 succ;;

let ld1 = List.init 10_000 ((-) 10_000);;
let ld2 = List.init 20_000 ((-) 10_000);;

let lr1 = rlist 10_000;;
let lr2 = rlist 20_000;;

(* Al duplicar el tamaño de la entrada el tiempo aproximadamente se eleva al cuadrado
por que el algoritmo es cuadratico en el peor y caso medio

En el caso que ya esté casi ordenado el vector el tiempo aumenta linearmente*)

(* La función recursiva terminal no tarda nada, mientras que la dada es muy lenta 
se debe a que la gestión de memoria de la recursiva terminal es casi inexistente *)

let isort_g ord l =  
  let rec insert x lh = function 
    | [] -> List.rev_append lh [x]
    | h::t -> if ord x h 
                  then List.rev_append lh (x :: h :: t)
                  else insert x (h::lh) t
  in
  let rec aux s = function 
    | [] -> s
    | h::t -> aux (insert h [] s) t 
  in aux [] l;;

(*
let rec split l = match l with
   h1::h2::t -> let t1, t2 = split t
    in h1::t1, h2::t2
  | _ -> l, [];;

let rec merge (l1,l2) = match l1, l2 with
    [], l | l, [] -> l
  | h1::t1, h2::t2 -> if h1 <= h2 then h1 :: merge (t1, l2)
                      else h2 :: merge (l1, t2);;

let rec msort l = match l with
    [] | [_] -> l
  | _ -> let l1, l2 = split l
  in merge (msort l1, msort l2);;
*)

let bigl2 = bigl;;

let split_t l = 
  let rec aux (l1, l2) = function 
    | a::b::t -> aux (a::l1, b::l2) t
    | h::[] -> h::l1,l2 
    | l -> l1,l2
  in aux ([],[]) l;;    

let merge_t (l1, l2) = 
  let rec aux l = function 
    | h1::t1, h2::t2 -> if h1 <= h2
                        then aux (h1::l) (t1, h2::t2)
                        else aux (h2::l) (h1::t1, t2)
    | [], lf | lf, [] -> List.rev_append lf l
  in List.rev_append (aux [] (l1,l2)) [];;

let rec msort' = function 
  | [] -> []
  | h::[] -> [h]
  | l -> let l1, l2 = split_t l in
    merge_t (msort' l1, msort' l2);;

let bigl3 = [];;
(*La profundidad de recursión de msort es log n por lo que antes de tener 
stack overflow nos quedamos sin memoria*)

(*La complejidad algoritmica de mergesort es de nlog n, y da igual el orden
de la entrada siempre hace los mismos pasos*)

(*msort' es mas rápido por que split y merge son as lentos al tener que 
gestionar mas la memoria del stack*)

let rec msort_g ord = 
  let rec merge_t l = function 
    | h1::t1, h2::t2 -> if ord h1 h2
                        then merge_t (h1::l) (t1, h2::t2)
                        else merge_t (h2::l) (h1::t1, t2)
    | [], lf | lf, [] -> List.rev_append lf l
  in function
  | [] -> []
  | h::[] -> [h]
  | l -> let l1, l2 = split_t l in
    List.rev_append (merge_t [] (msort_g ord l1, msort_g ord l2)) [];;
