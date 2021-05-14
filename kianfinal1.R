naik <- readLines(file.choose())
kian <- Corpus(VectorSource(naik))
inspect(kian)
toSpace <- kiannt_transformer(function (x , pattern ) gsub(pattern, " ", x))
kian <- tm_map(kian, toSpace, "/")
kian <- tm_map(kian, toSpace, "@")
kian <- tm_map(kian, toSpace, "\\|")

# Remove numbers
kian <- tm_map(kian, removeNumbers)
# Remove english common stopwords
kian <- tm_map(kian, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
kian <- tm_map(kian, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
kian <- tm_map(kian, removePunctuation)
# Eliminate extra white spaces
kian <- tm_map(kian, stripWhitespace)
dtm <- TermDocumentMatrix(kian)
h <- as.matrix(dtm)
i <- sort(rowSums(h),decreasing=TRUE)
p <- data.frame(word = names(i),freq=i)
head(p, 10)
wordcloud2(p, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')