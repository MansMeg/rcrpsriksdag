% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/anforandetext_clean.R
\name{anforandetext_clean}
\alias{anforandetext_clean}
\alias{anforandetext_clean_formating}
\alias{anforandetext_clean_correct_errors}
\alias{anforandetext_clean_remove_greetings}
\alias{anforandetext_clean_remove_comments}
\alias{anforandetext_clean_handle_digits}
\alias{anforandetext_clean_symbols}
\alias{anforandetext_clean_punctuation}
\alias{anforandetext_handle_abbreviations}
\alias{anforandetext_mark_sentances}
\title{Clean the anforandetext in the corpus file}
\usage{
anforandetext_clean(anforandetext)

anforandetext_clean_formating(anforandetext)

anforandetext_clean_correct_errors(anforandetext)

anforandetext_clean_remove_greetings(anforandetext)

anforandetext_clean_remove_comments(anforandetext)

anforandetext_clean_handle_digits(anforandetext)

anforandetext_clean_symbols(anforandetext)

anforandetext_clean_punctuation(anforandetext)

anforandetext_handle_abbreviations(anforandetext)

anforandetext_mark_sentances(anforandetext)
}
\arguments{
\item{anforandetext}{a character vector from anforandetext in corpus file}
}
\description{
These functions contain all preprocessing of corpus text.
}
\details{
\code{anforandetext_clean_symbols} needs to be called after 
\code{tolower} since only lower case characters are cleaned.
}
\keyword{Internal}
