
let is_bst ord bt = let list = in_order bt in
   List.for_all2 (=) list (in_order (bst ord list));;

let bfs bt =
  let rec aux = function  
      | [] -> []
      | Node (a, i, d)::t -> a :: aux (t @ [i; d])
      | Empty::t -> aux t
  in aux [bt];;

let bfs' bt = 
  let rec aux l = function 
    | [] -> l
    | Node (a, i, d)::t -> aux (a::l) (t @ [i; d])
    | Empty::t -> aux l t
  in List.rev (aux [] [bt]);;

let rec perfecto = function 
   | Node(_, Empty, Node _)
   | Node(_, Node _, Empty) -> false
   | Empty
   | Node (_, Empty, Empty) -> true
   | Node (_, Node (_, a, b), Node (_, c, d)) -> 
        perfecto a && perfecto b && perfecto c && perfecto d;;

let casi_completo bt =  false;;

(* 
exception Not_bst;;
let is_bst ord = 
    let rec bst_min_max = function
      | Node (r, Empty, Empty) -> (r, r) 
      | Node (r, i, Empty) -> let (min, max) = bst_min_max i in
            if ord max r then (min, r)
            else raise Not_bst
      | Node (r, Empty, d) -> let (min, max) = bst_min_max d in
            if ord r min then (r, max)
            else raise Not_bst
      | Node (r, i, d) -> 
        let (i_min, i_max) = bst_min_max i in
        let (d_min, d_max) = bst_min_max d in
        if ord i_max r && ord r d_min then (i_min, d_max)
        else raise Not_bst
    in function 
    | Empty -> true
    | bt -> try let _ = bst_min_max bt in true with
             Not_bst -> false;; 
*)