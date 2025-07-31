open Core.Std

let rec length l =
  match l with
    | [] -> 0
    | _::tail -> 1 + length tail 

(* val reverse : 'a list -> 'a list *)
let reverse list =
  let rec l acc = function
    | [] -> acc
    | h::tail -> l (h::acc) tail in
    l [] list

(* val map : f:('a -> 'b) -> 'a list -> 'b list *)
let rec map ~f l =
  match l with
    | [] -> []
    | h::t -> f h :: map ~f t

(* val filter : f:('a -> bool) -> 'a list -> 'a list *)
let rec filter ~f l =
  match l with
    | [] -> []
    | h::t when f h -> h :: filter ~f t
    | h::t -> filter ~f t

(* val fold : init:'acc -> f:('acc -> 'a -> 'acc) -> 'a list -> 'acc *)
let rec fold ~(init : 'acc) ~(f : 'acc -> 'a -> 'acc) (l : 'a list) : 'acc =
  match l with
    | [] -> init
    | h :: t -> fold (f init h) f t

(* val append : 'a list -> 'a list -> 'a list *)
let rec append l = function
  | [] -> []
  | h::t -> append (l @ h) t

(* val concat : 'a list list -> 'a list *)
let rec concat l = function
  | [] -> []
  | h::t -> concat (l @ h) t