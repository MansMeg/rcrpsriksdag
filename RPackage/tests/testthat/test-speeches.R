# library(testthat)
context("speeches")

data("speeches")
tok_speeches <- rcrpsriksdag::tokenize_speeches(speeches, 0)

test_that("Dash is handled correctly", {
  txt <- speeches$anforandetext
  expect_true(any(stringr::str_detect(txt, "_")))
  expect_true(any(stringr::str_detect(txt, "t_o_m")))
  expect_true(any(stringr::str_detect(txt, "s_k")))
  expect_true(any(stringr::str_detect(txt, "a_kassan")))
})


test_that("No punctuation exist but underscore do exist", {
  txt <- speeches$anforandetext
  # Allowed punctuations
  txt <- stringr::str_replace_all(txt, "_", " ")
  txt <- stringr::str_replace_all(txt, "§", " ")
  txt <- stringr::str_replace_all(txt, "#", " ")
  
  expect_true(!any(stringr::str_detect(txt, "[:punct:]")))

  #anforandetext <- txt
  # test <- table(unlist(stringr::str_extract_all(anforandetext, pattern = "[:punct:]")))
  # ctx <- show_pattern_context(txt, "\\*")
  # ctx <- show_pattern_context(txt, "#")
  # ctx <- show_pattern_context(txt, "\\[")
  # ctx <- show_pattern_context(txt, "§")
  # ctx <- show_pattern_context(txt, "\\·")
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


test_that("No missing speeches", {
  txt <- speeches$anforandetext
  expect_true(all(stringr::str_length(txt) > 2))
})


