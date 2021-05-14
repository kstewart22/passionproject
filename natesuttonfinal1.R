nate <- readLines(file.choose())
sutton <- Corpus(VectorSource(nate))
inspect(sutton)
toSpace <- suttonnt_transformer(function (x , pattern ) gsub(pattern, " ", x))
sutton <- tm_map(sutton, toSpace, "/")
sutton <- tm_map(sutton, toSpace, "@")
sutton <- tm_map(sutton, toSpace, "\\|")

# Remove numbers
sutton <- tm_map(sutton, removeNumbers)
# Remove english common stopwords
sutton <- tm_map(sutton, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
sutton <- tm_map(sutton, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
sutton <- tm_map(sutton, removePunctuation)
# Eliminate extra white spaces
sutton <- tm_map(sutton, stripWhitespace)
dtm <- TermDocumentMatrix(sutton)
b <- as.matrix(dtm)
u <- sort(rowSums(b),decreasing=TRUE)
x <- data.frame(word = names(u),freq=u)
head(x, 10)
wordcloud2(x, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')
