

dashboardPage(skin="black",
              dashboardHeader(title = span(tagList(icon("fa-graduation-cap",class="fa fa-graduation-cap",lib = "font-awesome"), "APAN 5500 Classmates")),titleWidth = 1000),
              
              dashboardSidebar(width = 380,
                               sidebarMenu(
                                 menuItem("Gender", tabName = "gender", icon = icon("fa-venus-mars ",class="fa fa-venus-mars",lib = "font-awesome")),
                                 menuItem("Degree", tabName = "degree", icon = icon("fa-trophy ",class="fa fa-trophy",lib = "font-awesome")),
                                 menuItem("Location", tabName = "map", icon = icon("fa-trophy ",class="fa fa-trophy",lib = "font-awesome")),
                                 menuItem("Experience", tabName = "exp", icon = icon("fa-clock-o",class="fa fa-clock-o",lib = "font-awesome")),
                                 menuItem("Career Goal", tabName = "goal", icon = icon("fa-dot-circle-o",class="fa fa-dot-circle-o",lib = "font-awesome")),
                                 menuItem("Data Source", tabName = "dataSource", icon = icon("fa-table",class="fa fa-table",lib = "font-awesome")),
                                 helpText("About Author",  align = "center"),
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
                
                tabItems(
                  tabItem(tabName ="gender",
                          fluidRow(
                            plotlyOutput('gender', height = "800px",width='800px')
                                  )

                          ),
                  
                  tabItem(tabName ="degree",
                          fluidRow(
                            plotlyOutput('degree', height = "800px")
                          )
                    
                          ),
                  tabItem(tabName ="map",
                          fluidRow(
                            leafletOutput("map", height = 920)
                          )
                          
                  ),
                  tabItem(tabName = "exp"
                          )
                         
               
                        )
                        )
)




  
  