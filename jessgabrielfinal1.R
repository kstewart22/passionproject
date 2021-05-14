jess <- readLines(file.choose())
conte <- Corpus(VectorSource(jess))
inspect(conte)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
conte <- tm_map(conte, toSpace, "/")
conte <- tm_map(conte, toSpace, "@")
conte <- tm_map(conte, toSpace, "\\|")

# Remove numbers
conte <- tm_map(conte, removeNumbers)
# Remove english common stopwords
conte <- tm_map(conte, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
conte <- tm_map(conte, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
conte <- tm_map(conte, removePunctuation)
# Eliminate extra white spaces
conte <- tm_map(conte, stripWhitespace)
dtm <- TermDocumentMatrix(conte)
e <- as.matrix(dtm)
g <- sort(rowSums(e),decreasing=TRUE)
n <- data.frame(word = names(g),freq=g)
head(n, 10)
wordcloud2(n, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
