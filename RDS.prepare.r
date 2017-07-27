data=read.csv('FinalData.csv')

# count gender 
genderCount <- data %>% count(Gender)

# create a dataframe with all degrees
degree1 <- as.vector(data$Degree)
degree2 <- as.vector(data$Degree.Two)
degree3 <- as.vector(data$Degree.Three)

degreeDF1 <- data.frame("degree"=c(degree1))

degree2 <- degree2[degree2!=""]
degreeDF2 <- data.frame("degree"=c(degree2))

degree3 <- degree2[degree3!=""]
degreeDF3 <- data.frame("degree"=c(degree3))


allDegree=rbind(degreeDF1,degreeDF2,degreeDF3)

# count all degree
degreeCount =allDegree %>% count(degree) %>% mutate(countDegree=n) %>% arrange(desc(countDegree))

###############################################################
#####################process wordcloud#########################
if(!TRUE){
  data$Tags[data$Tags==""]<-NA
  interests <-data$Tags[!is.na(data$Tags)]
  interests <- iconv(interests,to="utf-8")
  interests <- Corpus(VectorSource(interests))
  
  
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  interests <- tm_map(interests, toSpace, ",")
  
  
  interests <- tm_map(interests, PlainTextDocument)
  interests <- tm_map(interests, removeWords, stopwords('english'))
  
  interests <- iconv(interests,to="utf-8")
  
  tm <- DocumentTermMatrix(interests)
  m <- as.matrix(tm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  head(d, 10)
  
  
  wordcloud(interests, max.words = 100, random.order = FALSE)
  
}

save(genderCount, degreeCount, data, file = "Load_at_start.RData")