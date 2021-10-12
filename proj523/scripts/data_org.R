library(tidyverse)
getwd()
list.files()
dfiles <- list.files('data/')
dfiles[grep('data', dfiles)]
ex_dpath <- paste('data/', dfiles[grep('data', dfiles)], sep = '')

df <- read_csv(ex_dpath)
str(df)
view(df)
df
dfbase <- read.csv(ex_dpath)

names(df)

select(df, year, month, crop_or_cover,
       yield_kg_m2, precipitation, air_temp)

select(df, -year, -month)

filter(df, year >= 2000)

dftemp <- filter(df, year >= 2000)
unique(dftemp$year)

df_temp_vars <- select(dftemp, crop_or_cover, yield_kg_m2,
                       precipitation, air_temp)

df_temp_vars <- select(filter(df, year >= 2000),
                       crop_or_cover, yield_kg_m2, precipitation,
                       air_temp)

df %>%
  filter(year >= 2000) %>% 
  select(crop_or_cover, yield_kg_m2, precipitation,
         air_temp)

names(df)
grep('crop', names(df))
grep('crop', names(df), value = TRUE)
grep('crop{1}', names(df), value = TRUE)
grep('crop_', names(df), value = TRUE)
grep('crop[^p]', names(df), value = TRUE)

grep('m2', names(df), value = TRUE)
grep('yield', names(df), value = TRUE)
grep('y.*m2$', names(df), value = TRUE)

grep('precip', names(df), value = TRUE)

grep('temp', names(df), value = TRUE)

grep('crop[^p]|y.*m2$|precip|temp', names(df), value = TRUE)

myvars <- 'crop[^p]|y.*m2$|precip|temp'

df %>% 
  filter(year >= 2000) %>% 
  select(matches(myvars))

t <- df %>% 
  filter(year >= 2000 & year <= 2005) %>% 
  select(year, matches(myvars))

t$year %>% unique()

t <- df %>% 
  filter(year >= 2000 & year <= 2005,
         month %in% 6:9) %>% 
  select(matches(myvars), year, month)

t$month %>% unique()

df_sub <- df %>% 
  filter(year >= 2000) %>% 
  select(matches(myvars), month, year)

df_sub <- df_sub %>% 
  mutate(yield_g_m2 = yield_kg_m2*1000)

head(df_sub, n = 20)

df$crop_or_cover
df$crop_or_cover %>% unique()

df_sub %>% 
  group_by(crop_or_cover)

df_sub %>% 
  group_by(crop_or_cover) %>% 
  summarise(mean_yield = mean(yield_g_m2))

df_sub %>% 
  filter(month %in% 6:9) %>% 
  group_by(crop_or_cover) %>% 
  summarise(mean_yield = mean(yield_g_m2))

df_sub %>%
  filter(month %in% 6:9) %>% 
  group_by(year, crop_or_cover) %>% 
  summarise(mean_yield = mean(yield_g_m2))

df_sub %>%
  filter(month %in% 6:9) %>% 
  group_by(year, crop_or_cover) %>% 
  summarise(mean_yield = mean(yield_g_m2),
            mean_temp = mean(air_temp)) %>% 
  view()

df_sub %>% 
  group_by(crop_or_cover) %>%
  summarise(mean_yield = mean(yield_g_m2),
            min_c = min(yield_g_m2),
            max_c = max(yield_g_m2),
            n_c = n())

crop_ss <- df_sub %>% 
  group_by(crop_or_cover) %>%
  summarise(mean_yield = mean(yield_g_m2),
            min_c = min(yield_g_m2),
            max_c = max(yield_g_m2),
            n_c = n())

saveRDS(crop_ss, file = 'data/crop_sumstat.rds')
readRDS('data/crop_sumstat.rds')

write_csv(crop_ss, file = 'data/crop_sumstat.csv')

df_sub %>%
  count(crop_or_cover)








