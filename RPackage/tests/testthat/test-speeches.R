context("speeches")

data("speeches")

test_that("Dash exist", {
  txt <- speeches$anforandetext
  expect_true(any(stringr::str_detect(txt, "_")))
  expect_true(any(stringr::str_detect(txt, "t_o_m")))
  expect_true(any(stringr::str_detect(txt, "s_k")))
})


test_that("No punctuation exist", {
  txt <- speeches$anforandetext
  expect_true(!any(stringr::str_detect(txt, "\\.")))
  expect_true(!any(stringr::str_detect(txt, ",|!")))
  expect_true(!any(stringr::str_detect(txt, "\\?")))
})


