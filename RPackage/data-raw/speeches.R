## Script to generate speeches dataset
devtools::install_local("RPackage/")

# speeches_raw ----
print(Sys.time())

# Read in raw files to tbl_df
speeches_raw <- rcrpsriksdag:::read_json_anforande_folder(folder = "RPackage/data-raw/raw_data") 
attr(speeches_raw, "created_date") <- Sys.time() 
attr(speeches_raw, "created_git_hash") <- rcrpsriksdag:::get_git_sha1()

devtools::use_data(speeches_raw, overwrite = TRUE, pkg = "RPackage/")
# data("speeches_raw", package = "rcrpsriksdag")

# Create speeches ----
print(Sys.time())
speeches <- rcrpsriksdag:::speeches_parse_variables(speeches_raw)


# Clean variables
print(Sys.time())
speeches$anforandetext <- 
  rcrpsriksdag:::anforandetext_clean(speeches$anforandetext)
print(Sys.time())
speeches$anforandetext <- 
  rcrpsriksdag:::anforandetext_replace_collocation(anforandetext = speeches$anforandetext, collocation_folder = "RPackage/data-raw/collocations/")
print(Sys.time())

speeches$parti <- 
  rcrpsriksdag:::parti_clean(parti = speeches$parti)
speeches$role <- 
  rcrpsriksdag:::create_role(talare = speeches$talare)
speeches$talare <- 
  rcrpsriksdag:::talare_clean(talare = speeches$talare)
speeches$debate_type <- 
  rcrpsriksdag:::create_debate_type(avsnittsrubrik = as.character(speeches$avsnittsrubrik))

# Remove observations
speeches <- rcrpsriksdag:::speeches_remove_observations(speeches)
attr(speeches, "created_date") <- Sys.time() 
attr(speeches, "created_git_hash") <- rcrpsriksdag:::get_git_sha1()

print(Sys.time())
devtools::use_data(speeches, overwrite = TRUE, pkg = "RPackage/")
print(Sys.time())

# data("speeches", package = "rcrpsriksdag")
