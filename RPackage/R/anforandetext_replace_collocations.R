#' Replace collocations in anforandetext
#' 
#' Replace collocations in data-raw collocations
#' 
#' @param anforandetext a character vector from anforandetext in corpus file
#' @param collocation_folder a path to a folder with files with one collocation per row.
#' 
#' @examples 
#' collocation_folder <- "RPackage/data-raw/collocations/"
#' txt <- speeches$anforandetext
#' anforandetext_replace_collocation(txt, collocation_folder)
#' 
#' @keywords Internal
anforandetext_replace_collocation <- function(anforandetext, collocation_folder){
  checkmate::assert_character(anforandetext)
  checkmate::assert_directory_exists(collocation_folder)

  raw <- read_in_collocation_files(collocation_folder)

  from <- paste0("(^| )", raw, "($| )")#[1:200]
  to <- paste0(" ", stringr::str_replace_all(raw, " ", "_"), " ")#[1:200]
  for(i in seq_along(to)){
    anforandetext <- stringr::str_replace_all(anforandetext, from[i], to[i])
  }

  # Trim 
  anforandetext <- stringr::str_trim(anforandetext)
  anforandetext <- stringr::str_replace_all(anforandetext, "( )+", " ")
  
  anforandetext
}



#' Read in the files in collocation folders
#' 
#' @param collocation_folder a path to a folder with files with one collocation per row.
#' 
#' @keywords Internal
read_in_collocation_files <- function(collocation_folder){
  checkmate::assert_directory_exists(collocation_folder)
  
  collocation_files <- dir(collocation_folder, full.names = TRUE)
  
  raw <- list()
  for(i in seq_along(collocation_files)){
    raw[[i]] <- readLines(collocation_files[i])
    checkmate::assert_character(raw[[i]], min.chars = 3, pattern = " ")
  }
  raw <- do.call(c,raw)

  # Remove duplicates
  raw[!duplicated(raw)]
}

