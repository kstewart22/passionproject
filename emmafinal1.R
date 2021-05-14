jenkins <- readLines(file.choose())
emma <- Corpus(VectorSource(jenkins))
inspect(emma)
toSpace <- emmant_transformer(function (x , pattern ) gsub(pattern, " ", x))
emma <- tm_map(emma, toSpace, "/")
emma <- tm_map(emma, toSpace, "@")
emma <- tm_map(emma, toSpace, "\\|")

# Remove numbers
emma <- tm_map(emma, removeNumbers)
# Remove english common stopwords
emma <- tm_map(emma, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
emma <- tm_map(emma, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
emma <- tm_map(emma, removePunctuation)
# Eliminate extra white spaces
emma <- tm_map(emma, stripWhitespace)
dtm <- TermDocumentMatrix(emma)
a <- as.matrix(dtm)
o <- sort(rowSums(a),decreasing=TRUE)
d <- data.frame(word = names(o),freq=o)
head(d, 10)
wordcloud2(d, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
