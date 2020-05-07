open Lang

(* Types *)

val equal : typ -> typ -> bool

val is_base : typ -> bool

(* Suppose tau = a -> (b -> (c -> d)). Then:
 *   domain_of_codomain ~codomain:d tau = Some c
 *   domain_of_codomain ~codomain:(c -> d) tau = Some b
 *   domain_of_codomain ~codomain:(b -> (c -> d)) tau = Some a
 *   domain_of_codomain ~codomain:(a -> (b -> (c -> d))) tau = None
 *
 * Also:
 *   domain_of_codomain ~codomain:a a = None
 *   domain_of_codomain ~codomain:a (() -> a) = Some ()
 *)
val domain_of_codomain : codomain:typ -> typ -> typ option

val bind_spec : type_ctx -> exp -> bind_spec

val sub_bind_spec : bind_spec -> bind_spec

val structurally_decreasing_bind_spec :
  head_spec:bind_spec -> arg_spec:bind_spec -> bool

val structurally_decreasing :
  type_ctx -> head:exp -> arg:exp -> bool

val matches_dec :
  string option -> bind_spec -> bool

val peel_forall : typ -> string list * typ

(* Substitution *)

val substitute : before:string -> after:typ -> typ -> typ
val substitute_many : bindings:((string * typ) list) -> typ -> typ

(* Type checking *)

type error =
  | VarNotFound of string
  | CtorNotFound of string
  | PatternMatchFailure of typ * pat
  | WrongNumberOfTypeArguments of int * int

  | GotFunctionButExpected of typ
  | GotTupleButExpected of typ
  | GotTypeAbstractionButExpected of typ
  | GotButExpected of typ * typ

  | BranchMismatch of string * string

  | CannotInferFunctionType
  | CannotInferCaseType
  | CannotInferHoleType

  | ExpectedArrowButGot of typ
  | ExpectedTupleButGot of typ
  | ExpectedForallButGot of typ
  | ExpectedDatatypeButGot of typ

  | TupleLengthMismatch of typ
  | ProjectionLengthMismatch of typ
  | ProjectionOutOfBounds of int * int

  | TypeAbstractionParameterNameMismatch of string * string

  | AssertionTypeMismatch of typ * typ
  [@@deriving yojson]

val check :
  datatype_ctx -> type_ctx -> exp -> typ -> (hole_ctx, exp * error) result

val infer :
  datatype_ctx -> type_ctx -> exp -> (typ * hole_ctx, exp * error) result
