# using code from "Markus Gesmann, February 2013"
require(googleVis)
require(shiny)



## Prepare data to be displayed
## Load presidential election data by state from 1932 - 2012
# library(RCurl)
# dat <- getURL("https://dl.dropboxusercontent.com/u/7586336/blogger/US%20Presidential%20Elections.csv",
              # ssl.verifypeer=0L, followlocation=1L)
# dat <- read.csv(text=dat)



ucr = read.csv("./data/CrimeTrendsInOneVar.csv", skip=4, nrows=53, header=TRUE, stringsAsFactors=FALSE)
#ucr = read.csv("https://dl.dropboxusercontent.com/u/66436784/CrimeTrendsInOneVar.csv", skip=4, nrows=53, header=TRUE, stringsAsFactors=FALSE)
tucr = data.frame(t(ucr))
names(tucr) = tucr[1,]
tucr = tucr[-1,]
tucr$State = gsub("\\.", " ", rownames(tucr))

c1960 = tucr[,c("State", "1960")]

chart1960 <- gvisGeoChart(c1960,
                        locationvar = "State",
                        colorvar = "1960",
                        options=list(region="US", resolution="provinces", results="asis"))


shinyServer(function(input, output) {
    
    myYear <- reactive({
        input$Year
    })
    
    output$year <- renderText({
        paste("State crime rates in", myYear())
    })
	
    output$gvis <- renderGvis({
		
        gvisGeoChart(tucr[c("State", myYear())],
                     locationvar = "State",
                     colorvar = myYear(),
                     options=list(region="US",
                                  resolution="provinces",
                                  displayMode="regions",
                                  # width=500, height=400,
                                  colorAxis="{minValue: 0, maxValue: 1250, colors:['green', 'red']}")
                     )
		    
    })
})