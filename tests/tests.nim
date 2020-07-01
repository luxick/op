# To run these tests, simply execute `nimble test`.

import unittest
import op

test "Check OK":
  let test = ok 1
  check test.isOk == true

test "Check fail":
  let test = op.fail[int] "no data here"
  check test.isOk == false

test "Check proc results":
  proc createValue: OP[string] =
    let myString = "This is test code!"
    ok myString
  let data = createValue()
  check data.isOk
  check data.val == "This is test code!"

test "Check failing proc":
  proc someProc(): OP[int] =
    result.fail "Not implemented!"

  let data = someProc()
  assert data.isOk == false
  assert data.error == "Not implemented!"

test "Check changing result":
  proc checker(): OP[int] =
    result = ok 42
    # something happend here
    result = result.fail "data got corrupted"

  let data = checker()
  check data.isOk == false
  check data.error == "data got corrupted"