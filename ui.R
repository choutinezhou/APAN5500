needs::needs(shiny, shinydashboard, htmltools, dplyr, ggmap, leaflet, googleVis, ggplot2,
             plotly, RColorBrewer, tm, SnowballC, wordcloud, shinythemes, chorddiag)

dashboardPage(#skin="yellow", 
                          dashboardHeader(title = tagList(icon("fa-graduation-cap",class="fa fa-graduation-cap",lib = "font-awesome"), "APAN 5500 Classmates") ,titleWidth = 380),
                          
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
                            tags$head(tags$script('
                                var dimension = [0, 0];
                                                  $(document).on("shiny:connected", function(e) {
                                                  dimension[0] = window.innerWidth;
                                                  dimension[1] = window.innerHeight;
                                                  Shiny.onInputChange("dimension", dimension);
                                                  });
                                                  $(window).resize(function(e) {
                                                  dimension[0] = window.innerWidth;
                                                  dimension[1] = window.innerHeight;
                                                  Shiny.onInputChange("dimension", dimension);
                                                  });
                                                  ')),
                            
                            tabItems(
                              tabItem(tabName ="general",
                                      plotlyOutput('gender', height = "auto")),
                              
                              # box(plotlyOutput('gender',height="auto",width = "auto"),height = 920,width = 6),
                              # box(plotlyOutput('degree',height="auto",width = "auto"),height = 920,width = 6))
                              
                              # column(width = 6, align = "center",box(plotlyOutput('gender'), width=6)),
                              # column(width = 6, align = "center",box(plotlyOutput('degree'), width=6)
                              
                              
                              tabItem(tabName ="degree",
                                      plotOutput('degree')#, width = "100%", height = "100%")
                              ),
                              
                              tabItem(tabName ="location",  
                                      leafletOutput('location', height = '90vh')
                              ),
                              tabItem(tabName ="schoolMap",
                                      leafletOutput("schoolMap", height = '90vh')
                              ),
                              tabItem(tabName = "interests",
                                      chorddiagOutput("interests", height = "90vh")
                              )
                              
                              
                            )
                          )
            )
            
            

  
  