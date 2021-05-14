kris <- readLines(file.choose())
johns <- Corpus(VectorSource(kris))
inspect(johns)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
johns <- tm_map(johns, toSpace, "/")
johns <- tm_map(johns, toSpace, "@")
johns <- tm_map(johns, toSpace, "\\|")

# Remove numbers
johns <- tm_map(johns, removeNumbers)
# Remove english common stopwords
johns <- tm_map(johns, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
johns <- tm_map(johns, removeWords, c("like", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
johns <- tm_map(johns, removePunctuation)
# Eliminate extra white spaces
johns <- tm_map(johns, stripWhitespace)
dtm <- TermDocumentMatrix(johns)
m <- as.matrix(dtm)
k <- sort(rowSums(m),decreasing=TRUE)
j <- data.frame(word = names(k),freq=k)
head(j, 10)
wordcloud2(j, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
