
let to0from n = 
  let rec aux l n =
    if n < 0 then l
    else aux (n::l) (n-1)
  in aux [] n;;

let rec fromto f t = 
   let rec aux l t =
    if t < f then l
    else aux (t::l) (t - 1)
  in aux [] t;;

let remove x l = 
  let rec aux lh = function 
    | [] -> lh
    | h::t -> if h = x then List.rev_append lh t 
              else aux (h :: lh) t
  in aux [] l;;

let rec compress l = 
  let rec aux nl = function 
    | h1::h2::t -> if h1 = h2 then aux nl (h2::t)
               else aux (h1::nl) (h2::t)
    | l -> List.rev nl @ l
  in  (aux [] l);;

let append' l1 l2 = List.rev_append (List.rev l1) l2;;

let map' f l = List.rev (List.rev_map f l);;

let fold_right' = List.fold_right;;
