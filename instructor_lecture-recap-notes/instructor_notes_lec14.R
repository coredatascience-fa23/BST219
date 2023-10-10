#### Recap last lec  ####


# RANDOM Quiz: 
# Transformations: 
# You want to apply a logarithmic transformation to the y-axis of your plot. Which scale function would you use?
# a) scale_x_continuous()
# b) scale_y_log10()
# c) scale_x_log10()
# d) scale_y_discrete()

# Useful tip of the day:  use command + I to auto align codes/brackets, make it more readable and easier for debug
# Windows: Ctrl + I or Ctrl + Shift + A
# for(i in 1:10) {
# if(i %% 2 == 0) {
# print(paste(i, "is even"))
# } else {
# print(paste(i, "is odd"))
# }
# }

# 1.  **gapminder** - visualization of world health and economics in gapminder
library(dslabs)
data(gapminder)
head(gapminder)
# example 2: income distribution

library(ggplot2)
library(tidyverse)

ds_theme_set("theme_gray") # by default: theme_bw

past_year = 1970
present_year = 2010
country_list_1 <- gapminder %>% 
  filter(year == past_year & !is.na(dollars_per_day)) %>% .$country

country_list_2 <- gapminder %>% 
  filter(year == present_year & !is.na(dollars_per_day)) %>% .$country

country_list <- intersect(country_list_1, country_list_2)

gapminder %>% 
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(region, dollars_per_day, fill = factor(year))) +
  geom_boxplot() +
  scale_y_continuous(trans = "log2") + 
  labs(x = "", 
       y = "Dollars per day",
       fill = "Year") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 


# Why the transformation?
# We sometimes prefer transformations like logarithmic scaling, 
# sorting, or others on the x or y axes for various reasons.
# These transformations can make data more interpretable, 
# highlight certain aspects of the data, or simplify the visual representation

# 1. Distributions with long tails =: 
# In cases where data has a long tail or spans several orders of magnitude, 
# a logarithmic transformation can make the data more interpretable by compressing 
# the scale in a way that emphasizes relative differences. 
# This is especially common in fields like finance (e.g., stock prices), 
# biology (e.g., gene expression levels), or any area where exponential growth or decay is observed.

# 2. Linearity assumptions: 
# Transformations, such as square root or logarithmic, 
# can sometimes linearize relationships, 
# making patterns more visable and relationships more interpretable. 

# 3. Better resolution for specific data range: 
# Sometimes, the range of interest might be a small portion of the overall data range. 
# Transformations can provide better resolution or focus on that specific range.

# 4. Categorical data
# Sorting is common when dealing with categorical data. 
# Ordering categories by frequency or another metric
# (instead of alphabetically or by factor level) can make the plot easier to interpret.



# Today's lecture
# 1. data viz principles with a focus on the geom_grid()
# 2. map - optional but cool
# 3. no lab this week; lab next week
# 4. HW2 released 9/25; due in Oct 22. Updated on course website and canvas
# 5. next week: advanced data wrangling (mid term in end October/early November)
