
type 'a bintree = Empty | Node of 'a * 'a bintree * 'a bintree;;

let rec in_order = function 
  | Empty -> []
  | Node (a, i, d) -> in_order i @ (a :: in_order d);;

let rec insert ord bt a =
  match bt with
    | Empty -> Node (a, Empty, Empty)
    | Node (b, i, d) -> if ord a b 
                        then Node (b, insert ord i a, d)
                        else Node (b, i, insert ord d a);;

let rec bst ord = function 
  | [] -> Empty
  | h::t -> insert ord (bst ord t) h;;

let rec qsort ord l = in_order (bst ord l);;