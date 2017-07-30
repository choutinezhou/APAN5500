if(!require(needs)){install.packages("needs")}
if(!require(chorddiag)){devtools::install_github("mattflor/chorddiag")}
needs::needs(shiny, shinydashboard, htmltools, dplyr, ggmap, leaflet, googleVis, ggplot2,
             plotly, RColorBrewer, tm, wordcloud, chorddiag)


load("Load_at_start.RData")
load("Load_ext.RData")

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
      layout(autosize = T, height = as.numeric(input$dimension[2]) -100, width = as.numeric(input$dimension[1])-400)
    
  })
  
  observe({
  output$degree <- renderPlot({
    g <- ggplot(degreeCount,aes(x=reorder(degree,countDegree),y=countDegree,fill=countDegree))+geom_bar(stat='identity')+coord_flip()
    #ggplotly(g) #%>% layout(autosize = T)
    g

    }, height = as.numeric(input$dimension[2]) -100, width = as.numeric(input$dimension[1])-400)
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
  
  output$interests <- renderChorddiag({
    chorddiag(m, groupColors = groupColors, groupnamePadding = 40)
    
  })
  
  
})

