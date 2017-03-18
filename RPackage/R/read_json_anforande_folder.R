#' Read in all json-zip files in a folder
#' 
#' @param folder A folder with anforande-NNNNNNNN.json.zip files.
#' 
#' @return a \code{tbl_df} \code{data.frame}
#' 
#' @examples 
#' folder <- "RPackage/data-raw/raw_data/"
#' corpus <- read_anforande_json_zip(folder)
#' 
#' @keywords Internal
read_json_anforande_folder <- function(folder){
  checkmate::assert_directory_exists(folder)
  anforande_files <- dir(folder, full.names = TRUE)
  anforande_files <- anforande_files[stringr::str_detect(anforande_files, "anforande-[0-9]*")]
  anforande_files_base <- stringr::str_extract(anforande_files, "anforande-[0-9]*")

  res <- list()
  pb <- txtProgressBar(min = 0, max = length(anforande_files), style = 3)
  for(i in seq_along(anforande_files)) {
    res[[i]] <- read_anforande_json_zip(anforande_files[i])
    setTxtProgressBar(pb, i)
  }
  close(pb)  
  res <- dplyr::bind_rows(res)
  res
}
