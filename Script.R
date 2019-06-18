ptm <- proc.time()
# Initial parameters
blue_ant_number <- 75
green_ant_number <- 25
size <- 3
cycles <- 100
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
for (i in 1:cycles){
  
  # Changing positions and killing ants
  death_val <- as.numeric(sample(100, total_ants, replace = TRUE))
  dead_ants <- which(death_val < death_rate, arr.ind = TRUE)
  live_ants <- which(death_val >= death_rate, arr.ind = TRUE)
  if (death == TRUE){
    if(nrow(ant_matrix) != 0){
      ant_matrix[live_ants, 2] <- sample(positions, (total_ants - length(dead_ants)), replace = TRUE)
    }
    total_ants <- total_ants - length(dead_ants)
    if(length(dead_ants) != 0){
      ant_matrix <- ant_matrix[-dead_ants,]
    }
  }else{
    ant_matrix[,2] <- sample(positions, total_ants, replace = TRUE)
  }
  if(total_ants == 0){
    break
  }

  
  # Check if ants met
  # ptm <- proc.time()
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
  # proc.time() - ptm

  # Timing is roughly similar to above, but going with above to reduce loops
  # ptm <- proc.time()
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
  # 
  # proc.time() - ptm
  
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



# Plotting the color history
library(ggplot2)
cycles_list <- c(0:cycles+1)
h <- ggplot(h_df, aes(x=cycles_list)) + 
  geom_line(aes(y=h_df$Blue, colour="Blue")) + 
  geom_line(aes(y=h_df$Green, colour="Green")) +
  scale_color_manual(values=c("blue", "green"))
h
proc.time() - ptm
  
  # return(history_list[-1])
# }

# run_colony(2, 3, 3, 3)

