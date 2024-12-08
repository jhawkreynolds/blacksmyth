
type bool =
| True
| False

type nat =
| O
| S of nat

type aE =
| Num of nat
| Add of aE * aE
| Sub of aE * aE
| Hole

type changelogStatus =
| Unchanged
| Added
| Removed
| Modified

type transformation =
| L1_to_core
| Core_to_L2

val changelogMapping : aE -> changelogStatus

val included : transformation -> aE -> bool

val preprocess : transformation -> aE -> aE
