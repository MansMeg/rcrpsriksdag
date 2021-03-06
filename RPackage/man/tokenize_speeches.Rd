% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tokenize_speeches.R
\name{tokenize_speeches}
\alias{tokenize_speeches}
\title{Tokenize the corpus}
\usage{
tokenize_speeches(corpus, rare_word_limit = 10, stop_list = NULL)
}
\arguments{
\item{corpus}{a \code{speeches} corpus to tokenize.}

\item{rare_word_limit}{The rare word limit to use (tokens for word types occuring less or equal to the limit is removed).}

\item{stop_list}{a character vector}
}
\description{
Tokenize and remove stopwords and rare words from the \code{speeches} corpus. It tokenizes based solely on one space.
}
\examples{
data("stop_words_se")
data("speeches")
speeches_tokenized <- tokenize_speeches(speeches, 10, stop_words_se)

}
