remove(list = objects())

# select Iris flower data
x <- iris[which(iris[, 'Species'] == 'setosa'), ]
# construnct sequential iteration
iter <- 1
N_iter <- 1000
res <- data.frame()

# conduct sequential iteration
while (iter <= N_iter) {
  
  cat('Iteration', iter, 'of', N_iter,
      '\n')
  
  index <- sample(1:nrow(x), 1000, replace = TRUE)
  x_iter <- x[index, c('Sepal.Width')]
  x_res <- mean(x_iter)
  res <- rbind(res, x_res)
  iter <- iter + 1
  
}

colnames(res) <- 'sw_mean'
View(res)

# system time with iteration
iter_time <- system.time({
  
  iter <- 1
  N_iter <- 1000
  res <- data.frame()
  
  while (iter <= N_iter) {
    
    index <- sample(1:nrow(x), 1000, replace = TRUE)
    x_iter <- x[index, c('Sepal.Width')]
    res <- rbind(res, mean(x_iter))
    iter <- iter + 1
    
  }
  
})

iter_time

# parallelism requires operational functions
iters <- 1:N_iter
iter_fx <- function(i) {
  
  index <- sample(1:nrow(x), 1000, replace = TRUE)
  x_iter <- x[index, c('Sepal.Width')]
  x_res <- mean(x_iter)
  return(x_res)
  
}

iter_fx(1)

# structure visualization of what we're doing
lapply(iters, function(i) iter_fx(i))

vec_time <- system.time({
  
  lapply(iters, iter_fx)
  
})

# now it's time to distribute operations simultaneously
library(parallel)

# how many brains does the machine have?
## recieves instructions and performs calculations/operations
## base R functions allocated to 1 core
## but what about efficient allocation of resources???
detectCores()

parcomp_time <- system.time({
  
  res_par <- mclapply(iters, iter_fx)
  
})

cat('Comparison of computational cost',
    '\n  Iteration:', iter_time[1],
    '\n  Vectorization:', vec_time[1],
    '\n  Parallel:', parcomp_time[1])
