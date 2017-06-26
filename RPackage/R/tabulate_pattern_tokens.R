#' Tablulate tokens identified by pattern
#' 
#' @param txt A character vector to find the pattern within
#' @param pattern The pattern to extract tokens from.
#' 
#' @keywords Internal
#' @export
tabulate_pattern_tokens <- function(txt, pattern){
  checkmate::assert_character(txt)
  checkmate::assert_string(pattern)
  
  pat <- paste0("(^| )", pattern , "($| )")
  sub_idx <- stringr::str_detect(txt, pat)
  sub_txt <- txt[sub_idx] 
  results <- unlist(stringr::str_extract_all(sub_txt, pattern))
  results <- stringr::str_trim(results)
  results <- dplyr::data_frame(token = results)
  results <- dplyr::count(results, token)
  results <- arrange(results, desc(n))
  results
}