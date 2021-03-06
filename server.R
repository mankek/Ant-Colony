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

history_create <- function(blue_in, green_in, area_in, cycles_in, ran_death, death_rate, ran_birth, birth_rate){
  total_ants <- blue_in + green_in
  
  # Creating area for ants to move in (dimensions: size x size)
  positions <- vector()
  positions[1:(area_in^2)] <- c(1:(area_in^2))
  
  # Creating the color history matrix and recording initial values
  initial_blue <- c(blue_in, integer(cycles_in))
  initial_green <- c(green_in, integer(cycles_in))
  h_df <- data.frame(initial_blue, initial_green)
  names(h_df) <- c("Blue", "Green")
  
  # Creating the colony matrix
  ant_matrix <- matrix(nrow=total_ants, ncol = 4)
  column_names <- c("color", "position", "blue_met", "green_met")
  colnames(ant_matrix) <- column_names
  
  # Populating matrix with blue ants
  ant_matrix[1:blue_in, 1] <- "blue"
  ant_matrix[1:blue_in, 3:4] <- c(0,0)
  ant_matrix[1:blue_in, 2] <- sample(positions, blue_in, replace = TRUE)
  
  # Populating matrix with green ants
  ant_matrix[(blue_in + 1):(blue_in + green_in), 1] <- "green"
  ant_matrix[(blue_in + 1):(blue_in + green_in), 3:4] <- c(0,0)
  ant_matrix[(blue_in + 1):(blue_in + green_in), 2] <- sample(positions, green_in, replace = TRUE)
  
  # Checking for ants that met
  for(pos in positions){
    inds <- which(as.matrix(ant_matrix[,2]) == pos, arr.ind = FALSE)
    same <- matrix(ant_matrix[inds,], ncol = 4)
    blues <- nrow(as.matrix(same[same[,1] == "blue",]))
    greens <- nrow(as.matrix(same[same[,1] == "green",]))
    is_blue <- which(ant_matrix[inds, 1] == "blue")
    is_green <- which(ant_matrix[inds, 1] == "green")
    ant_matrix[inds[is_blue], 3] <- as.integer(blues) - 1
    ant_matrix[inds[is_blue], 4] <- as.integer(greens)
    ant_matrix[inds[is_green], 3] <- as.integer(blues)
    ant_matrix[inds[is_green], 4] <- as.integer(greens) - 1
  }
  
  
  # Running the cycles
  for (i in 1:cycles_in){
   
    # Change position and kill ants
    death_val <- as.numeric(sample(100, total_ants, replace = TRUE))
    dead_ants <- which(death_val < death_rate, arr.ind = TRUE)
    live_ants <- which(death_val >= death_rate, arr.ind = TRUE)
    if (ran_death == TRUE){
      if (nrow(ant_matrix) != 0){
        ant_matrix[live_ants, 2] <- sample(positions, (total_ants - length(dead_ants)), replace = TRUE)
      }
      total_ants <- total_ants - length(dead_ants)
      if (length(dead_ants) != 0){
        ant_matrix <- ant_matrix[-dead_ants,]
      }
    }else{
      ant_matrix[,2] <- sample(positions, total_ants, replace = TRUE)
    }
    if (total_ants == 0){
      break
    }
    
    # Birth of new ants
    if (ran_birth == TRUE){
      birth_val <- as.numeric(sample(100, 100, replace = TRUE))
      new_ants <- length(which(birth_val < birth_rate, arr.ind = TRUE))
      if(new_ants > 0){
        new_colors <- sample(c("green", "blue"), new_ants, replace = TRUE)
        new_matrix <- cbind(new_colors, sample(positions, new_ants, replace = TRUE), 0, 0)
        colnames(new_matrix) <- column_names
        ant_matrix <- rbind(ant_matrix, new_matrix)
        total_ants <- total_ants + new_ants
      }
    }
    
    # Check if ants met
    ant_matrix <- matrix(ant_matrix, ncol = 4)
    for (pos in positions){
      inds <- which(ant_matrix[,2] == pos, arr.ind = FALSE)
      same <- matrix(ant_matrix[inds,], ncol = 4)
      blues <- nrow(matrix(same[same[,1] == "blue",], ncol = 4))
      greens <- nrow(matrix(same[same[,1] == "green",], ncol = 4))
      is_blue <- which(ant_matrix[inds, 1] == "blue")
      is_green <- which(ant_matrix[inds, 1] == "green")
      ant_matrix[inds[is_blue], 3] <- as.integer(ant_matrix[inds[is_blue], 3]) + as.integer(blues) - 1
      ant_matrix[inds[is_blue], 4] <- as.integer(ant_matrix[inds[is_blue], 4]) + as.integer(greens)
      ant_matrix[inds[is_green], 3] <- as.integer(ant_matrix[inds[is_green], 3]) + as.integer(blues)
      ant_matrix[inds[is_green], 4] <- as.integer(ant_matrix[inds[is_green], 4]) + as.integer(greens) - 1
    }
    
    # Check if ants reached color change threshold and add to color history
    threshold <- total_ants/2
    green_change <- which(ant_matrix[,3] > threshold & ant_matrix[,4] < threshold, arr.ind = TRUE)
    blue_change <- which(ant_matrix[,3] < threshold & ant_matrix[,4] > threshold, arr.ind = TRUE)
    ant_matrix[green_change, 1] <- "green"
    ant_matrix[green_change, 3:4] <- c(0,0)
    ant_matrix[blue_change, 1] <- "blue"
    ant_matrix[blue_change, 3:4] <- c(0,0)
    new_blue <- nrow(as.matrix(ant_matrix[ant_matrix[,1] == "blue",]))
    new_green <- nrow(as.matrix(ant_matrix[ant_matrix[,1] == "green",]))
    h_df$Blue[(i+1)] <- new_blue
    h_df$Green[(i+1)] <- new_green
  }
  
  return(h_df)
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$colorPlot <- renderPlot({
    
    input$do
    
    hist_data <- isolate({
      validate(
        need(input$blue_ants !="", "Please select a number for Blue ants"),
        need(input$green_ants != "", "Please select a number for Green Ants"),
        need(input$area != "", "Please select a number for the area"),
        need(input$num_cycles != "", "Please select a number for the number of times ants move")
      )
      history_create(input$blue_ants, input$green_ants, input$area, input$num_cycles, input$ran_death, input$death_rate,
                     input$ran_birth, input$birth_rate)
    })
    
  
    cycles_list <- isolate({
      c(0:input$num_cycles+1)
    })
    
    ggplot(hist_data, aes(x=cycles_list)) + 
      geom_line(aes(y=hist_data$Blue, colour="Blue")) + 
      geom_line(aes(y=hist_data$Green, colour="Green")) +
      scale_color_manual(values=c("blue", "green")) +
      labs( x = "Cycles", y = "# of Ants")
  })
  
})
