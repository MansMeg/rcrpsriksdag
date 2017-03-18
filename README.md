# `rcrpsriksdag`
This repository contain a cleaned up version of speeches in the Swedish parliament.

## More information

The data has been downloaded from [https://data.riksdagen.se/data/anforanden/](https://data.riksdagen.se/data/anforanden/).

For more information on `dokument_id`, see [http://data.riksdagen.se/dokumentation/sa-funkar-dokument-id/](http://data.riksdagen.se/dokumentation/sa-funkar-dokument-id/) (in Swedish).

For more information on different document types, see [http://data.riksdagen.se/sv/koder/?typ=doktyp&utformat=html](http://data.riksdagen.se/sv/koder/?typ=doktyp&utformat=html) (in Swedish).

## Get the data
There are two ways to access data due since it is not possible to install github packages that uses git large-file-system (lfs).

Below is examples on how to get the data and tokenize the corpus in two different ways. The main file of interest is the `speeches` corpus.

### Just give me the data! (fast version)

1. Download the files you want to download [here](https://github.com/MansMeg/rcrpsriksdag/tree/master/RPackage/data).

The documentation of the files can be found [here](https://github.com/MansMeg/rcrpsriksdag/blob/master/RPackage/R/data_documentation.R).

2. Load them into R with `load()`.

3. Tokenize corpus
Source the `tokenize_speeches` function:
```
source("https://raw.githubusercontent.com/MansMeg/rcrpsriksdag/master/RPackage/R/tokenize_speeches.R")
```
Download and load the stop word dataset `stop_word_se` [here](https://github.com/MansMeg/rcrpsriksdag/tree/master/RPackage/data) and the cleaned corpus `speeches` [here](https://github.com/MansMeg/rcrpsriksdag/tree/master/RPackage/data).

The tokenize the corpus as follows (you may need to install the `dplyr`, `tidytext` and `checkmate` R packages)
```
speeches_tokens <- 
  tokenize_speeches(speeches, rare_word_limit = 10, stop_words_se)
```

### Clone and install R data package (get _everything_ in a more robust way)
To get the whole corpus, documentation and functionality. This is useful if you want to clean your own corpus or want to be able to reproduce the cleaning of the full corpus.

1. Clone the repository to you local harddrive (you need git and git lfs).

2. Install the package
```
devtools::install_local(path = [the cloned repo path], subdir = "RPackage")
```
When the package has been installed, you don't need the downloaded repository/zip-file any more.

3. Access data
```
# Data in package
data(package = "rcrpsriksdag")
# Load cleaned corpus
data(speeches, package = "rcrpsriksdag")
data(stop_words_se, package = "rcrpsriksdag")
```

4. Tokenize corpus
```
speeches_tokens <- 
  rcrpsriksdag::tokenize_speeches(speeches, rare_word_limit = 10, stop_words_se)
```
