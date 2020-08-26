#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(xlsx)
library(tidyverse)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("n Largest Cities"),

    # Sidebar with a slider input for number of bins
    fluidRow(
        column(8,
               wellPanel(
                sliderInput("n",
                            "Show me this many cities:",
                            min = 1,
                            max = 50,
                            value = 25)
               )       
        ),
        column(8,
               plotOutput("List")
        ),
        column(8,
               wellPanel(tableOutput("view"))
        ),
        # WHERE YOUR FOOTER GOES
        column(8,
        hr(),
        print("source: https://en.wikipedia.org/wiki/List_of_largest_cities"))
)))
