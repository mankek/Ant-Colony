make_ants <- function(num_ants, num_blue, num_green) {
  ants <- matrix(ncol = 5, nrow = num_ants)
  column_names <- c("ID", "Color", "Position", "Blue Met", "Green Met")
  row_names <- vector()
  for(i in 1:num_ants) {
    row_names <- c(i, row_names)
  }
  colnames(ants) <- column_names
  rownames(ants) <- row_names
  colors <- vector()
  for(s in 1:num_blue) {
    colors <- c("blue", colors)
  }
  for(t in 1:num_green) {
    colors <- c("green", colors)
  }
  for(u in 1:length(colors)) {
    ants[u, 2] <- colors[u]
  }
  positions <- list()
  for(v in 1:10) {
    position_1 <- as.numeric(sample.int(10, size = 1))
    position_2 <-as.numeric(sample(10, size = 1))
    position_v <- list(c(position_1, position_2))
    positions[v] <- position_v
  }
  for(a in 1:length(positions)) {
    ants[a, 3] <- positions[[a]]
  }
  return(ants)
}
make_ants(5, 2, 3)


