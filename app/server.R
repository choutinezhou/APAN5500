
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
#================= wordcloud of Experience=====================
data$Exp...From.Field..[data$Exp...From.Field..==""]<-NA
experience <-data$Exp...From.Field..[!is.na(data$Exp...From.Field..)]
experience <- Corpus(VectorSource(experience))


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
experience <- tm_map(experience, toSpace, ",")
experience <- tm_map(experience, toSpace, "/")
experience <- iconv(experience,to="utf-8")

# interests <- tm_map(interests, PlainTextDocument)
# interests <- tm_map(interests, removePunctuation)
# interests <- tm_map(interests, removeWords, stopwords('english'))
# 


# tm <- TermDocumentMatrix(experience)
# m <- as.matrix(tm)
# v <- sort(rowSums(m),decreasing=TRUE)
# d <- data.frame(word = names(v),freq=v)
# head(d, 10)

#wordcloud(experience,min.freq=1, max.words = 100, random.order = FALSE,colors=brewer.pal(8,"Dark2"))

# =================================wordcould of career goal=================================================
data$Carrer.Plan...To.Field..[data$Carrer.Plan...To.Field..==""]<-NA
goal <-data$Carrer.Plan...To.Field..[!is.na(data$Carrer.Plan...To.Field..)]
goal <- Corpus(VectorSource(goal))


toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
goal <- tm_map(goal, toSpace, ",")
goal <- tm_map(goal, toSpace, "/")
goal <- iconv(goal,to="utf-8")

# wordcloud(goal,min.freq=1, max.words = 100, random.order = FALSE,colors=brewer.pal(8,"Dark2"))

#=================================== start server=====================================
function(input, output, session) {
  output$gender <- renderPlotly({
    f <- list(
      family = "Arial",
      size = 24,
      color = "#2F4F4F	"
    )
    x <- list(
      title = "Gender",
      titlefont = f,
      tickfont = f
    )
    y <- list(
      title = "Count",
      titlefont = f,
      tickfont = f
    )
    
    p <- plot_ly(
      genderCount,
      x= ~Gender,
      y= ~n,
      name = "Gender",
      type = "bar",
      marker = list(color = c('rgba(255, 133, 133,1)', 'rgba(158, 216, 255, 1)')))%>%
      layout(xaxis = x, yaxis = y,autosize = F, width = 8, height = 1000)
    
  })

  output$degree <- renderPlotly({
    s <- list(
      family = "Arial",
      size = 20,
      color = "#2F4F4F	"
    )
    x <- list(
      title = "Count",
      titlefont = s,
      tickfont = s
    )
    y <- list(
      title = "Degree",
      titlefont = s,
      tickfont = s
    )
    g <- ggplot(degreeCount,aes(x=reorder(degree,countDegree),y=countDegree,fill=countDegree,text= paste("Count:",countDegree)))+geom_bar(stat='identity')+coord_flip()
    ggplotly(g,tooltip ="text")%>% layout(xaxis = x, yaxis = y,height = 1100, width = 1200,
                          margin=list(
                                            l=250,
                                            r=50,
                                            b=100,
                                            t=100,
                                            pad=4))

    })
  
  
  # cluster markers map
  output$location <- renderLeaflet({
    leaflet(data) %>% addTiles() %>% addMarkers(lng = ~long, lat = ~lat,popup =paste("Name:",data$Name,"<br>","University:",data$University,"<br>","Degree:",data$Degree,"<br>"),
                                                clusterOptions = markerClusterOptions())
    
  })
  
  
  # map section; can be opted to change 
  output$schoolMap <- renderLeaflet({
    leaflet(data) %>% addTiles() %>%
      addCircles(lng = ~long, lat = ~lat, weight = 1,
                 radius = ~sqrt(tuition)*1400, popup = data$University) 
    
  })
  
  # wordcloud
  output$experWC <- renderPlot({
  
    wordcloud(experience,min.freq=1, max.words = 100, random.order = FALSE,scale=c(8,2),colors=brewer.pal(8,"Dark2"))
  })
  output$goalWC <- renderPlot({
    
    wordcloud(goal,min.freq=1, max.words = 100, random.order = FALSE,scale=c(8,2),colors=brewer.pal(8,"Dark2"))
  })
  output$datatable = renderDataTable({
    data
  })
  
  
  
}

