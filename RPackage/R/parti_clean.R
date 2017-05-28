#' Clean the parti variable in the corpus file
#'
#' @param parti a character vector from anforandetext in corpus file
#'
#' @keywords Internal
parti_clean <- function(parti, talare){
  checkmate::assert_factor(parti)
  checkmate::assert_factor(talare)
  
  parti <- as.character(parti)
  parti <- tolower(parti)
  
  parti[parti=="kds"] <- "kd"
  parti[parti=="fp"] <- "l"
  parti[parti=="-"] <- "null"
  parti[nchar(parti) > 4] <- "null"

  talare_parti <- stringr::str_extract(talare, pattern = "\\(.+\\)")
  talare_parti <- stringr::str_extract(talare_parti, pattern = "[a-z]+")
  talare_parti[is.na(talare_parti)] <- "null"
  diff_idx <- which(talare_parti!=parti)
  warning(length(diff_idx), " differences in party between variable 'talare' and 'parti'.")
  parti[diff_idx] <- talare_parti[diff_idx]
  
  parti <- as.factor(parti)
  parti
}

