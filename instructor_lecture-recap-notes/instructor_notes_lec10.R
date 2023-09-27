#### Recap last lec  ####

# GGPLOT - Grammar of Graphics

# 1.  **Philosophy** - layered graphics: 3 essential components:

# (1) Data (can pipe in for chained manipulation)
# (2) Mapping (aes()): to map data to visual aspects
# (3) Geometric Objects (`geom`).

library(dslabs)
library(tidyverse)
data(murders)

murders %>% ggplot(aes(x = population, y = total)) +
  geom_point()


# equivalent to 
ggplot(data = murders, aes(x = population, y = total)) + 
  geom_point()

# later you may find that using pipe operator can be more efficient (data manipulation; then plot)

# 2. **Customization**: color, size, shape (color = ; size = ; shape = )
# We'll use color as example, say we want to color the dots by region
# Color by region




murders %>% ggplot(aes(x = population, y = total, color = region)) + 
  geom_point()

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) 

# note the difference between the two? 
# plot: looks identical
# difference: global vs local aesthetics; see examples below when adding more layers
# - global: applies to all geom unless specified locally
# - local: overwrites global







murders %>% ggplot(aes(x = population, y = total, color = region)) + 
  geom_point() + 
  geom_line() #note how geom_line was also done by region; why?

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  geom_line()

# 3. **Adding layers**
# we've seen in the above example that layers can be added by "+"; we added a geom_line() there
# here's an example adding text to the plot using geom_text() at coordinates (x = 1e+07, y = 800)







murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) + 
  geom_text(aes(x = 1e+07, y = 800), label = "hello there!")



murders %>% ggplot(aes(x = population / 10^6, y = total)) + 
  geom_point(aes(color = region)) + 
  geom_text(aes(label = abb), nudge_x = 1.5, size = 2)


# we can also add a fitted regression line to show the trend/linear relationship

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) 
# "lm" for linear model, se = FALSE tells R to not plot the confidence band


# 4. **Other commonly used geoms**: geom_boxplot(), geom_histogram()





murders %>% ggplot(aes(x = region, y = total)) + 
  geom_boxplot()

murders %>% ggplot(aes(x = " ", y = total)) + 
  geom_boxplot()

# or, just specify as follows; you don't have to specify x = for boxplot
murders %>% ggplot(aes(y = total)) + 
  geom_boxplot()

# similarly, you don't have to specify y for histogram
murders %>% ggplot(aes(x = total)) + 
  geom_histogram()


# geom_bar(): bar plot
murders %>% ggplot(aes(x = region)) + geom_bar()


# geom_vline(): add a vertical blue line
murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  geom_line() + 
  geom_vline(aes(xintercept = 1e+07), color = "blue")

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  geom_line() + 
  geom_vline(aes(xintercept = 1e+07,color = "blue"))

# ? how the the above two different? 

# The aes() function is for aesthetic mappings, which means it maps data values to visual properties. 
# When you specify color = "blue" inside the aes(), you're telling ggplot2 to look for a variable named "blue" and map it to a color scale, which isn't what you want in this case.
# But there's no error or warning either
# Because you were basically saying "Color this line based on a categorical variable called 'blue'", rather than "Color this line blue".
# This "blue" factor level is then mapped to a color in ggplot2's default color palette, which in many cases starts with black, then goes to red, then green, and so forth. 




# geom_hline()
murders %>% ggplot(aes(x = population, y = total)) +
  geom_point() +
  geom_line() +
  geom_hline(aes(yintercept = 800), color = "red")






# 5. **Data manipulation then plot **: Last two weeks we learnt data wrangling (with pipe too!) now we'd like to make plots based on manipulated data
# say, I'd like to visualize the murder rate in the "Northeast" and "North" region 
# here: we don't have murder_rate in the data, so we need to define that; also we need to "filter" the region






murders %>% 
  mutate(murder_rate = total / population * 100000) %>% 
  filter(region %in% c("Northeast", "North Central")) %>% 
  ggplot(aes(x = population, y = murder_rate)) + 
  geom_point(aes(color = region)) + 
  geom_smooth(method = "lm", aes(color = region)) # with and without se



# 5. **Faceting**: to make multiple small plots
# both facet_wrap() and facet_grid() functions in the ggplot2 package in R that allow for the creation of small multiples
# (1) facet_wrap():  
# This function wraps 1D sequence of panels into a 2D grid, thus giving you more flexibility than the rigid matrix layout of facet_grid()
# Use case: When you have a single factor (categorical variable) that you'd like to break your visualizations across.
# yout: The panels are displayed in a wrapped fashion. You can control the number of rows or columns using the nrow or ncol arguments.


murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  facet_wrap(~region)

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  facet_wrap(~region, nrow = 1)

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  facet_wrap(~region, ncol = 1)


# (2) facet_grid():
# This function allows you to create a matrix of panels, with a variable defining the rows and another defining the columns. The formula is of the form rows ~ columns
# Use case: if you want to show the distribution of a variable across different combinations of two factors 
# Layout: The panels are laid out in a grid that's defined by the levels of two variables.
murders %>% 
  mutate(pop_bin = case_when(
    population <= 1e+07 ~ "<= 10M",
    T ~ "> 10M"
  )) %>% 
  ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  facet_grid(region ~ pop_bin)


# 6. ** Appearance customization**
# (1) themes: theme_classic(), theme_light(), etc; or theme_economist() etc from extended packages
library(ggthemes)

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  theme_gray() #default

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) +
  theme_economist()


# (2) add titles, xlabels, y labels: labs()

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) + 
  labs(title = "Population by Murders Total",
       x = "Population", 
       y = "Total")  

# if only adding title/xlab/ylab; another option is ggtitle()/xlab()/ylab()


murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point(aes(color = region)) + 
  ggtitle("Population by Murders Total") + 
  xlab("Population") + 
  ylab("Total")


# Many ggplot2 users prefer to use labs() because of its versatility, even when only modifying the title, to keep consistency in their coding style.



# (3) x-axis customization: `scale_x_continuous()` for continuous x-axis, such as population in our murders example
# Some common customizations you might make with `scale_x_continuous()` include:
  
# a). **Setting axis limits**: You can specify the minimum and maximum values displayed on the x-axis.
# b). **Customizing breaks**: Breaks determine where the tick marks and labels appear on the axis. You can manually set these or use functions to determine them.
# c). **Applying transformations**: You can transform the data, such as taking the logarithm, before displaying it on the x-axis.
# d). **Modifying axis labels**: You can provide custom text labels for the tick marks on the x-axis.

# But, mostly use if for customizing breaks or transformations
# limits and labels can be easily changed in labs() or lims()




murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  scale_x_continuous(breaks = c(0, 1e+07, 3e+07)) 

murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point() + 
  scale_x_continuous(trans = "log10") 


# There are three variant commonly used for transformation:
# `scale_x_sqrt()` and  `scale_y_sqrt()` : square root transformation for x or y axis
# `scale_x_log10()` and `scale_y_log10()` log10 trans
# `scale_x_reverse()` and `scale_y_reverse()` : reverse the axis


p <- murders %>% ggplot(aes(x = population, y = total)) + 
  geom_point()

p + scale_y_log10()
p + scale_x_log10()

p + scale_y_sqrt()






# 8. **Practice with Different Datasets**:
  # Use diverse datasets and encourage students to play around with different `geom` functions and `aes` mappings.
# load the mtcars data set and make a scatter plot with x = mpg and y = st, color by cyl (convert to factor first)
library(ggplot2)
data(mtcars)

ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = factor(cyl)))
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = cyl))


mtcars <- mtcars %>% mutate(cyl = factor(cyl))
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point(aes(color = cyl))


# Today's lecture
# 1. go over the above code
# 2. intro-to-ggplot() quick review (feel easier?)
# 3. gapminder: as a practice/example  - real-world data visualization 
# 4. lab this week: practice with more examples 
# 5. HW2 released 9/25; due in Oct 15. Updated on course website and canvas
# 6. Don't need to worry about the canvas assigment/hw, they are for TF grading purpose only
