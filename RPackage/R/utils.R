#' Get git hash
#' 
#' @param repo repository to get git hash from.
#' 
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

