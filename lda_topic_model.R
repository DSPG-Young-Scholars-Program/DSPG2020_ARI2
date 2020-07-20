library(dplyr)
library(tidyverse)
library(tidytext)
library(stm)
library(quanteda)
library(ggplot2)

job_perf <- read.csv("/project/class/bii_sdad_dspg/uva/dod_ari2")

#Grouping by scale source/citation if we want to consider texts as documents instead of individual scale items
job_perf <- job_perf %>%
  group_by(CITATION) %>%
  summarise(scale = paste0(ITEM, collapse = " "))

#STM Model
processed.scale <- textProcessor(documents = job_perf$scale, metadata = job_perf, lowercase = TRUE,
                                 removestopwords = TRUE, removenumbers = TRUE,
                                 removepunctuation = TRUE, ucp = FALSE, stem = TRUE,
                                 wordLengths = c(3, Inf), sparselevel = 1, language = "en",
                                 verbose = TRUE, onlycharacter = FALSE, striphtml = FALSE,
                                 customstopwords = NULL, custompunctuation = NULL, v1 = FALSE)

out.scale <- prepDocuments(documents = processed.scale$documents, vocab = processed.scale$vocab,
                           meta = processed.scale$meta, lower.thresh = 1, upper.thresh = Inf,
                           subsample = FALSE, verbose = TRUE)
docs.scale <- out.scale$documents
vocab.scale <- out.scale$vocab
meta.scale <- out.scale$meta

