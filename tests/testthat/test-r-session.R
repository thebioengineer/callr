
context("r_session")

test_that("regular use", {
  opt <- r_session_options()
  rs <- r_session$new(opt)

  ## Wait until ready, but max 3s
  r_session_wait_or_kill(rs, "idle")

  ## Start a command
  rs$call(function() 42)
  r_session_wait_or_kill(rs, "ready")

  ## Get result
  expect_equal(rs$get_result(), 42)
  expect_equal(rs$get_state(), "idle")

  ## Run another command, with arguments
  rs$call(function(x, y)  x + y, list(x = 42, y = 42))
  r_session_wait_or_kill(rs, "ready")

  ## Get result
  expect_equal(rs$get_result(), 84)
  expect_equal(rs$get_state(), "idle")

  ## Finish
  rs$finish()
  expect_equal(rs$get_state(), "finished")
})