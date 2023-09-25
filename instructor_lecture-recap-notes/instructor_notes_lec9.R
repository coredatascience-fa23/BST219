#### Recap last lec  ####

  
# ggplot 
# 1. **Conceptual Introduction**:
# - Start with the idea that `ggplot2` uses a "layered" approach to creating graphics.
# - Emphasize the Grammar of Graphics philosophy: Data, Aesthetics, and Geometric Objects (`geom`).

# 2. **Comparison with Basic Plot**:
# Begin with a simple scatter plot. Compare it with a base R equivalent to see the difference and potential benefits.
# Base R
library(dslabs)
data(murders)
plot(murders$population, murders$total)

# ggplot2
library(ggplot2)
ggplot(murders, aes(x = population, y = total)) + geom_point()

# differences ?

# (1). Philosophy:
# Base R Plots:
# Procedural: Define each step in creating the plot.
# More of a "canvas" model where elements are drawn onto a plot in sequence.
# ggplot2:
# Declarative: Define what you want the plot to look like, not how to draw it.
# Based on the "Grammar of Graphics" - a set of rules to create consistent and effective graphics.
# (2). Syntax:
# Example: Creating a scatter plot
# (3). Layering:
#   Base R:
#   Elements are added sequentially.
# ggplot2:
#   Uses a layered approach. You "add" layers to your plot using the + operator.
plot(murders$population, murders$total)
abline(lm(total ~ population, data=murders))

ggplot(murders, aes(x = total, y = population)) + 
  geom_point() +
  geom_smooth(method="lm", se=FALSE)

# (4). Customization:
#   Base R:
#   Uses various functions for modifying aspects of the plot (e.g., xlim, ylim, main, xlab).
# Might require deeper understanding and more code to customize complex plots.
# ggplot2:
#   Consistent syntax using labs, theme, and other functions.
# Themes can be applied for consistent styling.

# (5). Extensibility:
#   Base R:
#   Limited to the functions provided by base R, though some packages extend it.
# ggplot2:
#   Easily extensible. Many packages (e.g., gganimate, ggridges, ggmap) extend its capabilities.

# (6). Consistency:
#   Base R:
#   Might need different functions for different types of plots (e.g., plot, boxplot, hist).
# ggplot2:
#   Uses a consistent approach regardless of the type of plot. Change the geom function to switch between plot types.

# (7). Learning Curve:
#   Base R:
#   Might be more intuitive for beginners for simple plots.
# Direct mapping of function arguments to plot characteristics.
# ggplot2:
#   Steeper initial learning curve, especially understanding aes and geom.
# More consistent and powerful for advanced plotting

# (8). Data Structure:
#   Base R:
#   Can use vectors directly, without needing a data frame.
# ggplot2:
#   Prefers tidy data frames. Encourages the use of the tidyverse ecosystem for data manipulation and visualization.




# 3. **Aesthetics (`aes`)**:
# - `aes` is used to map data to visual aspects.
# - Start with simple mappings and progressively add complexity.
# Simple plot; global aes
ggplot()
ggplot() + geom_point(data = murders, aes(x = population, y = total))
ggplot(data = murders) + geom_point(aes(x = population, y = total))
ggplot(murders, aes(x = population, y = total)) + geom_point()

# Color by region
ggplot(murders, aes(x = population, y = total, color = region)) + geom_point()
ggplot(murders, aes(x = population, y = total)) + geom_point(color = region) # why error?
ggplot(murders, aes(x = population, y = total)) + geom_point(aes(color = region)) + geom_text(aes(x = 1e+07, y = 800, label = "hello") )

# Dot size by total
ggplot(murders, aes(x = population, y = total, color = region, size = total)) + geom_point()
ggplot(murders, aes(x = population, y = total, color = region)) + geom_point(aes(size=total))

# Shape by region
ggplot(murders, aes(x = population, y = total, color = region, shape = region)) + 
  geom_point()
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region, shape = region)) 


# 4. **Adding Layers**:
# Show how easy it is to add layers like regression lines, smooth curves, etc.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  geom_smooth(method = "lm")

library(tidyverse)
murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region, size = total)) +
  geom_smooth(method = "lm", se = FALSE)


# 5. **Different Geoms**:
# Demonstrate different types of visualizations by changing the `geom` function.
# Boxplot base plot
boxplot(murders$total)
boxplot(murders$total ~ murders$region)
# Boxplot ggplot
ggplot(murders, aes(x = " ", y = total)) + geom_boxplot()
ggplot(murders, aes(x = region, y = total)) + geom_boxplot()


# 6. **Faceting**:
# Introduce the idea of creating multiple plots based on a factor.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point() +
  facet_wrap(~region)
# add color
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(col = region) +
  facet_wrap(~region) # why error?

ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(col = region)) +
  facet_wrap(~region)

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(col = region)) + 
  facet_wrap(~region)

# what if by state? (not really useful but for educational purpose)

# 7. **Customizing Appearance**:
# Talk about themes, labels, and other customizations.
# default theme (theme_gray())
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region")  
#     + theme_gray()


# + theme_bw():A theme with a white background and black grid lines. Useful for plots intended for black-and-white printing.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point() +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total") +
  theme_bw()

# + theme_light(): A light theme with minimal grid lines and outside borders.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_light()

# + theme_minimal(): Similar to theme_light(), no borders
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_minimal()

# + theme_classic(): A classic-looking theme without grid lines.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_classic()

# + theme_void(): A completely empty theme. This is useful if you want to start from scratch without any default styles.
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_void()

# theme_economist(): library like ggthemes provides more themes:  Styled like plots from The Economist magazine.
library(ggthemes)
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_economist()

# theme_wsj(): Styled after plots from The Wall Street Journal.
# (click on "Zoom" in your Plots tab to get the full view if your plot seemed cropped in the panel)
ggplot(murders, aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  labs(title = "Population by Murders Total",
       x = "Population", y = "Total", color = "Region") +
  theme_wsj()



# 8. **Practice with Different Datasets**:
  # Use diverse datasets and encourage students to play around with different `geom` functions and `aes` mappings.
# load the mtcars data set and make a scatter plot with x = mpg and y = st, color by cyl (convert to factor first)
library(ggplot2)
data(mtcars)

ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = factor(cyl)))
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = cyl))


mtcars <- mtcars %>% mutate(cyl = factor(cyl))
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = cyl))

# 9. **bar plot**: makes the height of the bar proportional to the number of cases in each group
murders %>% ggplot(aes(x = region)) + geom_bar()
murders %>% ggplot(aes(x = region)) + geom_bar(aes(fill = region))
murders %>% ggplot(aes(x = region)) + geom_bar(aes(fill = region), alpha = 0.5)
# In this line, the alpha aesthetic (which controls transparency) is set outside of the aes() function, at the level of geom_bar(). This means that the transparency of all bars will be set to 0.5. Each bar, irrespective of its region value, will have the same level of transparency.
murders %>% ggplot(aes(x = region)) + geom_bar(aes(fill = region, alpha = 0.5))
# Here, the alpha aesthetic is set inside the aes() function. Normally, when you set an aesthetic inside aes(), ggplot2 expects it to be mapped to a variable in your dataset. However, alpha = 0.5 is a constant, not a variable mapping. This might cause ggplot2 to produce a legend for alpha values, even though there's only one constant value being used.

# 10. **Common Pitfalls & Solutions**:
#   putting variables outside `aes` when they should be inside or vice versa

# 11. **line graph**: geom_line() Show the connection between data points
# murders example (not really meaningful; educaitonal purpose only)
murders %>% ggplot(aes(x = population, y = total)) + 
  geom_line(col = "red") + 
  geom_point(aes(col = region))

# 12 ** histograms and density ** Explore the distribution of a single variable.
murders = murders %>% mutate(murder_rate = total / population * 100000)
murders %>% ggplot(aes(x = murder_rate)) + geom_histogram(alpha = 0.5) 

# Today's lecture
# 1. ggplot finish 01-intro
# 2. next: more on ggplot: histogram, bar plot, lines, time series plots 
# 3. lab this week: practice with more examples 
# 4. HW2 to be released later today 9/25; due in 3 weeks. Will update on course website and canvas
# 5. Don't need to worry about the canvas assigment/hw, they are for TF grading purpose only
