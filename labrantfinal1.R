install.packages("tidyverse")
install.packages("wordcloud2")
install.packages("dplyr")
install.packages ("tm")

library(tidyverse)
library(dplyr)
library(tm)
library(wordcloud2)


sav <- readLines(file.choose())
labrant <- Corpus(VectorSource(sav))
inspect(labrant)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
labrant <- tm_map(labrant, toSpace, "/")
labrant <- tm_map(labrant, toSpace, "@")
labrant <- tm_map(labrant, toSpace, "\\|")

# Remove numbers
labrant <- tm_map(labrant, removeNumbers)
# Remove english common stopwords
labrant <- tm_map(labrant, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
labrant <- tm_map(labrant, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
labrant <- tm_map(labrant, removePunctuation)
# Eliminate extra white spaces
labrant <- tm_map(labrant, stripWhitespace)
dtm <- TermDocumentMatrix(labrant)
v <- as.matrix(dtm)
c <- sort(rowSums(v),decreasing=TRUE)
l <- data.frame(word = names(c),freq=c)
head(l, 10)
wordcloud2(l, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
