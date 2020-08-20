type 'a t

val create: int -> 'a t
val check: 'a t -> int -> bool
val get: 'a t -> int -> 'a option
val set: 'a t -> int -> 'a option -> unit
val blit: 'a t -> int -> 'a t -> int -> int -> unit
val length: 'a t -> int
