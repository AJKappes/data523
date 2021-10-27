remove(list = objects())
set.seed(123)

# Iteration

## both functions and iteration important for
## reducing code duplication in scripts

## for loops good because iteration is explicit
## but code is duplicated for every iteration

## functional programming extracts out duplications
## each loop gets its own function
## solve iteration problems with less code and errors

# for loops ------------------------------------------------

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

## want to compute the median of each column

median(df$a)
median(df$b)
median(df$c)
median(df$d)

## rule of thumb: don't copy code more than twice
## we can use a for loop instead
## has three components: output, sequence, body

# output: must have sufficient space, ncol(df)
output <- vector(mode = 'double', length = ncol(df))

# sequence: what we are looping over
for (i in seq_along(df)) {
  
  # body: code that does the work for each sequence
  output[i] <- median(df[[i]])
  # output[1] <- median(df[[1]])
  # output[2] <- median(df[[2]])
  # ...
  
}
output

## another use case is modifying existing data
## rescale data to [0, 1]

rescale01 <- function(x) {
  
  rng <- range(x)
  out <- (x - rng[1]) / (rng[2] - rng[1])
  return(out)
  
}

rescale01(df$a)
df$a
df$a <- rescale01(df$a)
df
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df

## let's iterate this again...
## three components: output, sequence, body

## output: what is the output?
## already have it, same as input, the df

## sequence
for (i in seq_along(df)) {
  
  df[[i]] <- rescale01(df[[i]])
  
}
df

## these all show how to loop over numeric indices
## could also loop over names
x <- 1:10
letters
names(x) <- letters[seq_along(x)]
x

## iterate over names
for (name in names(x)) {
  
  print(name)
  print(x[[name]])
  
}

## but position is better purposed

## output
name <- vector(mode = 'character', length(x))
val <- vector(mode = 'double', length(x))

## sequence
for (i in seq_along(x)) {
  
  name[i] <- names(x)[i]
  val[i] <- x[[i]]
  
}
name
val

## looping over vectors of unknown lengths
## we've seen seq_along(), having a general idea of length of output
## what about length of body?

## simulate random vectors of random lengths
## two ways to accomplish this

## progressively grow the vector
means <- 0:2

# output
output <- double()
output

# sequence
for (i in seq_along(means)) {
  
  # body
  n <- sample(1:1000, 1)
  output <- c(output, rnorm(n, means[i]))
  
}
str(output)

## but this has to make a copy of each output vector
## and append new values each time
## computationally expensive

## enter lists, again

# output
output <- vector('list', length(means))
output

# sequence
for (i in seq_along(means)) {
  
  n <- sample(1:1000, 1)
  output[[i]] <- rnorm(n, means[i])
  
}
str(output)
str(unlist(output))

## what if it is unknown how long our sequence is?
## how many iterations do we need to achieve objective?
## this is the heart of simulations
## convergence criteria:
## while error > tolerance
## keep going.. (but not without iteration bounds)

# while loops ---------------------------------------------

## general idea
## while (condition met) {do something}

## what's the relation between for and while?
x <- sample(1:10, size = 5)

for (i in seq_along(x)) {
  
  print(x[i])
  
}

## equivalent to
i <- 1
while (i <= length(x)) {
  
  print(x[i])
  i <- i + 1
  
}

flip <- function() {
  
  sample(c('T', 'H'), size = 1)
  
}
flip()

## how many flips will it take to get 4 T in a row?
## we have to build the while loop to also check flip results
## if it's T then we add T to nT
## else we start ove

flips <- 0
nT <- 0

while (nT < 4) {
  
  if (flip() == 'T') {
    
    nT <- nT + 1
    
  } else {
    
    nT <- 0
    
  }
  
  flips <- flips + 1
  
  cat('flip number', flips, 'T count', nT,
      '\n')
  
}

## but it's generally advised to include some sort of stopping criteria
## what if we needed flip count to reach 100 T in a row?

flips <- 0
nT <- 0

while (nT < 100) {
  
  if (flip() == 'T') {
    
    nT <- nT + 1
    
  } else {
    
    nT <- 0
    
  }
  
  flips <- flips + 1
  
  cat('flip number', flips, 'T count', nT,
      '\n')
  
}

## need to include max flip (iteration) stopping criteria

flips <- 0
nT <- 0
max_flip <- 10000

while (nT < 100 & flips < max_flip) {
  
  if (flip() == 'T') {
    
    nT <- nT + 1
    
  } else {
    
    nT <- 0
    
  }
  
  flips <- flips + 1
  
  cat('flip number', flips, 'T count', nT,
      '\n')
  
  if (flips == max_flip) {
    
    print('T condition not met at max flips')
    
  }
  
}

# functional programming ---------------------------------

## recap
df
output <- vector('double', ncol(df))
for (i in seq_along(df)) {
  
  output[i] <- median(df[[i]])
  
}

## let's move closer to functional programming

sapply(df, function(i) median(i))
lapply(df, function(i) median(i))

## we provide the object we want to operate on
## and explicitely define the objective function

## lets look at the map functions
## map() makes a list 
## map_lgl() logical vector
## map_int() integer vector
## map_dbl() double vector
## map_chr() character vector

## takes vector as input, applies function to each input
## returns new vector of the same length
## it will take less time to solve iterative problems
## makes code easier to read, focusing only on the important parts
## we get rid of all the for loop 'building materials'

df
map_dbl(df, median)
map(df, median)
## we can see we focus only on the object and operation

## but we can make it even more explicit

df %>% map_dbl(median)
df %>% map(median)

## let's extend this to information on grouped data
mtcars

mtcars %>% 
  split(.$cyl)

mtcars %>% 
  split(.$cyl) %>% 
  map_dbl(function(df) mean(df$mpg))

## this has all dealt with one argument for iteration objective
## what if we have 2 arguments?
rnorm

mu <- c(0, 5, 10)
sig <- c(2, 4, 6)

map2(mu, sig, rnorm, n = 5)

## we see that sample size is common
## what if we had varying sample sizes?
## is there a map3()
nsamp <- sample(1:100, size = length(mu))
f_args <- list(nsamp, mu, sig)
pmap(f_args, rnorm)

## we recognize the order of arguments in our arg list for rnorm
rnorm
list(mu, sig, n = nsamp) %>% pmap(rnorm)
f_args %>% pmap(rnorm)




