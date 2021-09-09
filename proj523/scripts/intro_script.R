weight_kg <- 55
paste('The weight measurement is', weight_kg, sep = ' ')
paste('The weight measurement is', weight_kg, sep = '+')
cat('The weight measurement is', weight_kg)

2.2*weight_kg
paste('Converting weight kg to lb is', 2.2*weight_kg, sep = ' ')
weight_kg <- 75
weight_kg
weight_lb <- 2.2*weight_kg
weight_kg <- 100
weight_lb
2.2*weight_kg

# comments are helpful
weight_kg_sqt <- sqrt(weight_kg)

pi
round(pi, digits = 2)
round(pi, 2)
round(digits = 2, x = pi)
round(2, pi)
round(pi, digits = 100)

weight_g <- c(50, 60, 65, 82)
animals <- c('mouse', 'rat', 'dog')
length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)

weight_g <- c(weight_g, 90)
weight_g <- c(30, weight_g)
weight_gv2 <- c(20, 62, 45)
weight_g <- c(weight_g, weight_gv2)

num_char <- c(1, 2, 3, 'a')

animals <- c('mouse', 'rat', 'dog', 'cat')
animals[2]
animals[c(3, 2)]
more_animals <- animals[c(1, 2, 3, 2, 1, 4)]

weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, FALSE, TRUE, TRUE)]
weight_g[c(TRUE, FALSE, FALSE, T, T)]
weight_g > 50
weight_g[weight_g > 50]
weight_g[weight_g > 30 & weight_g < 50]
weight_g[weight_g <= 30 | weight_g == 55]
weight_g[weight_g >= 30 & weight_g == 21]
weight_g[weight_g >= 30 | weight_g == 39]

animals <- c('mouse', 'rat', 'dog', 'cat', 'cat')
animals[animals == 'cat' | animals == 'rat']
other_animals <- c('rat', 'cat', 'dog', 'duck', 'goat')
# %in%
animals[animals %in% other_animals]
other_animals[other_animals %in% animals]

heights <- c(2, 4, 4, NA, 6)
mean(heights)
max(heights)
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

is.na(heights)
!is.na(heights)
heights[!is.na(heights)]
na.omit(heights)
complete.cases(heights)
heights[complete.cases(heights)]

heights_inch <- c(63, 69, 60, 65, NA, 68,
                  61, 70, 61, 59, 64, 69,
                  63, 63, NA, 72, 65, 64,
                  70, 63, 65)
# use median() to calculate the median of heights
# figure out how many people are taller than 67




