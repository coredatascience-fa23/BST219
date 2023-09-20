#### Recap last week ####

  
# Basic plots
  
# 1. **plot()**: Used for creating scatter plots or line graphs; 
# offers a simple way to quickly visualize data without needing to specify many details
x <- c(1, 2, 3, 4, 5)
y <- c(1, 4, 9, 16, 25)
plot(x, y)

plot(x, y, type = "l") # for a line instead of scattered dots
plot(x, y, type = "l", main = "title of the plot", xlab = "label of x-axis", ylab = "label of y-axis")

plot(x, y, type = "b") # combining both dot and line

# 2. **hist()**: Used for creating histograms to visualize the distribution of a dataset.
# Create data
data <- c(1, 2, 2, 3, 3, 3, 4, 4, 5)
# Create a histogram
hist(data)
hist(data, main = "Simple Histogram", xlab = "Data Values", ylab = "Frequency")


# 3. **boxplot()**: Used for displaying the five-number summary (minimum, first quartile, median, third quartile, and maximum) of a dataset.
# Create data
data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
# Create a boxplot
boxplot(data, main = "Simple Boxplot", ylab = "Data Values")




# Importing data
  
# 1. **read.csv()**:Used for reading CSV files into R as a data frame.
# my_data <- read.csv("my_file.csv") 

# 2. **path of file**: setwd(); getwd(); dropdown menu
# setwd() sets the working directory, getwd() gets the current working directory, and the dropdown menu can also be used for navigation.
# setwd("/path/to/directory") # need to be a valid path; this is just an example path
getwd()



# Programming basics
# 1. **if else statement **: Used for conditional execution of code.
x <- 4
if (x > 0) {
  print("Positive")
} else {
  print("Non-positive")
}



# **ifelse()** function:
ifelse(x > 0, "Positive", "Non-positive")



# **any()** function and **all()** function
# Example 1: Using any() with a logical vector:
logical_vector <- c(FALSE, FALSE, TRUE, FALSE)
result <- any(logical_vector)
result  # Output will be TRUE

# Example 2: Using any() with a numeric vector:  it will internally convert the numbers to logical values.
numeric_vector <- c(0, 0, 3, 0)
result <- any(numeric_vector)
result  # Output will be TRUE

# Example 3: Using any() with conditions
ages <- c(25, 30, 18, 40)
result <- any(ages < 20)
result  # Output will be TRUE



# 2. **functions**: Reusable pieces of code that perform specific tasks.
# Syntax to call a function: function_name(input1, input2)
# Syntax to defind a function: function_name <- function(arg1, arg2, ...){}

add_numbers <- function(a, b){
  return(a + b)
}
result = add_numbers(3, 4) # short for 
result = add_numbers(a = 3, b = 4)
result
# note that a, b are internal names and will not be shown in the outer environment
a
b

square_number <- function(x) {
  return(x * x)
}

square_number(5)
square_number(x = 5)
x

# key points: 
# (1) the input are called arguments; 
# (2) return value
# (3) R has many built-in funcitons so you dont' have to define yourself
# (4) reuse: once a function is defined you can use it multiple times; making code easier to mange and more organized


# Exercises for Practice:
# Use our murders data example to write a function, taking in two arguments: the murders dataset and a cutoff for total number of murders
# Goal: output the name of states whose total number of murders is above the cutoff

library(dslabs)
data(murders)
total_gt_cutoff <- function(murders, cutoff){
  ind <- which(murders$total > cutoff)
  return(murders$state[ind])
  
}
total_gt_cutoff(murders, 100)

total_gt_cutoff2 <- function(dataset, cutoff){
  ind <- which(dataset$total > cutoff)
  return(dataset$state[ind])
  
}
total_gt_cutoff2(murders, 100)



# 3. **for loops**: Used for repetitive tasks, iterating over elements in a vector or list.
for (i in 1:5) {
  print(i)
}

numbers <- c(1, 2, 3, 4, 5)
for (n in numbers) {
  print(n^2)
}

# Exercises for Practice:
# Sum of Numbers: Write a for loop to calculate the sum of numbers from 1 to 10.
s = numeric(1) # initial value for summation, equivalent to setting s = 0
for(i in 1:10){
  s = s + i
}
s

# Reverse a Vector: Write a for loop to reverse the elements of a given vector.
vec <- c(1, 2, 3, 4, 5)
rev_vec <- numeric(length(vec)) # equivalent to rev_vec = c(0, 0, 0, 0, 0) or rev_vec = rep(0, 5)
for(i in 1:length(vec)){
  rev_vec[i] = vec[length(vec)-i+1]
}
rev_vec
# Loop Over Strings: Write a for loop that iterates over a vector of strings and prints each string's length.
vec_char <- c("I", "love", "R", "Studio")
for(i in 1:length(vec_char)){
  print(nchar(vec_char[i]))
}




  
# Today's lecture
# 1. Programming basics (cont'd)
# 2. In-class coding: programming basics
# 3. Intro to ggplot (if time permits; otherwise we'll make pretty plots next week)
