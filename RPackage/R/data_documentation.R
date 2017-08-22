#' Debates in the Swedish parliament (raw corpus)
#'
#' @details 
#' Raw data containing debates in the Swedish parliament.
#' @format A \code{tbl_df} with one row debate speech.
#' @seealso \link{speeches}
#' @name speeches_raw
#' @docType data
#' @keywords data
NULL


#' Debates in the Swedish parliament (cleaned corpus)
#'
#' @details 
#' A corpus with one speech per row. 
#' This is a cleaned version of \code{speeches_raw}, see  
#' \code{RPackage/data-raw/speeches.R} on how the data has been cleaned.
#' 
#' @format A \code{tbl_df} with one row debate speech.
#' @seealso \link{speeches_raw}
#' @name speeches
#' @docType data
#' @keywords data
NULL


#' Stop word lists
#'
#' @details 
#' A stopword list of common Swedish stop words.
#' 
#' @name stop_words_se
#' @docType data
#' @keywords data
NULL

#' Translated vocabulary of the speeches corpus
#'
#' @description 
#' This dataset contain translations from Swedish to english for all 
#' individual tokens in the cleaned dataset. Translation has been done with 
#' Google Translate.
#' 
#' @name vocabulary_translation
#' @docType data
#' @keywords data
NULL

