# Initial parameters
blue_ant_number <- 75
green_ant_number <- 25
size <- 3
cycles <- 100


test <- c(1:100)
# run_colony <- function(blue_ant_number, green_ant_number, size, cycles){

total_ants <- blue_ant_number + green_ant_number

# Creating area for ants to move in (dimensions: size x size)
positions <- vector()
for (i in 1:(size^2)){
  positions <- c(positions, i)
}

# Creating the color history matrix and recording initial values
initial_blue <- c(blue_ant_number)
initial_green <- c(green_ant_number)
for (m in 2:(cycles + 1)){
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
for (i in 1:blue_ant_number){
  ant_matrix[i, 1] <- "blue"
  ant_matrix[i, 3] <- 0
  ant_matrix[i, 4] <- 0
  ant_matrix[i, 2] <- sample(positions, 1)
}

# Populating matrix with green ants
for (i in 1:green_ant_number){
  ant_matrix[(i + blue_ant_number), 1] <- "green"
  ant_matrix[(i + blue_ant_number), 3] <- 0
  ant_matrix[(i + blue_ant_number), 4] <- 0
  ant_matrix[(i + blue_ant_number), 2] <- sample(positions, 1)
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
for (i in 1:cycles){
  dead_ants <- vector()
  # Change position of ants
  for (s in 1:(total_ants)){
    death_val <- as.numeric(sample(100, 1, replace = TRUE))
    if (death_val >= 1){
      ant_matrix[s, 2] <- sample(positions, 1)
    }else{
      dead_ants <- c(dead_ants, s)
    }
  }
  # Kill dead ants
  total_ants <- total_ants - length(dead_ants)
  for (death in dead_ants){
    ant_matrix[-death,]
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

