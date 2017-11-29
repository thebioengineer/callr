
context("timeout")

test_that("r with timeout", {
  print(Sys.time())
  e <- tryCatch(
    r(function() { Sys.sleep(5); "foobar" }, timeout = 0.01),
    error = function(e) e
  )
  print(Sys.time())
  print(e)

  expect_true("callr_timeout_error" %in% class(e))
})
