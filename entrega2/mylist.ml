
let hd (h::_) = h;;
let tl (_::t) = t;;

let rec length l = 
    if l = [] then 0
    else 1 + length (tl l);;

let length l = 
    let rec aux n = function 
        | [] -> n
        | _::t -> aux (n+1) t in
    aux 0 l;;

let rec compare_lengths l1 l2 =
    match (l1, l2) with
        | [], [] -> 0
        | [], _ -> -1
        | _, [] -> 1
        | _::t1, _::t2 -> compare_lengths t1 t2;;

let rec compare_length_with l n =
    match l, n with
        | [], n -> compare 0 n
        | _, 0 -> 1
        | _::t, n -> compare_length_with t (n-1);;

(*La llamada es con m-1 por que los indices empiezan en 0*)
let init n g = 
    let rec aux (m, l) =
        if m = 0 then l
        else aux (m-1, g (m-1)::l) in 
    aux (n, []);;

let rec nth l n =
    match l, n with
        | h::_, 0 -> h
        | _::t, n -> nth t (n-1);;

let rec rev_append l1 l2 = 
    match l1 with 
        | [] -> l2
        | h::t -> rev_append t (h::l2);;

let append l1 l2 = rev_append (rev_append l1 []) l2;;

let rev l1 = rev_append l1 [];;

let rec concat = function
    | [] -> []
    | h::t -> append h (concat t);;

let flatten l = concat l;;

let rec split = function 
    | [] -> [],[]
    | (a,b)::t -> let l1, l2 = split t in ( a::l1 , b::l2 );;

(* zip *)
let rec combine l1 l2 = 
    match l1,l2 with 
        | [], [] -> []
        | h1::t1, h2::t2 -> (h1, h2) :: (combine t1 t2);;

let rec map f = function 
    | [] -> []
    | h::t -> f h :: map f t;;

let rec map2 bf l1 l2 = 
    match l1, l2 with 
        | [], [] -> []
        | h1::t1, h2::t2 -> bf h1 h2 :: map2 bf t1 t2;; 

let rev_map f l = 
    let rec aux li lo = 
        match li with 
            | [] -> lo
            | h::t -> aux t (f h :: lo) in
    aux l [];; 

let rec for_all p l = 
    match l with 
        | [] -> true
        | h::t -> if p h then for_all p t
                  else false;;

let exist p l = 
    not (for_all (function x -> not (p x)) l)

let rec exists p = function 
    | [] -> false
    | h::t -> if p h then true
              else exists p t;;

let mem a l = exists ((=) a) l;; 

let rec find p = function 
    | h::t -> if p h then h else find p t;;

let rec filter p = function 
    | [] -> []
    | h::t -> if p h then h :: filter p t
              else filter p t;;

let filter p l = 
    let rec aux li lo = 
        match li with
            | [] -> lo
            | h::t -> if p h then aux t (h :: lo)
                      else aux t lo in
    aux l [];;

let find_all p l = filter p l;;

let partition p l = 
    let l = rev l in
    ( filter p l, filter (function e -> not (p e) ) l);;

(*reduce*)
let rec fold_left bf acc = function 
    | [] -> acc
    | h::t -> fold_left bf (bf acc h) t;;

let rec fold_right bf l acc = 
    match l with 
        | [] -> acc
        | h::t -> bf h (fold_right bf t acc);;

let rec assoc e = function 
    | (k,v)::t -> if k = e then v
                  else assoc e t;;

let rec mem_assoc e = function
    | [] -> false
    | (k,v)::t -> k = e || mem_assoc e t;;

let rec remove_assoc e = function 
    | [] -> []
    | (k,v)::t -> if k = e then remove_assoc e t
                  else (k,v) :: remove_assoc e t;;