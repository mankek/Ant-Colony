# Initial parameters
blue_ant_number <- 2
green_ant_number <- 5
size <- 3
cycles <- 3



# run_colony <- function(blue_ant_number, green_ant_number, size, cycles){

total_ants <- blue_ant_number + green_ant_number

# Creating area for ants to move in (dimensions: size x size)
positions <- vector()
for (i in 1:(size^2)){
  positions <- c(positions, i)
}

# Creating the color history matrix and recording initial values
history_matrix <- matrix(ncol = 2)
color_names <- c("Blue", "Green")
colnames(history_matrix) <- color_names
history_matrix[1, 1] <- blue_ant_number
history_matrix[1, 2] <- green_ant_number

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
  # Change position of ants
  for (s in 1:(total_ants)){
    ant_matrix[s, 2] <- sample(positions, 1)
  }
  # Check if ants met
  for (u in 1:(total_ants)){
    for (v in 1:(total_ants)){
      if (v == i){
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
  for (t in 1:(total_ants)){
    if (as.integer(ant_matrix[t, 3]) > (total_ants/2) && ant_matrix[i, 4] < (total_ants/2)){
      ant_matrix[t, 1] <- "green"
    }else{
      if (as.integer(ant_matrix[i, 3]) < (total_ants/2) && ant_matrix[i, 4] > (total_ants/2)){
        ant_matrix[t, 1] <- "blue"
      }
    }
    
  }
}
  
  # return(history_list[-1])
# }

# run_colony(2, 3, 3, 3)

  







      
#         if (ant_matrix[s, 1] == "blue"){
#           ant_matrix[i, 3] == 1
#         }else{
#           ant_matrix[i, 4] == 1
#         }
#       }
#     }
#   }
# }
# ant_matrix
