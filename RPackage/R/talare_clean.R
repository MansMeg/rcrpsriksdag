#' Clean the parti variable in the corpus file
#'
#' @param parti a character vector from anforandetext in corpus file
#'
#' @keywords Internal
talare_clean <- function(talare){
  talare <- as.character(talare)
  talare <- tolower(talare)
  talare <- stringr::str_replace_all(talare, "replik", "")
  talare <- stringr::str_trim(talare)
  
  talare <- stringr::str_replace_all(talare, "^.+minister(n)?", " ")
  talare <- stringr::str_replace_all(talare, "^.+mininister", " ")
  talare <- stringr::str_replace_all(talare, "^.+president", " ")
  talare <- stringr::str_replace_all(talare, "^.*statsrådet", " ")
  talare <- stringr::str_trim(talare)

  talare <- stringr::str_replace_all(talare, "\\(kds\\)", "\\(kd\\)")  
  talare <- stringr::str_replace_all(talare, "\\(fp\\)", "\\(l\\)")  
  talare <- stringr::str_replace_all(talare, "©", "\\(c\\)")  

  talare <- stringr::str_replace_all(talare, "\\(v$", "\\(v\\)")  
  talare <- stringr::str_replace_all(talare, "\\(s$", "\\(s\\)")  
  
  talare <- stringr::str_replace_all(talare, "null", "namn saknas")
  talare <- stringr::str_replace_all(talare, ".*kommer att vara.*", "namn saknas")
  talare <- stringr::str_replace_all(talare, "^en$", "namn saknas")
  
  talare <- stringr::str_replace_all(talare, "talmanen", "talmannen")
  talare <- stringr::str_replace_all(talare, "andre vice talman", "andre vice talmannen")
  talare <- stringr::str_replace_all(talare, ".*av andre vice talmannen därefter.*", "andre vice talmannen")
  talare <- stringr::str_replace_all(talare, ".*av andre vice talmannennen därefter.*", "andre vice talmannen")
  talare <- stringr::str_replace_all(talare, ".*av förste vice talmannen därefter.*", "förste vice talmannen")
  talare <- stringr::str_replace_all(talare, "talmannnen", "talmannen")
  
  talare <- stringr::str_replace_all(talare, "anderssson", "andersson")
  talare <- stringr::str_replace_all(talare, "ulla vester", "ulla wester")
  talare <- stringr::str_replace_all(talare, "ulf nilson", "ulf nilsson")
  talare <- stringr::str_replace_all(talare, "tobias bill-ström", "tobias billström")
  talare <- stringr::str_replace_all(talare, "tassos stafilidis", "tasso stafilidis")
  talare <- stringr::str_replace_all(talare, "tasso stafilides", "tasso stafilidis")
  
  talare <- as.factor(talare)
  
  talare
}
