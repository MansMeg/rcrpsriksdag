# library(testthat)
context("speeches")

data("speeches")
data("stop_words_se")
# load("speeches3.rda")
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
  expect_true(any(stringr::str_detect(txt, "hbt_personers"))) # dash_collocations.csv
})

test_that("No missing speeches", {
  txt <- speeches$anforandetext
  expect_true(all(stringr::str_length(txt) > 1))
  # to_check <- speeches[stringr::str_length(speeches$anforandetext) <= 1,]
})


test_that("The tokenization function is correct", {
  tok_speeches <- dplyr::group_by(tok_speeches, anforande_id)
  new_speeches <- dplyr::summarise(tok_speeches, anforandetext_paste = paste(token, collapse = " "))
  speeches_combined <- left_join(speeches, new_speeches, by = "anforande_id")
  txt1 <- speeches_combined$anforandetext
  txt2 <- speeches_combined$anforandetext_paste
  
  expect_true(all(txt1 == txt2))
  # idx <- which(txt1 != txt2)
  # txt1[idx[i]]
  # txt2[idx[i]]
  
  # Stop words are removed
  tok_speeches_no_stops <- 
    rcrpsriksdag::tokenize_speeches(speeches, 0, stop_list = stop_words_se)
  expect_false(any(as.character(tok_speeches_no_stops$type) == "också"))
})

test_that("Stop words with åäö is removed", {
  tok_speeches_no_stops <- 
    rcrpsriksdag::tokenize_speeches(speeches, 0, stop_list = stop_words_se)
  expect_false(any(as.character(tok_speeches_no_stops$type) == "också"))
})

test_that("Check that only colocation in collocation files and dashed exist", {
  # "a jour" should not create "ska_journalist"
  dashed_tokens <- rcrpsriksdag:::read_in_token_error_files("RPackage/data-raw/dash_errors")$true_token
  collocation_tokens <- rcrpsriksdag:::read_in_collocation_files("RPackage/data-raw/collocations/")
  collocation_tokens <- stringr::str_replace_all(collocation_tokens, " ", "_")
  all_underscores <- c(dashed_tokens, collocation_tokens)
  all_underscores <- dplyr::data_frame(token = all_underscores[!duplicated(all_underscores)])

  # Get 
  vocab <- levels(tok_speeches$token)
  vocab_underscore <- vocab[stringr::str_detect(vocab, "_")]
  
  # Remove web sites (they are OK)
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_se$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_nu$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_org$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_com$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_dk$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_fi$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_net$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "_no$")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "N")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "t_ex|s_k|m_fl|bl_a|e_d|f_d|t_o_m|o_d|m_m|fr_o_m")]
  vocab_underscore <- vocab_underscore[!stringr::str_detect(vocab_underscore, "herr_talman")]
  
  expect_true(all(vocab_underscore %in% all_underscores[[1]]))
  vocab_underscore[!vocab_underscore %in% all_underscores[[1]]]
  
  #which(stringr::str_detect(speeches$anforandetext, "gör_sedan"))
  #speeches$anforandetext[16361]
  #speeches_raw$anforandetext[16361]
  
  #which(stringr::str_detect(speeches$anforandetext, " _ "))
  #speeches$anforandetext[c(16416, 124478)]
  #speeches_raw$anforandetext[c(16416, 124478)]
  
})

