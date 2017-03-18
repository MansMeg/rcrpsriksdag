#' Read in a json-zip file
#' 
#' @param anforande_json_zip Anforande json zip file
#' 
#' @return a \code{tbl_df} \code{data.frame}
#' 
#' @examples 
#' anforande_json_zip <- "RPackage/data-raw/raw_data/anforande-201516.json.zip" 
#' res <- read_anforande_json_zip(anforande_json_zip)
#' 
#' @keywords Internal
read_anforande_json_zip <- function(anforande_json_zip){
  # Assertions
  checkmate::assert_file(anforande_json_zip)
  file_ext <- stringr::str_extract(anforande_json_zip, "\\.[a-zA-Z]*$")
  checkmate::assert_string(file_ext, ".zip")
  
  tmp_folder <- paste0(tempdir(), "/anf")
  if(dir.exists(tmp_folder)) unlink(tmp_folder, recursive = TRUE)
  dir.create(tmp_folder)
  unzip(zipfile = anforande_json_zip, exdir = tmp_folder)
  json_files <- dir(tmp_folder, full.names = TRUE)
  
  parsed_json <- lapply(json_files, parse_anforande_json)
  df <- dplyr::bind_rows(parsed_json)
  
  unlink(tmp_folder, recursive = TRUE)
  
  df
}

#' @rdname read_anforande_json_zip
#' @param json_file a json file from an anforande json zip file.
#' @keywords Internal
parse_anforande_json <- function(json_file){
  checkmate::assert_character(json_file, len = 1)
  checkmate::assert_file_exists(json_file)
  anf <- suppressWarnings(jsonlite::fromJSON(json_file))
  dat <- dplyr::as_data_frame(lapply(anf$anforande, function(X) if(is.null(X)) "NULL" else X), stringsAsFactors = FALSE)
  
  checkmate::assert_class(dat, "tbl_df")
  return(dat)
}
