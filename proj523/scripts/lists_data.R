library(tidyverse)
library(lubridate)
set.seed(123)

# lists

ex_list <- list(a = rnorm(10),
                b = sample(c('T', 'H'), size = 10, replace = TRUE),
                c = runif(10, min = 0, max = 1))

ex_list$a
ex_list[[1]]
ex_list$a[1:4]
ex_list[[1]][1:4]
ex_list %>% names()

ex_list$d <- sample(c(0, 1), size = 10, replace = TRUE)
ex_list[[5]] <- rbeta(10, 2, 2)
names(ex_list)[5] <- 'e'

l_ln <- 10
my_list <- vector(mode = 'list', length = l_ln)
my_list <- lapply(my_list,
                  function(i) as_tibble(matrix(rnorm(1000000), ncol = 10)))

# we keep using vectorization functions
# what exactly is it doing?

my_list <- vector(mode = 'list', length = l_ln)

for (i in 1:length(my_list)) {
  
  print(i)
  
}

for (i in 1:length(my_list)) {
  
  my_list[[i]] <- as_tibble(matrix(rnorm(1000000), ncol = 10))
  
  cat('iteration:', i,
      '\n')
  
}

# same result, just more computationally expensive 
my_list

# moving on to data and reading in list structure

year <- 1820:2020
month <- 1:12

d <- lapply(year, function(i)
  make_date(i, month)) %>%
  unlist() %>%
  as_date(origin = origin)

x <- rnorm(length(d), mean = 10, sd = 3) 
y <- rbinom(length(d), 1, prob = 0.3)
z <- sample(c('WC', 'EC', 'C'), size = length(d),
            replace = TRUE)
l <- sample(0:5, size = length(d),
            replace = TRUE)
q <- rnorm(length(d), mean = 55000, sd = 15000)
p <- rbeta(length(d), 2, 2)            

df1 <- tibble(d = d,
              x = x,
              y = y,
              z = z)

df2 <- tibble(d = d,
              l = l,
              q = q)

df3 <- tibble(d = d,
              p = p)

df2 <- sample_n(df2, size = .75*nrow(df1)) %>% 
  arrange(d)

df3 <- sample_n(df3, size = .67*nrow(df1)) %>% 
  arrange(d)

my_dfs <- list(df1, df2, df3)

# write and read in data iteratively

dfnames <- paste('df', 1:3, sep = '_')
for (df_i in dfnames) {{
  
  print(df_i)
  
}}

for (df_i in dfnames) {{
  
  print(paste(df_i, '.csv', sep = ''))
  
}}

getwd()
list.files()
list.files('data/')

# our objective
# takes two arguments
# write_csv(df1, '../data/df_1.csv')

for (i in 1:length(dfnames)) {{
  
  print(dfnames[i])
  
}}

paste('data/', dfnames[1], '.csv', sep = '')

for (i in 1:length(dfnames)) {{
  
  d_path <- paste('data/', dfnames[i], '.csv', sep = '')
  write_csv(my_dfs[[i]], d_path)
  
}}

# read
# our objective
# read_csv('data/df_{1, 2, ..., n}.csv')

df_read_fn <- function(dfs) {
  
  # find the data files
  dfs_search <- grep(dfs, list.files('data/'), value = TRUE)
  
  # create the path to read in all identified files
  dfs_path <- paste('data/', dfs_search, sep = '')
  
  # prints what we are about to read in
  cat('Data identified and read:\n', dfs_path)
  
  # asks if the information is correct
  readline(prompt = 'Press [enter] to read in data above or esc to cancel')
  
  # reads in and returns our object
  out <- lapply(1:length(dfs_search),
                function(i) read_csv(dfs_path[i]))
  return(out)
  
}

df_list <- df_read_fn('df')
lapply(df_list, function(i) names(i))

df <- df_list %>% 
  reduce(full_join, by = 'd')
