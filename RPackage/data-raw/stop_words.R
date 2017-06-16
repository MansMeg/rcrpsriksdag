# Store stop words
stop_words_se <- readLines("RPackage/data-raw/stopwords/se.txt", encoding = "UTF-8")

attr(stop_words_se, "created_date") <- Sys.time() 
attr(stop_words_se, "created_git_hash") <- rcrpsriksdag:::get_git_sha1()

devtools::use_data(stop_words_se, overwrite = TRUE, pkg = "RPackage/")
