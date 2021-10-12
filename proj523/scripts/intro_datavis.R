library(tidyverse)

df_temp <- read_csv('https://raw.githubusercontent.com/Z3tt/R-Tutorials/master/ggplot2/chicago-nmmaps.csv')

# we build layers on ggplot foundation
ggplot()

ggplot(data = df_temp,
       aes(x = date, y = temp))

gp <- ggplot(data = df_temp,
             aes(x = date, y = temp))

gp +
  geom_point()

gp +
  geom_line()

gp +
  geom_point() +
  geom_line()

# change properties of our plot layers

gp +
  geom_point(color = 'firebrick', shape = 'diamond', size = 2) +
  geom_line()

gp +
  geom_point(color = 'firebrick', shape = 'diamond', size = 2) +
  geom_line(size = .2, alpha = 0.5)

gp +
  geom_point(color = 'firebrick', shape = 'diamond', size = 2) +
  geom_line(size = .2, alpha = 0.5) +
  theme_bw()


gp +
  geom_point(color = 'firebrick', shape = 'diamond', size = 2) +
  geom_line(size = .2, alpha = 0.5) +
  theme_classic()

gp +
  geom_point(color = 'firebrick', shape = 'diamond', size = 2) +
  geom_line(size = .2, alpha = 0.5) +
  theme_minimal()

gp +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)')

gp +
  geom_point() +
  xlab('Year') +
  ylab('Temperature') +
  ggtitle(label = 'Temperature Across Time',
          subtitle = 'Chicago 1997-2001')

gp +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       title = 'Temperature Across Time',
       subtitle = 'Chicago 1997-2001')

gp +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       title = 'Temperature Across Time',
       subtitle = 'Chicago 1997-2001',
       caption = 'my caption') +
  theme(plot.title = element_text(color = 'red',
                                  size = 12,
                                  face = 'bold',
                                  hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(size = 12, face = 'italic'),
        axis.text.x = element_text(angle = 50, hjust = 1))
# axis.title.y axis.title.x

gp +
  geom_point() +
  labs(x = 'Year', y = '',
       title = 'Temperature Across Time',
       subtitle = 'Chicago 1997-2001',
       caption = 'my caption') +
  theme(plot.title = element_text(color = 'red',
                                  size = 12,
                                  face = 'bold',
                                  hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(size = 12, face = 'italic'),
        axis.text.x = element_text(angle = 50, hjust = 1),
        axis.ticks = element_blank(),
        axis.text.y = element_blank())

gp +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       title = 'Temperature Across Time',
       subtitle = 'Chicago 1997-2001',
       caption = 'my caption') +
  theme(plot.title = element_text(color = 'red',
                                  size = 12,
                                  face = 'bold',
                                  hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(size = 12, face = 'italic'),
        axis.text.x = element_text(angle = 50, hjust = 1)) +
  ylim(c(0, quantile(df_temp$temp, 0.75)))

ggplot(data = filter(df_temp, temp > 20),
       aes(x = date, y = temp)) +
  geom_point() +
  expand_limits(y = -10)

ggplot(df_temp, aes(x = date, y = temp, color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)')

ggplot(df_temp, aes(x = date, y = temp, color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)') +
  theme(legend.position = 'none')

ggplot(df_temp, aes(x = date, y = temp, color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       title = 'title') +
  theme(legend.position = 'left')

ggplot(df_temp, aes(x = date, y = temp, color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)') +
  theme(legend.position = c(0.15, 0.15))

ggplot(df_temp, aes(x = date, y = temp, color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)') +
  theme(legend.position = c(0.15, 0.15),
        legend.background = element_rect(fill = 'transparent'))

ggplot(df_temp, aes(x = date, y = temp,
                    shape = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)')

ggplot(df_temp, aes(x = date, y = temp,
                    shape = season,
                    color = season)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)')

ggplot(df_temp, aes(x = date, y = temp,
                    color = temp)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)')

ggplot(df_temp, aes(x = date, y = temp,
                    color = temp)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       color = 'Temperature (F)')

ggplot(df_temp, aes(x = date, y = temp,
                    color = temp)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       color = 'Temperature (F)') +
  guides(color = guide_colorsteps())


ggplot(df_temp, aes(x = date, y = temp,
                    color = temp)) +
  geom_point() +
  labs(x = 'Year', y = 'Temperature (F)',
       color = 'Temperature (F)') +
  guides(color = guide_bins())

######### plotting a fitted curve

mtcars

mtcars %>% pairs()

ggplot(mtcars, aes(x = mpg, y = hp)) +
  geom_point()

ggplot(mtcars, aes(x = mpg, y = hp)) +
  geom_point() +
  geom_smooth(method = 'lm')

##### infographic plotting

library(ggimage)

df_image <- tibble(X = rnorm(10),
                   Y = rnorm(10),
                   my_images = sample(c('https://www.r-project.org/logo/Rlogo.png',
                                        'https://www.python.org/static/community_logos/python-logo-master-v3-TM.png'),
                                      size = 10, replace = TRUE))

ggplot(df_image, aes(X, Y))

ggplot(df_image, aes(X, Y)) +
  geom_point()

ggplot(df_image, aes(X, Y)) +
  geom_image(aes(image = my_images))
