install.packages("tidyverse")
install.packages("dplyr")
install.packages("wordcloud2")
install.packages("tm")

library(tidyverse)
library(dplyr)
library(wordcloud2)
library(tm)

cio <- readLines(file.choose())
milena <- Corpus(VectorSource(cio))
inspect(milena)
toSpace <- milenant_transformer(function (x , pattern ) gsub(pattern, " ", x))
milena <- tm_map(milena, toSpace, "/")
milena <- tm_map(milena, toSpace, "@")
milena <- tm_map(milena, toSpace, "\\|")

# Remove numbers
milena <- tm_map(milena, removeNumbers)
# Remove english common stopwords
milena <- tm_map(milena, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
milena <- tm_map(milena, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
milena <- tm_map(milena, removePunctuation)
# Eliminate extra white spaces
milena <- tm_map(milena, stripWhitespace)
dtm <- TermDocumentMatrix(milena)
q <- as.matrix(dtm)
t <- sort(rowSums(q),decreasing=TRUE)
w <- data.frame(word = names(t),freq=t)
head(w, 10)
wordcloud2(w, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
