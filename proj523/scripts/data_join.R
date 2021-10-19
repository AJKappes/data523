library(tidyverse)
library(lubridate)
set.seed(123)

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

# join(x, y, by = '')

# left join match from y to x
left_join(df1, df2, by = 'd')

# right join match from x to y
right_join(df1, df2, by = 'd')

# inner keeps obs w matches
inner_join(df1, df2, by = 'd')

# full retains all obs reg matches
full_join(df1, df2, by = 'd')

# what if column names are different?

df2 <- df2 %>% 
  rename(date = d)

full_join(df1, df2, by = 'd')
full_join(df1, df2, by = c('d' = 'date'))

# use semi join to inspect rows of x -- y
# what will be joined
semi_join(df1, df2, by = c('d' = 'date'))

# what will not be joined
anti_join(df1, df2, by = c('d' = 'date'))

# > 2 dfs
full_join(df1, df2, by = c('d' = 'date')) %>% 
  full_join(., df3, 'd')

list(df1, df2, df3) %>% 
  reduce(full_join, by = 'd')

list(df1, df2, df3) %>% 
  reduce(full_join, by = c('d' = 'date'))

df2 <- df2 %>% 
  rename(d = date)

list(df1, df2, df3) %>% 
  reduce(full_join, by = 'd')

my_dfs <- list(df1, df2, df3)

df <- my_dfs %>% 
  reduce(full_join, by = 'd')

df %>% 
  mutate(year = year(d),
         month = month(d),
         day = day(d),
         quarter = quarter(d))

df %>% 
  mutate_at(vars(d), list(~ year(.), ~ month(.), ~ day(.)))

# interval
df$d[1] %--% df$d[10]
t_int <- df$d[1] %--% df$d[10]
as.duration(t_int)



