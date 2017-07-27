if(!require(needs)){install.packages("needs")}
needs::needs(shiny, shinydashboard, htmltools, dplyr, ggmap, leaflet, googleVis, ggplot2,
             plotly, RColorBrewer, tm, SnowballC, wordcloud)

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

#=================================== start server=====================================
shinyServer(function(input, output, session) {
  output$gender <- renderPlotly({
    
    p <- plot_ly(
      genderCount,
      x= ~Gender,
      y= ~n,
      name = "Gender",
      type = "bar",
      marker = list(color = c('rgba(255, 133, 133,1)', 'rgba(158, 216, 255, 1)')))%>%
      layout(autosize = T)#, width = 4, height = 900)
    
  })
  
  output$degree <- renderPlotly({
    g <- ggplot(degreeCount,aes(x=reorder(degree,countDegree),y=countDegree,fill=countDegree))+geom_bar(stat='identity')+coord_flip()
    ggplotly(g) %>% layout(autosize = T)

    })
  
  
  # cluster markers map
  output$location <- renderLeaflet({
    leaflet(data) %>% addTiles() %>% addMarkers(lng = ~long, lat = ~lat,popup =paste(data$Name,"<br>",data$University,"<br>",data$Degree,"<br>"),
                                                clusterOptions = markerClusterOptions())
    
  })
  
  
  # map section; can be opted to change 
  output$schoolMap <- renderLeaflet({
    leaflet(data) %>% addTiles() %>%
      addCircles(lng = ~long, lat = ~lat, weight = 1,
                 radius = ~sqrt(tuition)*1400, popup = data$University) 
    
  })
  
  
  
})

