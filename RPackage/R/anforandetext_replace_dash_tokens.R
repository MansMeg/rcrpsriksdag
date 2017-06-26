#' Replace dashed tokens in anforandetext
#' 
#' @details 
#' This function handles dashes used in the corpus. 
#' There are two main uses for dashes: 
#' 1) New lines that cuts words and 
#' 2) Combined words
#' 
#' @param speeches a speeches corpus object
#' 
#' @keywords Internal
anforandetext_replace_dash_tokens <- function(speeches){
  checkmate::assert_class(speeches, "tbl_df")

  # Replace known errors
  speeches <- anforandetext_replace_token_errors(speeches, token_errors_folder = "RPackage/data-raw/dash_errors/")

  # Combine the rest of the dash separations
  speeches$anforandetext <- stringr::str_replace_all(speeches$anforandetext, "-", "")
  speeches$anforandetext <- stringr::str_replace_all(speeches$anforandetext, "[:space:]+", " ")
  
  speeches
}

