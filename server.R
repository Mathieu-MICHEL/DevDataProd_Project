#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(xlsx)
library(tidyverse)

data <- read.xlsx("Largest Cities.xlsx",sheetIndex = 1)
data$city <- factor(data$city, levels = data$city)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$List <- renderPlot({

        # generate bins based on input$bins from ui.R
        x <- data[1:input$n,]

        # draw the histogram with the specified number of bins
        ggplot(data=x, aes(x=city, y=population, fill=continent)) +
            geom_bar(stat="identity") + coord_flip() 

    })
    
    output$view <- renderTable({

        table <- aggregate(data[1:input$n,]$city, 
                           by=list(data[1:input$n,]$continent),
                           FUN='length')
        
        table2 <- aggregate(data[1:input$n,]$pop, 
                            by=list(data[1:input$n,]$continent),
                            FUN='mean')
        table2$x <- round(table2$x/1000000,3)
        
        table3 <- cbind(table,table2$x)
        
        names(table3) <- c("Continent",
                           "Number of cities in the Top-n",
                           "Average population in biggest cities (millions)")
        
        table3
    })

})
