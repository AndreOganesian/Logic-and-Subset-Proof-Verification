module type BasicFunctions = sig
  type t

  val compare : t -> t -> bool
  val to_string : t -> string
  val comparison : t list -> t -> bool
end

module type ProofType = sig
  type t

  include BasicFunctions with type t := t
end

module type ProofStorage = sig
  module T : ProofType

  type expr = T.t

  val clear_proof : unit -> unit
  val curr_goal : expr option ref
  val set_curr_goal : expr option -> bool
  val history : expr list ref
  val add_to_history : expr -> bool -> bool
end

module type ProofMaker = functor (TYPE : ProofType) ->
  ProofStorage with module T = TYPE
