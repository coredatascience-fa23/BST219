#### Recap last lec  ####


# RANDOM Quiz: What are the functions in ggplot used to create multiple smaller plots within one plot?

# Useful tip of the day: Use `rm(list = ls())` to remove all variables from your environment
rm(list = ls())

# 1.  **gapminder** - visualization of world health and economics in gapminder
library(dslabs)
data(gapminder)
head(gapminder)

names(gapminder) # what variables are in there


# EXAMPLE 1 : fertility rates and life expectancy 


library(ggplot2)
library(tidyverse)

ds_theme_set("theme_gray") # by default: theme_bw

years_to_plot = c(1962, 2012)

# (1) Spot the difference
gapminder %>% filter(year %in% years_to_plot) %>% 
  ggplot(aes(fertility, life_expectancy)) + 
  geom_point(aes(color = year)) + # what happened here to the legend? 
  labs(x = "Life expectancy (years)",
       y = "Fertility (avg number of children per woman)",
       title = paste ("Life Expectancy vs Fertility in Year", 
                      paste(years_to_plot, collapse = ", ") )
  )

class(gapminder$year)
# "integer": ggplot will treat it as continuous by default, and you'll typically get a gradient color bar as the legend

gapminder %>% filter(year %in% years_to_plot) %>% 
  ggplot(aes(fertility, life_expectancy)) + 
  geom_point(aes(color = factor(year))) + # what happened here? 
  labs(x = "Life expectancy (years)",
       y = "Fertility (avg number of children per woman)",
       title = paste ("Life Expectancy vs Fertility in Year", 
                      paste(years_to_plot, collapse = ", ") ),
       color = "Year" # also changed the label in legend for color
  )

# (2) Visualize by continent (in rows) and year (in columns)
gapminder %>% filter(year %in% years_to_plot) %>%
  ggplot(aes(fertility, life_expectancy)) +
  geom_point(aes(color = continent)) + # don't forget aes() here too, because continent is a variable in our df to be mapped out
  facet_grid(continent ~ year) +
  labs(
    x = "Fertility (avg number of children per woman)",
    y = "Life expectancy (years)", 
    color = "Continent")

# apply(gapminder, MARGIN = 2, FUN = class)
# for(varname in names(gapminder)){
#   var = gapminder[[varname]]
#   print(paste("The class for", varname, "is", class(var)))
# }

# Use faceting instead of ggploting multiple times: fixed scale for each smaller plot for easy comparison






# EXAMPLE 2: Income distribution


# (1) plot the time series line of fertility for all years for SK and G

countries_to_plot <- c("South Korea", "Germany")
p_ts <- gapminder %>% filter(country %in% countries_to_plot) %>% 
  ggplot(aes(year, fertility)) +
  geom_line(aes(color = country)) +
  labs(
    x = "Year",
    y = "Fertility (avg number of children per woman)",
    color = "Country") 
p_ts
p_ts + theme(legend.position = c(0.8, 0.9)) 

# to move the legend inside of the plot 
# 0.8 is the x-coordinate, indicating 90% from the left edge of the plot area.
# 0.9 is the y-coordinate, indicating 90% from the bottom edge (or 10% from the top edge) of the plot area.
labels_for_countries_to_plot = data.frame(
  country = countries_to_plot, 
  x = c(1975, 1965),
  y = c(5, 2.75)
)

gapminder %>% filter(country %in% countries_to_plot) %>% 
  ggplot(aes(x = year, y = fertility, color = country)) +
  geom_line() +
  geom_text(data = labels_for_countries_to_plot, 
            aes(x = x, y = y, label = country)) + 
  theme(legend.position = "none") 

# to add annotation/text besides the lines:
# option 1: shown in our lecture file is by creating a data frame for labels
# option 2: using annotate to add each label individually
p_ts + 
annotate("text", x = 1975, y = 5, label = "South Korea", size = 5) +
annotate("text", x = 1965, y = 2.75, label = "Germany", size = 5)

# # (Optional - for you to play with: to change the color of the labels)
# sorted_countries_to_plot = sort(countries_to_plot)
# colors <- scales::hue_pal()(length(sorted_countries_to_plot))
# names(colors) <- sorted_countries_to_plot
# 
# p_ts +
#   annotate("text", x = 1975, y = 5, label = "South Korea", size = 5, color = colors["South Korea"]) +
#   annotate("text", x = 1965, y = 2.75, label = "Germany", size = 5, color = colors["Germany"])

# (2) histogram: to view the distribution of a variable of interest 

gapminder <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365)

past_year <- 1970 # save the variable for easier access; if I want to reuse it later I only need to change it one tim

gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "blue") +
  labs(x = "Dollars per day", 
       y = "Number of countries")

# (3) scale: transformations **scale_x_continous**
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  labs(x = "Dollars per day", 
       y = "Number of countries")

# (4) boxplot: to view distributions with summary statistics; can be done side by side by factors

p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(region, dollars_per_day))  +
  xlab("Region") +
  ylab("Dollars per day")
p + geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



# Today's lecture
# 1. gapminder continued
# 2. data visualization principles
# 4. HW2 released 9/25; due in Oct 22. Contact teaching staff if you don't see it in your repo.
