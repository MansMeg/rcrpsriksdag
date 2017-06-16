#' Replace collocations in anforandetext
#' 
#' Replace collocations in data-raw collocations
#' 
#' @param anforandetext a character vector from anforandetext in corpus file
#' @examples 
#' collocation_folder <- "RPackage/data-raw/collocations/"
#' anforandetext_replace_collocation(txt, collocation_folder)
#' 
#' @keywords Internal
anforandetext_replace_collocation <- function(anforandetext, collocation_folder){
  checkmate::assert_character(anforandetext)
  checkmate::assert_directory_exists(collocation_folder)

  collocation_files <- dir(collocation_folder, full.names = TRUE)

  raw <- list()
  for(i in seq_along(collocation_files)){
    raw[[i]] <- readLines(collocation_files[i])
    checkmate::assert_character(raw[[i]], min.chars = 3, pattern = " ")
  }
  
  for(i in seq_along(raw)){
    from <- paste0("(^| )", raw[[i]], "($| )")
    to <- paste0(" ", stringr::str_replace_all(raw[[i]], " ", "_"), " ")
    for(j in seq_along(to)){
      anforandetext <- stringr::str_replace_all(anforandetext, from[j], to[j])
    }
  }

  # Trim 
  anforandetext <- stringr::str_trim(anforandetext)
  anforandetext <- stringr::str_replace_all(anforandetext, "( )+", " ")
  
  anforandetext
}
