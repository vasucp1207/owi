(** Module to define externref values in OCaml. You should look in the `example`
    directory to understand how to use this before reading the code... *)

type ('a, 'b) eq = ('a, 'b) Type_id.eq

type externref = E : 'a Type_id.ty * 'a -> externref

module Make_extern_func(V : Func_intf.Value_types) :
  Func_intf.T_Extern_func
    with type int32 := V.int32
     and type int64 := V.int64
     and type float32 := V.float32
     and type float64 := V.float64

module Func :
  Func_intf.T
    with type int32 := Int32.t
     and type int64 := Int64.t
     and type float32 := Float32.t
     and type float64 := Float64.t

type 'env ref_value =
  | Externref of externref option
  | Funcref of ('env, Func_id.t) Func_intf.t option
  | Arrayref of unit array option

type 'a t =
  | I32 of Int32.t
  | I64 of Int64.t
  | F32 of Float32.t
  | F64 of Float64.t
  | Ref of 'a ref_value

val cast_ref : externref -> 'a Type_id.ty -> 'a option

val of_instr : Simplified.instr -> _ t

val to_instr : _ t -> Simplified.instr

val ref_null' : Simplified.heap_type -> 'a ref_value

val ref_null : Simplified.heap_type -> 'a t

val ref_func : ('env, Func_id.t) Func.t -> 'env t

val is_ref_null : 'a ref_value -> bool

val pp : Format.formatter -> 'a t -> unit
