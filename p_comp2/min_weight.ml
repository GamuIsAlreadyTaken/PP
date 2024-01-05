(* La implementación no es estrictamente funcional 
 ya que hace uso de Array.set, pero, cumple lo que pide
 la practica, 
  - muestra un comportamiento funcional:
    - Siempre que se llama con los mismos argumentos devuelve el mismo valor
  - no modifica ningún argumento, ni ninguna variable externa, 
    todas las cosas que modifica son internas (De hecho, se podría hacer 
    enteramente funcional oviando la parte en la que Array.set hace cosas feas
    devolviendo una tupla siempre que se modifique un array, pero ensuciaría
    mucho el programa)
 tambien, da varios warnings, aunque en principio es imposible que ocurran
 los casos que dice el compilador, son declaraciones locales y todas las 
 aplicaciones que ocurren no caen en esos casos
*)


let is_inside c r (x, y) = 
  x >= 0 && x < c &&
  y >= 0 && y < r;;

let can_pass_to (x1, y1) (x2, y2) = 
  abs (x1-x2) + abs (y1-y2) = 1;;

let is_unique e l = not (List.exists ((=) e) l);;

(* can_pass_to no deja que a y b sean iguales, asique podemos ahorrar b en is_unique *)
let valid_path c r p_start p_end path = 
  let rec aux = function
    | a::b::t -> 
        is_inside c r a && 
        can_pass_to a b && 
        is_unique a t &&
        aux (b::t)
    | a::[] -> a = p_end && is_inside c r p_end
  in
  path <> [] &&
  List.hd path = p_start && 
  aux path;;


(* Para poder usar fold_left, 
  compone las funciones e intercambia los argumentos *)
let swap f g x y = f (g y) x;;

(* Azucar sintactico,
   poner .(x).(y) y (x,y) en todas partes es feo *)
let get_m m (x, y) = m.(x).(y);;

(* Suma los pesos de cada paso *)
let path_weight w path = List.fold_left (swap (+) (get_m w)) 0 path;; 


(* Heap *) (* Para poder hacer mas rapida la busqueda de minimos *)
type 'a heap = Empty | Node of 'a * 'a heap * 'a heap * int;;

let empty_heap = Empty;;

let rec merge_heap h1 h2 =
  match h1, h2 with
  | Empty, h | h, Empty -> h
  | Node (a, l1, r1, x), Node (b, l2, r2, y) ->
    if x < y then Node (a, merge_heap r1 h2, l1, x)
    else Node (b, merge_heap r2 h1, l2, y);;

let insert h p x  = merge_heap (Node (p, empty_heap, empty_heap, x)) h;;

let find_min = function
  | Empty -> None
  | Node (a, _, _, x) -> Some a;;

let delete_min = function
  | Empty -> Empty
  | Node (_, l, r, _) -> merge_heap l r;;

(* ____ *)

(* Para debuguear, o ver como funciona *)
let print_matrix pf m = 
  print_endline "_";
  let _ = Array.iter (fun e -> Array.iter (fun u -> pf u;print_string " ") e; print_endline "") m in
  print_endline "^";;

let print_pair (x, y) = 
  print_string " (";
  print_int x;
  print_string ", ";
  print_int y;
  print_string ") ";;

let rec print_list pf = function 
  | [] -> print_endline "|"
  | h::t -> pf h; print_string ", "; print_list pf t;;

let print_bool b = print_string (if b then "true" else "false");;
(* _____ *)


(* azucar para hacer la cosa fea (Efectos secundarios) *)
let set_m m (x, y) v = m.(x).(y) <- v;;

let min_weight_path w p_start p_end =
  let c = Array.length w in
  let r = Array.length w.(0) in

  let validate_input = 
    let valid = 
      c <> 0 && (* Que no esté vacio w*)
      r <> 0 &&
      is_inside c r p_start && (* Que los extremos esten dentro *)
      is_inside c r p_end &&
      Array.for_all (Array.for_all ((<) 0)) w (* Que no tenga valores negativos *)
    in if valid then () 
    else raise (Invalid_argument "min_weight_path")
  in

  (* Crea la matriz de 'distancias' *)
  let initialize_dist (x, y) = 
    let d = Array.make_matrix c r max_int in 
    d.(x).(y) <- 0; d 
  in
  (* Crea la matriz para marcar como visitado o no *)
  let initialize_unvisited (x, y) =
    let v = Array.make_matrix c r true in 
    v.(x).(y) <- false; v 
  in 

  (* Devuelve todas las casillas adyacentes dentro del tablero *)
  let list_adjacent (x, y) = 
    List.filter (is_inside c r) [ x+1, y ; x-1, y ; x, y+1 ; x, y-1 ]
  in
  
  (* Devuelve las casillas adyacentes legales que no se han visitado *)
  let unvisited_adjacent v p = 
      List.filter (get_m v) (list_adjacent p)
  in

  (* Dada una casilla y sus casillas adjacentes actualiza el peso de cada una *)
  let rec explore d v e p = function 
    | [] -> e
    | h::t -> let calc_w = (get_m w h) + (get_m d p) in
        let new_w = min calc_w (get_m d h) in
        set_m d h new_w; (* Cosas feas pasan aqui *)
        let e' = insert e h new_w in
        explore d v e' p t
  in

  (* Extrae casillas del monton de explorados hasta que una no se haya visitado *)
  let rec next_unvisited v e = 
    let Some next = find_min e in
    let e' = delete_min e in
    if get_m v next then (e', next) 
    else next_unvisited v e'
  in 

  (* Visita una casilla y explora sus adjacentes legales no visitadas *)
  (* Este es el algoritmo de Dijkstra *)
  let rec visit d v e p =
    set_m v p false;
    if p = p_end 
    then d
    else 
      let to_explore = unvisited_adjacent v p in
      let e' = explore d v e p to_explore in
      let (left, next) = next_unvisited v e' in
      visit d v left next
  in

  (* Dada una lista devuelve la casilla con menor peso *)
  let min_w_from d a b = if get_m d a < get_m d b then a else b in
  let get_p_min_w d p = List.fold_left (min_w_from d) p in

  (* Una vez aplicado Dijkstra se pasea por el mejor camino *)
  let rec take_shortest_path d (h::t) = 
    if h = p_start then (h::t) (* La lista va a ser como max de 4 elementos *)
    else take_shortest_path d (get_p_min_w d h (list_adjacent h) :: h :: t)
  in
  
  validate_input;
  take_shortest_path 
    (visit
      (initialize_dist p_start) 
      (initialize_unvisited p_start) 
      empty_heap 
      p_start)
    [p_end];;