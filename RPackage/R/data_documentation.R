#' Debates in the Swedish parliament (raw corpus)
#'
#' Raw data containing debates in the Swedish parliament.
#'
#' @format A \code{tbl_df} with one row debate speech.
#' 
#' @seealso \link{speeches}
#' 
"speeches_raw"



#' Debates in the Swedish parliament (cleaned corpus)
#'
#' @description 
#' A corpus with one speech per row. 
#' This is a cleaned version of \code{speeches_raw}, see  
#' RPackage/data-raw/speeches.R on how the data has been cleaned.
#'
#' @format A \code{tbl_df} with one row per speech.
#' 
#' @seealso \link{speeches_raw}
"speeches"

#' Stop word lists
#' 
#' @description A stopword list of common Swedish stop words.
#' 
"stop_words_se"

#' Translated vocabulary of the speeches corpus
#' 
#' @description 
#' This dataset contain translations from Swedish to english for all 
#' individual tokens in the cleaned dataset. Translation has been done with 
#' Google Translate.
#' 
"vocabulary_translation"
