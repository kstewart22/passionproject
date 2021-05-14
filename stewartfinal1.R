art <- readLines(file.choose())
stew <- Corpus(VectorSource(art))
inspect(stew)
toSpace <- stewnt_transformer(function (x , pattern ) gsub(pattern, " ", x))
stew <- tm_map(stew, toSpace, "/")
stew <- tm_map(stew, toSpace, "@")
stew <- tm_map(stew, toSpace, "\\|")

# Remove numbers
stew <- tm_map(stew, removeNumbers)
# Remove english common stopwords
stew <- tm_map(stew, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
stew <- tm_map(stew, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
stew <- tm_map(stew, removePunctuation)
# Eliminate extra white spaces
stew <- tm_map(stew, stripWhitespace)
dtm <- TermDocumentMatrix(stew)
z <- as.matrix(dtm)
y <- sort(rowSums(z),decreasing=TRUE)
a <- data.frame(word = names(y),freq=y)
head(a, 10)
wordcloud2(a, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')