#' Compute a test_set indicator
#'
#' @param corpus a \code{speeches} corpus.
#' @param seed the \code{seed} to generate create the test set for. 
#' @param size the size of the test set.
#'
#' @keywords Internal
create_test_set <- function(corpus, seed = 4711, size = 10000){
  set.seed(seed)
  test_set <- logical(nrow(corpus))
  test_set[sample(1:nrow(corpus), size = size)] <- TRUE
  test_set
}
