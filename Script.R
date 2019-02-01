# Initial parameters
blue_ant_number <- 2
green_ant_number <- 3
positions <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)

# Creating the matrix
ant_matrix <- matrix(nrow=blue_ant_number + green_ant_number, ncol = 4)
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
for (i in 1:(blue_ant_number + green_ant_number)){
  for (s in 1:(blue_ant_number + green_ant_number)){
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
ant_matrix

      
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
