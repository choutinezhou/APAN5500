

library(shiny)
library(shinydashboard)
library(htmltools)
library(dplyr)
library(ggmap)
library(leaflet)
library(googleVis)
library(ggplot2)
library(plotly)
library(RColorBrewer)



data=read.csv('newData.csv')

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


#=================================== start server=====================================
function(input, output, session) {
  output$gender <- renderPlotly({
    
    p <- plot_ly(
      genderCount,
      x= ~Gender,
      y= ~n,
      name = "Gender",
      type = "bar",
      marker = list(color = c('rgba(255, 133, 133,1)', 'rgba(158, 216, 255, 1)')))
    
  })
  
  output$degree <- renderPlotly({
    g <- ggplot(degreeCount,aes(x=reorder(degree,countDegree),y=countDegree,fill=countDegree))+geom_bar(stat='identity')+coord_flip()
    ggplotly(g)
    
    ## not sure how to change to descending order in plotly
    # d <- plot_ly(
    #   degreeCount,
    #   y= ~degree,
    #   x= ~countDegree,
    #   name = "Degree Counts",
    #   type = "bar", orientation = 'h',color = ~clarity)
    # 
    
    })
  
  # map section; can be opted to change 
  output$map <- renderLeaflet({
    leaflet(data) %>% addTiles() %>%
      addCircles(lng = ~long, lat = ~lat, weight = 1,
                 radius = ~sqrt(tuition)*100000, popup = ~University) 
    
  })
  
}

