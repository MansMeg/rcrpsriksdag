#' Clean the parti variable in the corpus file
#'
#' @param parti a character vector from anforandetext in corpus file
#'
#' @keywords Internal
parti_clean <- function(parti){
  parti <- as.character(parti)
  parti <- tolower(parti)
  
  parti[parti=="kds"] <- "kd"
  parti[parti=="fp"] <- "l"
  parti[parti=="-"] <- "null"
  parti[nchar(parti) > 4] <- "null"

  parti <- as.factor(parti)
  parti
}

