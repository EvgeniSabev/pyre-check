(* Copyright (c) 2016-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree. *)
open Core
open Test
open OUnit2

let test_compute_hashes_to_keys _ =
  let open Ast.SharedMemory in
  let assert_mapping_equal expected actual =
    assert_equal
      ~printer:(fun map -> Sexp.to_string (String.Map.sexp_of_t String.sexp_of_t map))
      ~cmp:(String.Map.equal String.equal)
      (String.Map.of_alist_exn expected)
      actual
  in
  assert_mapping_equal
    [ SymlinksToPaths.hash_of_key "first", SymlinksToPaths.serialize_key "first";
      SymlinksToPaths.hash_of_key "second", SymlinksToPaths.serialize_key "second" ]
    (SymlinksToPaths.compute_hashes_to_keys ~keys:["first"; "second"]);
  assert_mapping_equal
    [ Modules.hash_of_key !&"foo", Modules.serialize_key !&"foo";
      Modules.hash_of_key !&"bar", Modules.serialize_key !&"bar";
      Modules.hash_of_key !&"foo.b", Modules.serialize_key !&"foo.b" ]
    (Modules.compute_hashes_to_keys ~keys:[!&"foo"; !&"bar"; !&"foo.b"]);
  assert_mapping_equal
    [ Handles.hash_of_key (String.hash "a.py"), Handles.serialize_key (String.hash "a.py");
      Handles.hash_of_key (String.hash "b/c.py"), Handles.serialize_key (String.hash "b/c.py") ]
    (Handles.compute_hashes_to_keys ~keys:["a.py"; "b/c.py"])


let () =
  "ast_shared_memory" >::: ["compute_hashes_to_keys" >:: test_compute_hashes_to_keys] |> Test.run