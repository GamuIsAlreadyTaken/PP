
let come (x1, y1) (x2, y2) =
      x1 = x2 || 
      y1 = y2 ||
      abs (x2-x1) = abs (y2-y1) ;;

let compatible p l = 
      not (List.exists (come p) l);;

let queens n =
    let rec complete path (c, f) = 
        if c > n then [path]
        else if f > n then []
        else if compatible (c, f) path
            then List.rev_append (complete ((c, f) :: path) (c+1, 1)) 
                                 (complete path (c, f+1))   
            else complete path (c, f+1)
    in 
    complete [] (1,1);;

let dentro n (c, f) = c > 0 && c <= n && f > 0 && f <= n;; 

let rec all_compatible = function 
  | [] -> true
  | h::t -> compatible h t && all_compatible t;;

let is_queens_sol n sol =
  List.length sol = n &&
  List.for_all (dentro n) sol &&
  all_compatible sol;;
  