(** Copyright (c) 2016-present, Facebook, Inc.

    This source code is licensed under the MIT license found in the LICENSE file in the root
    directory of this source tree. *)

module type ELEMENT = sig
  type t

  val name : string

  val bottom : t

  val join : t -> t -> t

  val less_or_equal : left:t -> right:t -> bool

  val show : t -> string
end

module Make (Element : ELEMENT) : sig
  include AbstractDomainCore.S with type t = Element.t
end
