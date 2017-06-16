#' Get git hash
#' 
#' @param repo repository to get git hash from.
#' 
#' @keywords Internal
get_git_sha1 <- function(repo = ".") {
  r <- git2r::repository(repo, discover = TRUE)
  rev <- git2r::head(r)
  if (is.null(rev)) {
    return(NULL)
  }
  if (git2r::is_commit(rev)) {
    rev@sha
  } else {
    git2r::branch_target(rev)
  }
}


#' Compute the vocabulary size of a corpus
#' @param corpus a \code{speeches} corpus to compute vocabulary size for.
#' 
#' @keywords Internal
compute_vocabulary_size <- function(corpus){
  corpus <- rcrpsriksdag::tokenize_speeches(corpus, rare_word_limit = 0, stop_list = NULL)
  word_freq <- dplyr::count(corpus, token)

  nrow(word_freq)
}

#' Compute the vocabulary size of a corpus
#' @param collocation_folder a path to a folder with files with one collocation per row.
#' 
#' @keywords Internal
compute_collocation_size <- function(collocation_folder){
  checkmate::assert_directory_exists(collocation_folder)
  
  raw <- rcrpsriksdag:::read_in_collocation_files(collocation_folder)
  
  sum(unlist(lapply(raw, length)))
}
