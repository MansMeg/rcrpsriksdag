rm(list = ls())

# Read in raw data
data("speeches_raw", package = "rcrpsriksdag")

extract_file_positions <- function(x){
  p <- as.numeric(unlist(stringr::str_split(x, "_|\\."))[c(6, 8)])
  p[1]:p[2]
}

# Create speeches_sentence_raw ----
print(Sys.time())

anforandetext <- speeches_raw$anforandetext
anforandetext <- rcrpsriksdag:::anforandetext_clean_formating(anforandetext)
anforandetext <- rcrpsriksdag:::anforandetext_clean_correct_errors(anforandetext)
anforandetext <- rcrpsriksdag:::anforandetext_clean_remove_comments(anforandetext)

# Clean variables
api_key <- ""

raw_path <- "RPackage/data-raw/raw_data_gavagai/"

# Setup batches of size 100
d <- 1:length(anforandetext)
batches <- split(d, ceiling(seq_along(d)/100))

# Connect and get api calls
pb <- progress::progress_bar$new(total = length(batches))
for(i in seq_along(batches)){
  pb$tick()
  fn <- paste0("gavagai_raw_batch_", i, "_from_", batches[[i]][1], "_to_", batches[[i]][length(batches[[i]])], ".rda")
  fp <- paste0(raw_path, fn)
  if(!file.exists(fp)){
    gavagai_batch <- gavagair::tonality(anforandetext[batches[[i]]], api_key, language = "sv")
    save(gavagai_batch, file = fp)
  } else {
    # cat("Skipped:", fn)
  }
}


# Extract data from Gavagai objects
gavagai_files <- dir(raw_path, full.names = TRUE)
gavagai_names <- dir(raw_path, full.names = FALSE)
ngram_list <- list()
document_list <- list()
sentence_list <- list()
doc_ids <- speeches_raw$anforande_id
pb <- progress::progress_bar$new(total = length(gavagai_files))
for(i in seq_along(gavagai_files)){ # i <- 2
  pb$tick()
  load(gavagai_files[i])
  pos <- extract_file_positions(x = gavagai_names[i])
  doc_id_df <- dplyr::data_frame(doc_id = as.character(1:length(pos)), anforande_id = doc_ids[pos])
  ngram_list[[i]] <- gavagair::tonality_ngram(gavagai_batch)
  ngram_list[[i]] <- dplyr::left_join(ngram_list[[i]], doc_id_df, by = "doc_id")
  document_list[[i]] <- gavagair::tonality_document(gavagai_batch)
  document_list[[i]] <- dplyr::left_join(document_list[[i]], doc_id_df, by = "doc_id")
  sentence_list[[i]] <- gavagair::tonality_sentence(gavagai_batch)
  sentence_list[[i]] <- dplyr::left_join(sentence_list[[i]], doc_id_df, by = "doc_id")
}

ngram_df <- dplyr::bind_rows(ngram_list)
document_df <- dplyr::bind_rows(document_list)
sentence_df <- dplyr::bind_rows(sentence_list)

object.size(gavagai_batch)
object.size(ngram_df)
object.size(document_df)
object.size(sentence_df)

# save(ngram_df, file = "ngram_df.rda")
# save(document_df, file = "document_df.rda")
# save(sentence_df, file = "sentence_df.rda")

# load("ngram_df.rda")
# load("document_df.rda")
# load("sentence_df.rda")


# Add speeches_senetence_raw
speeches_sentence_raw <- sentence_df[, c("anforande_id", "sentence_id", "sentence")]
speeches_sentence_raw$anforande_id <- as.factor(speeches_sentence_raw$anforande_id)
attr(speeches_sentence_raw, "created_date") <- Sys.time() 
attr(speeches_sentence_raw, "created_git_hash") <- rcrpsriksdag:::get_git_sha1()

print(Sys.time())
devtools::use_data(speeches_sentence_raw, overwrite = TRUE, pkg = "RPackage/")
print(Sys.time())

# Clean speeches
speeches_sentence <- speeches_sentence_raw
speeches_sentence$sentence <- 
  rcrpsriksdag:::anforandetext_clean(anforandetext = speeches_sentence$sentence)

print(Sys.time())
devtools::use_data(speeches_sentence, overwrite = TRUE, pkg = "RPackage/")
print(Sys.time())

