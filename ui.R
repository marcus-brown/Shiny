require(shiny)

shinyUI(fluidPage(
    titlePanel("State crime rates, 1960-2012"),
    
    
    
    sidebarLayout(position = "right",
        
        sidebarPanel(
            p("Use the slider below to see crime data for a different year. Press the play button for automated scrolling through the years."),
            sliderInput("Year", "Year to be displayed:", 
                        min=1960, max=2012, value=2012,  step=1,
                        format="###0",animate=TRUE)
        ),
        
        mainPanel(
            p("This is an interactive Geo Plot of historical crime data (crimes per 100,000 people) in the Unites States.
              The data comes from the ",
                                    a("Universal Crime Statistics",
                                      href = "http://www.ucrdatatool.gov/"),
                "data collected by the FBI."),
            
            h3(textOutput("year")), 
            htmlOutput("gvis")
        )
    
    )
    
)
)