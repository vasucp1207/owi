symbolic extern module (assume and assert test):
  $ dune exec owi -- sym assume.wat
  Trap: unreachable
  Model:
    (model
      (symbol_0 i32 (i32 571440828))
      (symbol_1 i32 (i32 1744863297)))
  Reached problem!