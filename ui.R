needs::needs(shiny, shinydashboard, htmltools, dplyr, ggmap, leaflet, googleVis, ggplot2,
             plotly, RColorBrewer, tm, SnowballC, wordcloud)
dashboardPage(skin="black",
              dashboardHeader(title = span(tagList(icon("fa-graduation-cap",class="fa fa-graduation-cap",lib = "font-awesome"), "APAN 5500 Classmates")),titleWidth = 1000),
              
              dashboardSidebar(width = 380,
                               sidebarMenu(
                                 menuItem("General", tabName = "general", icon = icon("fa-venus-mars ",class="fa fa-venus-mars",lib = "font-awesome")),
                                 menuItem("Degree", tabName = "degree", icon = icon("fa-trophy ",class="fa fa-trophy",lib = "font-awesome")),
                                 menuItem("Location", tabName = "location", icon = icon("fa-clock-o",class="fa fa-clock-o",lib = "font-awesome")),
                                 menuItem("Previous School", tabName = "schoolMap", icon = icon("fa-trophy ",class="fa fa-trophy",lib = "font-awesome")),
                                 menuItem("Interests", tabName = "interests", icon = icon("fa-dot-circle-o",class="fa fa-dot-circle-o",lib = "font-awesome")),
                                 menuItem("Data Source", tabName = "dataSource", icon = icon("fa-table",class="fa fa-table",lib = "font-awesome")),
                                 helpText("About Author",  align = "center"),
                                 menuItemOutput("lk_in"),
                                 menuItemOutput("blg")
                               )
                              ), 
              
              dashboardBody( 
                tags$head(tags$style(HTML('#general{height:100vh !important;}
                                          /* logo */
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
                tabItems(
                  tabItem(tabName ="general",
                          plotlyOutput('gender', height = "auto")),
                                   
                          # box(plotlyOutput('gender',height="auto",width = "auto"),height = 920,width = 6),
                          # box(plotlyOutput('degree',height="auto",width = "auto"),height = 920,width = 6))
                            
                            # column(width = 6, align = "center",box(plotlyOutput('gender'), width=6)),
                            # column(width = 6, align = "center",box(plotlyOutput('degree'), width=6)
                          
                  
                  tabItem(tabName ="degree",
                            plotlyOutput('degree', height = "auto")
                          ),

                  tabItem(tabName ="location",  
                          leafletOutput('location', height = '90vh')
                  ),
                  tabItem(tabName ="schoolMap",
                            leafletOutput("schoolMap", height = '90vh')
                  ),
                  tabItem(tabName = "exp"
                          )
                         
               
                        )
                        )
)




  
  