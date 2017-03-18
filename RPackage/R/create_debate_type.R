#' Create debate type
#'
#' @param avsnittsrubrik Avsnittsrubrik to use to identify \code{debate_type}
#'
#' @keywords Internal
create_debate_type <- function(avsnittsrubrik){
  checkmate::assert_character(avsnittsrubrik, any.missing = FALSE)
  
  avsnittsrubrik <- tolower(as.character(avsnittsrubrik))
  debate_type <- character(length(avsnittsrubrik))
  
  debate_type[stringr::str_detect(avsnittsrubrik, "partiledardebatt")] <- "Party leader debate"
  
  # tab <- table(avsnittsrubrik[debate_type == ""])
  # tab[order(tab, decreasing = TRUE)][1:100]
    
  debate_type[debate_type == ""] <- "Other debates"
  as.factor(debate_type)
}
