#' Replace token errors in anforandetext
#' 
#' @param anforandetext a character vector from anforandetext in corpus file
#' @param token_errors_folder a path to a folder with files with one collocation per row.
#' 
#' @examples 
#' token_errors_folder <- "RPackage/data-raw/dash_errors"
#' token_errors_folder <- "RPackage/data-raw/token_errors/"
#' anforandetext_replace_collocation(txt, token_errors_folder)
#' 
#' @keywords Internal
anforandetext_replace_token_errors <- function(speeches, token_errors_folder){
  checkmate::assert_class(speeches, "tbl_df")
  checkmate::assert_directory_exists(token_errors_folder)

  errored_tokens <- read_in_token_error_files(token_errors_folder)
  checkmate::assert(!any(duplicated(errored_tokens$wrong_token)))
  
  # Tokenize corpus
  tok_speeches <- suppressMessages(rcrpsriksdag::tokenize_speeches(speeches, 0))
  tok_speeches <- dplyr::mutate(tok_speeches, token = as.character(token))
  
  # Match with left_join
  tok_speeches <- dplyr::left_join(tok_speeches, errored_tokens, by = c("token" = "wrong_token"))
  
  # Choose token using ifelse
  tok_speeches$token[!is.na(tok_speeches$true_token)] <- 
    tok_speeches$true_token[!is.na(tok_speeches$true_token)]

  # Drop columns
  tok_speeches$true_token <- NULL
  
  # Paste together to full text again
  tok_speeches <- dplyr::group_by(tok_speeches, anforande_id)
  res <- dplyr::summarise(tok_speeches, anforandetext_new = paste(token, collapse = " "))
  rm(tok_speeches)
  res$anforande_id <- as.character(res$anforande_id)
  
  # Merge to speeches and remove old variable
  speeches$no <- 1:nrow(speeches)
  speeches <- dplyr::left_join(speeches, res, by = "anforande_id")
  speeches <- dplyr::arrange(speeches, no)
  speeches$no <- NULL

  # Bugg check
  # txt1 <- stringr::str_replace_all(speeches$anforandetext, "-|_", " ")
  # txt2 <- stringr::str_replace_all(speeches$anforandetext_new, "-|_", " ")
  # idx <- which(txt1 != txt2)
  
  speeches$anforandetext <- speeches$anforandetext_new
  speeches$anforandetext_new <- NULL

  # Trim 
  speeches$anforandetext <- stringr::str_trim(speeches$anforandetext)
  speeches$anforandetext <- stringr::str_replace_all(speeches$anforandetext, "( )+", " ")
  
  speeches
}

#' Read in the files in collocation folders
#' 
#' @param collocation_folder a path to a folder with files with one collocation per row.
#' 
#' @keywords Internal
read_in_token_error_files <- function(token_errors_folder){
  checkmate::assert_directory_exists(token_errors_folder)
  
  files <- dir(token_errors_folder, full.names = TRUE)
  
  raw <- list()
  for(i in seq_along(files)){
    raw[[i]] <- dplyr::as_data_frame(read.csv(files[i], stringsAsFactors = FALSE))
    checkmate::assert_class(raw[[i]], "tbl_df")
    checkmate::assert_names(names(raw[[i]]), identical.to =  c("wrong_token", "true_token"))
    checkmate::assert_character(raw[[i]]$wrong_token)
    checkmate::assert_character(raw[[i]]$true_token)
  }
  results <- dplyr::bind_rows(raw)
  
  # Remove duplicates
  results <- results[!duplicated(results),]
  results
}

