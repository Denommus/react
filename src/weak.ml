type 'a weak
type 'a t = 'a weak option array

external ext_make_weak: 'a -> 'a weak = "WeakRef" [@@bs.new]
external ext_deref: 'a weak -> 'a Js.Nullable.t = "deref" [@@bs.send]

let deref w = ext_deref w |> Js.Nullable.toOption

let create i = Array.init i (fun _ -> None)
let check arr i = Array.get arr i
                  |. Belt.Option.map (fun x -> ext_deref x |> Js.Nullable.isNullable |> not)
                  |. Belt.Option.getWithDefault false
let get arr i = Array.get arr i |. Belt.Option.flatMap deref
let set arr i value = Belt.Option.map value ext_make_weak |> Array.set arr i
let blit arr1 off1 arr2 off2 len = try Array.blit arr1 off1 arr2 off2 len with
                                     Invalid_argument _ -> raise (Invalid_argument "Weak.blit")
let length arr = Array.length arr
