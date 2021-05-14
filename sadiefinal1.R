install.packages("tidyverse")
install.packages("wordcloud2")
install.packages("dplyr")
install.packages ("tm")

library(tidyverse)
library(dplyr)
library(tm)
library(wordcloud2)

huff <- readLines(file.choose())
sadie <- Corpus(VectorSource(huff))
inspect(sadie)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
sadie <- tm_map(sadie, toSpace, "/")
sadie <- tm_map(sadie, toSpace, "@")
sadie <- tm_map(sadie, toSpace, "\\|")

# Remove numbers
sadie <- tm_map(sadie, removeNumbers)
# Remove english common stopwords
sadie <- tm_map(sadie, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
sadie <- tm_map(sadie, removeWords, c("like", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
sadie <- tm_map(sadie, removePunctuation)
# Eliminate extra white spaces
sadie <- tm_map(sadie, stripWhitespace)
dtm <- TermDocumentMatrix(sadie)
s <- as.matrix(dtm)
r <- sort(rowSums(s),decreasing=TRUE)
h <- data.frame(word = names(r),freq=r)
head(h, 10)
wordcloud2(h, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
