#### Recap last lec  ####

# Let's visualize the murders data together! (then we'll look at some more interesting examples)
# Quiz: three essential components of ggplot?

# Useful short-cut: 
# You can comment out a line or a block of lines using the following keyboard shortcuts:
# For Mac: Cmd + Shift + C
# For Windows: Ctrl + Shift + C
# You can toggle the comment on or off

# 1.  **ggplot()** - layered graphics: 3 essential components:
library(dslabs)
library(tidyverse)
library(ggthemes)
library(ggrepel) 


# First, identify which df to plot, and whether we need any calculation for what we want
# Second: mapping
# Third, what kind of geometry 
# Customization: pay attention to:
# (1) x and y scales/transformations: remember scale_x_continuous() and scale_y_continuous() are designed to perform such tasks, rather than directly change the global mapping
# (2) color, size, shape of geometry
# (3) title, label, themes

# We want to show a plot with x being population in millions (log10 scale), y being total (log10scale)
# We want to add a line with log(y) = a + b*log(x in million)
# So we'll need to calculate a and b




















r = murders %>% summarise(r = sum(total) / sum(population) * 10^6) %>% .$r
# r = sum(murders$total) / sum(murders$population) * 10^6

murders %>% ggplot(aes(x = population / 10^6, y = total)) + 
  geom_point(aes(color = region), size = 3) + 
  scale_x_continuous(trans = "log10") + # equivalent to scale_x_log10()
  scale_y_continuous(trans = "log10") +  # equivalent to scale_y_log10()
  geom_text_repel(aes(label = abb)) + 
  geom_abline(intercept = log10(r), slope = 1, color = "darkgrey", lty = 2)+ 
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist()

# **Optional (1) **: not so convenient if directly log transform in the aesthetics
# murders %>% ggplot(aes(x = log10(population), y = log10(total))) + 
#   geom_point(aes(color = region), size = 3) + 
#   # geom_text(aes(label = abb), nudge_x = 0.1)
#   geom_text_repel(aes(label = abb)) + 
#   scale_x_continuous(labels = function(x) 10^x/10^6, breaks = log10(c(1e6, 3e6, 10e6, 30e6))) + 
#   scale_y_continuous(labels = function(y) 10^y, breaks = log10(c(10, 100, 1000))) + 
#   xlab("Population (in Millions)") + 
#   ylab("Total number of murders (log scale) ") +
#   ggtitle("US Gun Murders in 2010") 



# ** Optional (2) **: define customized transformation 
# library(ggplot2)
# library(scales)
# 
# # Define the transformation and its inverse
# log8_trans <- function(x) { log(x, base = 8) + 2 }
# log8_inv <- function(x) { 8^(x - 2) }
# 
# # Create the custom transformation object
# log8plus2_trans <- trans_new("log8plus2", 
#                              transform = log8_trans, 
#                              inverse = log8_inv)
# 
# # Use in ggplot2
# murders %>% 
#   ggplot(aes(x = population, y = total)) + 
#   geom_point(aes(color = region), size = 3) + 
#   scale_x_continuous(trans = log8plus2_trans) +
#   scale_y_continuous(trans = log8plus2_trans) +
#   theme_minimal()

# Code review
# First define the slope of the line
r <- murders %>% 
  summarize(murder_rate= sum(total) /  sum(population) * 10^6) %>% .$murder_rate

# Now make the plot
murders %>% ggplot(aes(population/10^6, total, label = abb)) +   
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col=region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() + 
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist()




# 2. ** other geometry **: geom_line(), geom_histogram(), geom_boxplot()
# 3. ** multiple small plots **: facet_wrap(), facet_grid()



# Today's lecture
# 1. review the above code for creating the plot for murders
# 2. gapminder: as a practice/example  - real-world data visualization (last week's lab covered first half)
# 3. lab this week: practice with more examples - remember the confusing/misleading graph in the first lecture? 
# 4. HW2 released 9/25; due in Oct 22 (extended 1 week). Updated on course website and canvas
# 5. Don't need to worry about the canvas assigment/hw, they are for TF grading purpose only

labels <- data.frame(country = countries, x = c(1975, 1965), y = c(5, 2.75))
countries <- c("South Korea", "Germany")
gapminder %>% filter(country %in% countries) %>% 
  ggplot(aes(year, fertility, color = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none") +
  xlab("Year") +
  ylab("Fertility (avg number of children per woman)")

