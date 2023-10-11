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


# Both methods in ggplot2 transform the data, but they have different implications and use cases. 
# (1) Transforming data directly within aes():
# Actual Transformation: This method actually transforms the data values before plotting them. If you use aes(x = log(x_original)), the data is logged before any geom is applied.
# Axes and Data Points: The axes will be labeled with the transformed values, and any subsequent layer or geom that references this aesthetic will operate on the transformed data.
# Implication for Modeling: If you fit a model using geom_smooth() or any other modeling function, it will be fitted to the transformed data, which may be inappropriate if you didn't want this.


# (1) Transforming data directly within aes():
# Actual Transformation: This method actually transforms the data values before plotting them. If you use aes(x = log(x_original)), the data is logged before any geom is applied.
# Axes and Data Points: The axes will be labeled with the transformed values, and any subsequent layer or geom that references this aesthetic will operate on the transformed data.
# Implication for Modeling: If you fit a model using geom_smooth() or any other modeling function, it will be fitted to the transformed data, which may be inappropriate if you didn't want this.
# (2) Using scale_x_continuous(trans = ...):
# Visual Transformation: This method keeps the original data values intact, but changes the scale on which they're displayed. This is purely a visual transformation.
# Axes and Data Points: The axes will be spaced logarithmically (or the way you transformed the data), but the axis labels will show the original values, making it clear that a log scale is being used.
# Implication for Modeling: If you fit a model, it's fitted to the original data, not the transformed one.
# **General recommendations **
# (1) If you only want to change the visualization aspect of your plot (i.e., the way your data is presented on the plot), then you should use the scale transformation.
# (2) If you want to actually transform your data and have subsequent layers operate on this transformed data, then you should transform it within aes().


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

# 2. Homework related
# Q1: rate calculation: canvas announcement
# Q3: sqrt transformation: 
# Q4: breaks on y-axis: 

# Today's lecture
# 1. data viz principles; geom_tile()
# 2. map - optional but cool
# 3. no lab this week; lab next week
# 4. HW2 released 9/25; due in Oct 22. Updated on course website and canvas
# 5. next week: advanced data wrangling (mid term in end October/early November)
