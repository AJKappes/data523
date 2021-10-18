remove(list = objects())

library(tidyverse)
setwd('~/teaching/data523')
list.files('proj523/data')

df <- read_csv('proj523/data/example_few_dataset.csv')

#### 1 ####

cy_df <- df %>% 
  filter(!grepl('cold', crop_or_cover),
         month %in% 6:9,
         yield_kg_m2 != 0) %>% 
  select(year, month, crop_or_cover, air_temp, precipitation, yield_kg_m2)

#### 2 ####

group_cy_df <- cy_df %>% 
  group_by(year, crop_or_cover) %>% 
  summarise(mean_temp = mean(air_temp),
            mean_yield = mean(yield_kg_m2),
            mean_precip = mean(precipitation))

alfa_df <- group_cy_df %>% 
  filter(grepl('Alfalfa', crop_or_cover))

#### 3 ####

ggplot(group_cy_df, aes(year, mean_yield, color = crop_or_cover)) +
  geom_line()

#### 4 ####

ch_fn <- function(j) {
  
  x1 <- alfa_df[1, j]
  x2 <- alfa_df[nrow(alfa_df), j]
  
  out <- (x2 - x1)/x1
  return(out)
  
}

my_vars <- c('mean_temp', 'mean_precip')
sapply(my_vars, function(i) ch_fn(i))

