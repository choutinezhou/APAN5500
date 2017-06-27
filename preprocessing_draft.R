library(googleVis)
library(leaflet)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(plotly)

data=read.csv('classmates.csv')
summary(data)


# change data type of tuition to numeric
data$tuition <- as.numeric(data$tuition)


#=====================generate long and lat from the location column=====================

# create a function with transforming from location characters to long lat points
geocodeAdddress <- function(address) {
  require(RJSONIO)
  url <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(url, address, "&sensor=false", sep = ""))
  x <- fromJSON(url, simplify = FALSE)
  if (x$status == "OK") {
    out <- c(x$results[[1]]$geometry$location$lng,
             x$results[[1]]$geometry$location$lat)
  } else {
    out <- NA
  }
  Sys.sleep(0.2)  # API only allows 5 requests per second
  out
}

# apply function on location column
longLat <- sapply(data$Location,geocodeAdddress)

# create additional 2 columns of long and lat 
data$long=longLat[1,]
data$lat=longLat[2,]

# save as csv file
write.csv(data, file = "newData.csv")
#===========================================================================
#===============================try different charts========================
# ggplot- plot gender chart
ggplot(data,aes(x=Gender,fill=Gender))+geom_bar()

# googleVis- plot gender bar 
genderCount=data %>% count(Gender)
genderChart <- gvisColumnChart(genderCount,xvar = 'Gender',yvar ='n')
plot(genderChart)

# plotly - Gender Bar
p <- ggplot(data=genderCount, aes(x=Gender, y=n, fill=Gender)) +
  geom_bar(stat="identity")
ggplotly(p)


#ggplot(data,aes(reorder(x=Degree),y=..count..))+geom_bar()+coord_flip()

# plot degree bar chart
data %>% 
  count(Degree) %>% 
  mutate(Degree=reorder(Degree,n,.desc=TRUE)) %>% 
  ggplot(aes(x=Degree,y=n))+geom_bar(stat = 'identity')+coord_flip()


plot_ly(data, type = "histogram")

#====================================

#==================================== draw maps ============================

# all markers map
leaflet() %>%
  addTiles() %>%
  addMarkers(data$long,data$lat,
             labelOptions = labelOptions(noHide = T))


# circle mal
leaflet(data) %>% addTiles() %>%
  addCircles(lng = ~long, lat = ~lat, weight = 1,
             radius = ~sqrt(tuition)*100000, popup = ~University)

# cluster markers map
leaflet(data) %>% addTiles() %>% addMarkers(lng = ~long, lat = ~lat,popup = ~University,
  clusterOptions = markerClusterOptions()
)

