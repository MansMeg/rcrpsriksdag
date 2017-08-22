# Read in raw data
data("speeches_raw", package = "rcrpsriksdag")

# Create speeches_sentence_raw ----
print(Sys.time())

anforandetext <- speeches_raw$anforandetext
anforandetext <- rcrpsriksdag:::anforandetext_clean_formating(anforandetext)
anforandetext <- rcrpsriksdag:::anforandetext_clean_correct_errors(anforandetext)
anforandetext <- rcrpsriksdag:::anforandetext_clean_remove_comments(anforandetext)

# Clean variables
api_key <- ""

raw_path <- "RPackage/data-raw/raw_data_gavagai/"

# Setup batches of size 500
d <- 1:length(anforandetext)
batches <- split(d, ceiling(seq_along(d)/500))

# Connect and get api calls
pb <- progress::progress_bar$new(total = length(batches))
for(i in seq_along(batches)){
  pb$tick()
  fn <- paste0("gavagai_raw_batch_", i, "_from_", batches[[i]][1], "_to_", batches[[i]][length(batches[[i]])], ".rda")
  fp <- paste0(raw_path, fn)
  if(!file.exists(fp)){
    gavagai_batch <- gavagair::tonality(anforandetext[batches[[i]]], api_key, language = "sv")
    save(gavagai_batch, file = fp)
  }
}
