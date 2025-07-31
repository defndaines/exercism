open Core.Std

let rec length l =
  match l with
    | [] -> 0
    | _::tail -> 1 + length tail

let reverse list =
  let rec l acc = function
    | [] -> acc
    | h::tail -> l (h::acc) tail in
    l [] list

let rec fold ~init ~f l =
  match l with
    | [] -> init
    | h :: t -> fold ~init:(f init h) ~f t

let map ~f l =
  fold ~init:[] ~f:(fun acc e -> (f e) :: acc) l
    |> reverse

let filter ~f l =
  fold ~init:[] ~f:(fun acc e -> if f e then e :: acc else acc) l
    |> reverse

let append left right =
  fold ~init:right ~f:(fun acc e -> e :: acc) (reverse left)

let rec concat lol =
  match lol with
    | [] -> []
    | [[]] -> []
    | h :: t -> h @ concat t