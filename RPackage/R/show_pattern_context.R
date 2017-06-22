#' Show a pattern within a textual context.
#' 
#' @param txt A character vector to find the pattern within
#' @param pattern The pattern to show the context for.
#' @param character_window The context size in number of characters.
#' 
#' @keywords Internal
#' @export
show_pattern_context <- function(txt, pattern, character_window = 30){
  checkmate::assert_character(txt)
  checkmate::assert_string(pattern)
  checkmate::assert_integerish(character_window, lower = 0)
  
  sub_idx <- stringr::str_detect(txt, pattern)
  sub_txt <- speeches$anforandetext[sub_idx] 
  pos <- stringr::str_locate_all(sub_txt, pattern)
  n <- length(unlist(pos))/2
  ctx <- character(n)
  
  
  ctx_idx <- 1
  for(i in seq_along(pos)){
    for(j in 1:nrow(pos[[i]])){
      ctx[ctx_idx] <-
        stringr::str_sub(sub_txt[i], start = pos[[i]][j,"start"] - character_window, pos[[i]][j,"end"] + character_window)
      ctx_idx <- ctx_idx + 1
    }
  }
  ctx
}