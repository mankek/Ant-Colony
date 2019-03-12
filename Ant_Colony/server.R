#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

history_create <- function(blue_in, green_in, area_in, cycles_in){
  
  total_ants <- blue_in + green_in
  
  # Creating area for ants to move in (dimensions: size x size)
  positions <- vector()
  for (i in 1:(area_in^2)){
    positions <- c(positions, i)
  }
  
  # Creating the color history matrix and recording initial values
  initial_blue <- c(blue_in)
  initial_green <- c(green_in)
  for (m in 2:(cycles_in + 1)){
    initial_blue <- c(initial_blue, 0)
    initial_green <- c(initial_green, 0)
  }
  h_df <- data.frame(initial_blue, initial_green)
  names(h_df) <- c("Blue", "Green")
  
  # Creating the colony matrix
  ant_matrix <- matrix(nrow=total_ants, ncol = 4)
  column_names <- c("color", "position", "blue_met", "green_met")
  colnames(ant_matrix) <- column_names
  
  # Populating matrix with blue ants
  for (i in 1:blue_in){
    ant_matrix[i, 1] <- "blue"
    ant_matrix[i, 3] <- 0
    ant_matrix[i, 4] <- 0
    ant_matrix[i, 2] <- sample(positions, 1)
  }
  
  # Populating matrix with green ants
  for (i in 1:green_in){
    ant_matrix[(i + blue_in), 1] <- "green"
    ant_matrix[(i + blue_in), 3] <- 0
    ant_matrix[(i + blue_in), 4] <- 0
    ant_matrix[(i + blue_in), 2] <- sample(positions, 1)
  }
  
  # Checking for ants that met
  for (i in 1:(total_ants)){
    for (s in 1:(total_ants)){
      if (s == i){
        next
      }else{
        if (ant_matrix[i, 2] == ant_matrix[s, 2]){
          if (ant_matrix[s, 1] == "blue"){
            ant_matrix[i, 3] <- as.integer(ant_matrix[1, 3]) + 1
          }else{
            ant_matrix[i, 4] <- as.integer(ant_matrix[1, 4]) + 1
          }
        }
      }
    }
  }
  
  # Running the cycles
  for (i in 1:cycles_in){
    # Change position of ants
    for (s in 1:(total_ants)){
      ant_matrix[s, 2] <- sample(positions, 1)
    }
    # Check if ants met
    for (u in 1:(total_ants)){
      for (v in 1:(total_ants)){
        if (v == u){
          next
        }else{
          if (ant_matrix[u, 2] == ant_matrix[s, 2]){
            if (ant_matrix[v, 1] == "blue"){
              ant_matrix[u, 3] <- as.integer(ant_matrix[1, 3]) + 1
            }else{
              ant_matrix[u, 4] <- as.integer(ant_matrix[1, 4]) + 1
            }
          }
        }
      }
    }
    # Check if ants reached color change threshold and add to color history
    for (t in 1:total_ants){
      if (as.integer(ant_matrix[t, 3]) > (total_ants/2) && ant_matrix[t, 4] < (total_ants/2)){
        ant_matrix[t, 1] <- "green"
        ant_matrix[t, 3] <- 0
        ant_matrix[t, 4] <- 0
      }else{
        if (as.integer(ant_matrix[t, 3]) < (total_ants/2) && ant_matrix[t, 4] > (total_ants/2)){
          ant_matrix[t, 1] <- "blue"
          ant_matrix[t, 3] <- 0
          ant_matrix[t, 4] <- 0
        }
      }
      if (ant_matrix[t, 1] == "blue"){
        h_df$Blue[(i+1)] <- h_df$Blue[(i+1)] + 1
      }else{
        h_df$Green[(i+1)] <- h_df$Green[(i+1)] + 1
      }
    }
  }
  
  return(h_df)
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  hist_data <- reactive({
    history_create(input$blue_ants, input$green_ants, input$area, input$num_cycles)
  })
   
  output$colorPlot <- renderPlot({
    
    cycles_list <- c(0:input$num_cycles+1)
    
    ggplot(hist_data(), aes(x=cycles_list)) + 
      geom_line(aes(y=hist_data()$Blue, colour="Blue")) + 
      geom_line(aes(y=hist_data()$Green, colour="Green")) +
      scale_color_manual(values=c("blue", "green")) +
      labs( x = "Cycles", y = "Colors")
  })
})
