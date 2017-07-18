library(shinydashboard)
library(rsconnect)
library(shiny)
library(htmltools)
library(dplyr)
library(ggmap)
library(leaflet)
library(googleVis)
library(ggplot2)
library(plotly)
library(RColorBrewer)
# wordcloud library
library(tm)
library(SnowballC)
library(wordcloud)




dashboardPage(skin="black",
              dashboardHeader(title = span(tagList(icon("fa-graduation-cap",class="fa fa-graduation-cap",lib = "font-awesome"), "APAN 5500 Classmates")),titleWidth = 1000),
              
              dashboardSidebar(width = 380,
                               sidebarMenu(
                                 menuItem("General", tabName = "general", icon = icon("fa-venus-mars ",class="fa fa-venus-mars",lib = "font-awesome")),
                                 menuItem("Degree", tabName = "degree", icon = icon("fa-trophy ",class="fa fa-trophy",lib = "font-awesome")),
                                 menuItem("Location", tabName = "location", icon = icon("fa-globe",class="fa fa-globe",lib = "font-awesome")),
                                 menuItem("Previous School", tabName = "schoolMap", icon = icon("fa-university",class="fa fa-university",lib = "font-awesome")),
                                 menuItem("Career", tabName = "career", icon = icon("fa-dot-circle-o",class="fa fa-dot-circle-o",lib = "font-awesome")),
                                 menuItem("Info", tabName = "author", icon = icon("fa-info-circle",class="fa fa-info-circle",lib = "font-awesome")),
                                 menuItem("Data Source", tabName = "dataSource", icon = icon("fa-table",class="fa fa-table",lib = "font-awesome")),
                                 menuItemOutput("lk_in"),
                                 menuItemOutput("blg")
                               )
                              ), 
              
              dashboardBody(
                tags$head(tags$style(HTML('/* logo */
                                          .skin-black .main-header .logo {
                                          font-weight: bold;
                                          font-size: 25px;
                                          background-color: #ffffff;
                                          }
                                          
                                          /* logo when hovered */
                                          .skin-black .main-header .logo:hover {
                                          background-color: #ffffff;
                                          }
                                          
                                          /* navbar (rest of the header) */
                                          .skin-blue .main-header .navbar {
                                          background-color: #fcfcd9;
                                          } 
                                          /* toggle button when hovered  */                    
                                          .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                          background-color: #9BDDFF;
                                          }
                                          
                                          /* main sidebar */
                                          .skin-black .main-sidebar {
                                          font-weight: bold;
                                           
                                          font-size: 20px;
                                          color: black;
                                          background-color: #ffffff;
                                          }
                                          
                                          /* active selected tab in the sidebarmenu */
                                          .skin-black .main-sidebar .sidebar .sidebar-menu .active a{
                                          background-color: #9BDDFF;
                                          }
                                          /* other links in the sidebarmenu when hovered */
                                          .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                          background-color: #9BDDFF;
                                          }'))),
                # customize color for boxes
                tags$style(HTML("
                                          /* reset the box color when status = 'primary' */
                                          .box.box-solid.box-primary>.box-header {
                                          color:#ffffff;
                                          background:#35978f
                                          }
                                          
                                          .box.box-solid.box-primary{
                                          border-bottom-color:#f5f5f5;
                                          border-left-color:#f5f5f5;
                                          border-right-color:#f5f5f5;
                                          border-top-color:#35978f;}
                                          .js-irs-0 .irs-bar {
                                         border-top-color: #c7eae5;
                                            border-bottom-color: #c7eae5;
                                            } 
                                            
                                            .js-irs-0 .irs-bar-edge {
                                            border-color: #c7eae5;
                                            }
                            .js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {
                                background: #c7eae5}
                                          
                                          ")),
                
                tabItems(
                  tabItem(tabName ="general",
                          fluidRow(plotlyOutput('gender',height = "900px"))
                                   
                          # box(plotlyOutput('gender',height="auto",width = "auto"),height = 920,width = 6),
                          # box(plotlyOutput('degree',height="auto",width = "auto"),height = 920,width = 6))
                            
                            # column(width = 6, align = "center",box(plotlyOutput('gender'), width=6)),
                            # column(width = 6, align = "center",box(plotlyOutput('degree'), width=6)
                          ),
                  
                  tabItem(tabName ="degree",
                          fluidRow(
                            plotlyOutput('degree')
                          )
                    
                          ),
                  
                  tabItem(tabName ="location",
                          fluidRow(
                            leafletOutput('location', height = 1100)
                          )
                          
                  ),
                  tabItem(tabName ="schoolMap",
                          fluidRow(
                            leafletOutput("schoolMap", height = 1100)
                          )
                          
                  ),
                  tabItem(tabName = "career",
                          box(status = "primary",plotOutput("experWC"),solidHeader = TRUE,title="Experience ",height = 700,width = 6),
                          box(status = "primary",plotOutput("goalWC"),solidHeader = TRUE,title="Career Goal ",height = 700,width = 6)
                          ),
                  tabItem(tabName = "author",
                          box(width = 12, status = "primary", solidHeader = TRUE, title = "Info",
                              tags$p("This data visualization is about the background information of the students 
                                     in the Summer 2017 APAN 5500 class. The goal of this visualization is to help 
                                     students and faculty better understand the demographic information and academic 
                                     and career paths of the students registered in the Applied Analytics program. 
                                     The data are parsed from self-introduction forum on the online course platform."),
                              
                              tags$p("Original data include previous schools, degree/majors, work experiences, 
                                     career goals and interests. We featured additional data according to the original data columns 
                                     in order to enrich the dataset, which extends to the features of 
                                     gender, tuition of previous schools, longitude and latitude of locations."),
                              
                              tags$b("Below are the notes and assumptions of this visualization:"),
                              tags$p("  * Many students had double or triple majors (they are high achievers!), 
                                     so we lumped all the majors together to count the frequencies."),
                              tags$p("  * The locations on the maps are based on the previous schools the students attended. Because the hometowns or origins of the students are 
                                      highly skewed, we believe the locations of previous schools other than hometowns can provide 
                                  richer information about the paths of how students get here as a master student."),
                                     tags$p("  * The sizes of circles of the Previous School represent the tuition of the schools."),
                              
                              tags$b("About the Authors"),
  
                              tags$p("Choutine Zhou"),
                              tags$p("Feng Bian"),
                              tags$p("Wei Zhou"),
                              tags$p("Special Thanks to Professor Bernice Rogowitz! ")
                              
                              )
                    
                  ),
                  tabItem(tabName = "dataSource",
                          dataTableOutput('datatable')
                          
                          )
                         
               
                        )
                        )
)




  
  