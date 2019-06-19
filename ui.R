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
shinyUI(fluidPage(theme = "app.css",
  
  # Application title
  titlePanel("Ant Colony Behavior"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       numericInput("blue_ants", "Initial Amount of Blue Ants:", min = 1, max = 100, step = 1, value = 25),
       numericInput("green_ants", "Initial Amount of Green Ants", min = 1, max = 100, step = 1, value = 75),
       numericInput("area", "Size of the area (input x input):", min = 2, max = 10, step = 1, value = 3),
       numericInput("num_cycles", "Number of times the Ants move:", min = 1, max = 100, step = 1, value = 100),
       checkboxInput("ran_death", "Random Death", value = FALSE),
       sliderInput("death_rate", "Chance of Death (for all ants per cycle) (%)", min = 0, max = 100, value = 25, step = 1),
       checkboxInput("ran_birth", "Random Birth", value = FALSE),
       sliderInput("birth_rate", "Chance of Larvae Survival (for 100 larvae per cycle) (%)", min = 0, max = 100, value = 25, step = 1),
       actionButton("do", "Run Simulation")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("colorPlot")
    )
  ),
  # Javascript
  tags$script(src = "app.js")
))
