cody <- readLines(file.choose())
lexy <- Corpus(VectorSource(cody))
inspect(lexy)
toSpace <- lexynt_transformer(function (x , pattern ) gsub(pattern, " ", x))
lexy <- tm_map(lexy, toSpace, "/")
lexy <- tm_map(lexy, toSpace, "@")
lexy <- tm_map(lexy, toSpace, "\\|")

# Remove numbers
lexy <- tm_map(lexy, removeNumbers)
# Remove english common stopwords
lexy <- tm_map(lexy, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
lexy <- tm_map(lexy, removeWords, c("like","got", "gonna","guys","get","really","yeah", "just", "you", "hi","bye","um", "can","sorta", "kinda", "kind of")) 
# Remove punctuations
lexy <- tm_map(lexy, removePunctuation)
# Eliminate extra white spaces
lexy <- tm_map(lexy, stripWhitespace)
dtm <- TermDocumentMatrix(lexy)
y <- as.matrix(dtm)
x <- sort(rowSums(y),decreasing=TRUE)
f <- data.frame(word = names(x),freq=x)
head(f, 10)
wordcloud2(f, size = .5, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9, shape = 'circle', color = 'random-dark')