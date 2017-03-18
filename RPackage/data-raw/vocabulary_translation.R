# Store stop words
vocabulary_translation <- readLines("RPackage/data-raw/vocabulary_translation.txt")
x <- stringr::str_split(vocabulary_translation, pattern = "\"")
vocabulary_translation <- 
  dplyr::data_frame(sv = unlist(lapply(x, FUN = function(x) x[2])),
                    en = unlist(lapply(x, FUN = function(x) x[4])))
attr(vocabulary_translation, "created_date") <- Sys.time() 
attr(vocabulary_translation, "created_git_hash") <- rcrpsriksdag:::get_git_sha1()

devtools::use_data(vocabulary_translation, overwrite = TRUE, pkg = "RPackage/")