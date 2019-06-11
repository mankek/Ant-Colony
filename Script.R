# Initial parameters
blue_ant_number <- 75
green_ant_number <- 25
size <- 3
cycles <- 500
death <- TRUE
death_rate <- 25


# run_colony <- function(blue_ant_number, green_ant_number, size, cycles){

total_ants <- blue_ant_number + green_ant_number

# Creating area for ants to move in (dimensions: size x size)
positions <- vector()
positions[1:(size^2)] <- c(1:(size^2))

# Creating the color history matrix and recording initial values
initial_blue <- c(blue_ant_number, integer(cycles))
initial_green <- c(green_ant_number, integer(cycles))
h_df <- data.frame(initial_blue, initial_green)
names(h_df) <- c("Blue", "Green")

# Creating the colony matrix
ant_matrix <- matrix(nrow=total_ants, ncol = 4)
column_names <- c("color", "position", "blue_met", "green_met")
colnames(ant_matrix) <- column_names

# Populating matrix with blue ants
ant_matrix[1:blue_ant_number, 1] <- "blue"
ant_matrix[1:blue_ant_number, 3:4] <- c(0,0)
ant_matrix[1:blue_ant_number, 2] <- sample(positions, blue_ant_number, replace = TRUE)

# Populating matrix with green ants
ant_matrix[(blue_ant_number + 1):(blue_ant_number + green_ant_number), 1] <- "green"
ant_matrix[(blue_ant_number + 1):(blue_ant_number + green_ant_number), 3:4] <- c(0,0)
ant_matrix[(blue_ant_number + 1):(blue_ant_number + green_ant_number), 2] <- sample(positions, green_ant_number, replace = TRUE)

# Checking for ants that met
for (pos in positions){
  inds <- which(ant_matrix[,2] == pos, arr.ind = FALSE)
  same <- ant_matrix[inds,]
  blues <- nrow(same[same[,1] == "blue",])
  if (is.null(blues)){
    blues <- 1
  }
  greens <- nrow(same[same[,1] == "green",])
  if (is.null(greens)){
    greens <- 1
  }
  is_blue <- which(ant_matrix[inds, 1] == "blue")
  is_green <- which(ant_matrix[inds, 1] == "green")
  ant_matrix[inds[is_blue], 3] <- as.integer(blues) - 1
  ant_matrix[inds[is_blue], 4] <- as.integer(greens)
  ant_matrix[inds[is_green], 3] <- as.integer(blues)
  ant_matrix[inds[is_green], 4] <- as.integer(greens) - 1
}

# Running the cycles
for (i in 1:cycles){
  
  # Changing positions and killing ants
  death_val <- as.numeric(sample(100, total_ants, replace = TRUE))
  dead_ants <- which(death_val < death_rate, arr.ind = TRUE)
  live_ants <- which(death_val >= death_rate, arr.ind = TRUE)

  if (death == TRUE){
    ant_matrix[live_ants, 2] <- sample(positions, (total_ants - length(dead_ants)), replace = TRUE)
    ant_matrix <- ant_matrix[-dead_ants,]
    total_ants <- total_ants - length(dead_ants)
  }else{
    ant_matrix[,2] <- sample(positions, total_ants, replace = TRUE)
  }
  if(total_ants == 0){
    break
  }
  
  # Check if ants met
  for (pos in positions){
    inds <- which(ant_matrix[,2] == pos, arr.ind = FALSE)
    same <- ant_matrix[inds,]
    blues <- nrow(same[same[,1] == "blue",])
    if (is.null(blues)){
      blues <- 1
    }
    greens <- nrow(same[same[,1] == "green",])
    if (is.null(greens)){
      greens <- 1
    }
    is_blue <- which(ant_matrix[inds, 1] == "blue")
    is_green <- which(ant_matrix[inds, 1] == "green")
    ant_matrix[inds[is_blue], 3] <- as.integer(ant_matrix[inds[is_blue], 3]) + as.integer(blues) - 1
    ant_matrix[inds[is_blue], 4] <- as.integer(ant_matrix[inds[is_blue], 4]) + as.integer(greens)
    ant_matrix[inds[is_green], 3] <- as.integer(ant_matrix[inds[is_green], 3]) + as.integer(blues)
    ant_matrix[inds[is_green], 4] <- as.integer(ant_matrix[inds[is_green], 4]) + as.integer(greens) - 1
  }
  
  # Timing is roughly similar to above, but above is more consistent
  # for (u in 1:(total_ants)){
  #   for (v in 1:(total_ants)){
  #     if (v == u){
  #       next
  #     }else{
  #       if (ant_matrix[u, 2] == ant_matrix[v, 2]){
  #         if (ant_matrix[v, 1] == "blue"){
  #           ant_matrix[u, 3] <- as.integer(ant_matrix[1, 3]) + 1
  #         }else{
  #           ant_matrix[u, 4] <- as.integer(ant_matrix[1, 4]) + 1
  #         }
  #       }
  #     }
  #   }
  # }
  
  # Check if ants reached color change threshold and add to color history
  # ptm <- proc.time()
  # threshold <- total_ants/2
  # green_change <- which(ant_matrix[,3] > threshold && ant_matrix[,4] < threshold)
  # blue_change <- which(ant_matrix[,3] < threshold && ant_matrix[,4] > threshold)
  # ant_matrix[green_change, 1] <- "green"
  # ant_matrix[green_change, 3:4] <- c(0,0)
  # ant_matrix[blue_change, 1] <- "blue"
  # ant_matrix[blue_change, 3:4] <- c(0,0)
  # print(NCOL(blue_change))
  
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

# Plotting the color history
library(ggplot2)
cycles_list <- c(0:cycles+1)
h <- ggplot(h_df, aes(x=cycles_list)) + 
  geom_line(aes(y=h_df$Blue, colour="Blue")) + 
  geom_line(aes(y=h_df$Green, colour="Green")) +
  scale_color_manual(values=c("blue", "green"))
h
  
  # return(history_list[-1])
# }

# run_colony(2, 3, 3, 3)

