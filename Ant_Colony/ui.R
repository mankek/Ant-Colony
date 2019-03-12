#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Ant Colony Behavior"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       numericInput("blue_ants", "Initial Amount of Blue Ants:", min = 1, max = 100, step = 1, value = 3),
       numericInput("green_ants", "Initial Amount of Green Ants", min = 1, max = 100, step = 1, value = 6),
       numericInput("area", "Size of the area (input x input):", min = 2, max = 10, step = 1, value = 3),
       numericInput("num_cycles", "Number of times the Ants move:", min = 1, max = 100, step = 1, value = 5),
       submitButton(text = 'Apply Changes')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("colorPlot")
    )
  )
))
