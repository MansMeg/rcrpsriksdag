context("speeches")

data("speeches")

test_that("Dash exist", {
  txt <- speeches$anforandetext
  expect_true(any(stringr::str_detect(txt, "_")))
  expect_true(any(stringr::str_detect(txt, "t_o_m")))
  expect_true(any(stringr::str_detect(txt, "s_k")))
})


test_that("No punctuation exist but underscore", {
  txt <- speeches$anforandetext
  txt <- stringr::str_replace_all(txt, "_", " ")
  expect_true(!any(stringr::str_detect(txt, "[:punct:]")))
})


test_that("All collocation files has been handled", {
  txt <- speeches$anforandetext
  expect_true(any(stringr::str_detect(txt, "förväntad_livslängd"))) # collocations_2gram.txt
  expect_true(any(stringr::str_detect(txt, "skylla_sig_själv"))) # collocations_3gram.txt
  expect_true(any(stringr::str_detect(txt, "m_s"))) # collocations_manual.txt
  expect_true(any(stringr::str_detect(txt, "ali_esbati"))) # collocations_mep.txt
  expect_true(any(stringr::str_detect(txt, "västra_götalands_län"))) # collocations_region_names.txt
  expect_true(any(stringr::str_detect(txt, "hbt_personers"))) # dash_collocations.csv
})



