#### Recap last week ####

  
# Vector Indexing (cont'd)
  
# 1. **which()**: Returns the indices of the elements that satisfy a given condition.
x <- c(1, 2, 3, 4, 5)
indices <- which(x > 3)
# indices will contain 4, 5


# 2. **match()**: Finds the positions of the first occurrences of elements in one vector within another vector.
x <- c("a", "b", "c")
y <- c("b", "c", "d")
matched_indices <- match(y, x)
# matched_indices will contain 2, 3, NA


# 3. **%in%**: Checks if elements of one vector are present in another vector and returns a logical vector.
x <- c("a", "b", "c")
y <- c("b", "c", "d")
result <- y %in% x
# result will contain TRUE, TRUE, FALSE



  
# Basic Data Wrangling with dplyr
  
# 1. **mutate()**: to change columns (add, revise existing ones)
library(dplyr)
data <- data.frame(x = 1:5)
data_with_doublex <- data %>% mutate(y = x * 2)


# 2. **filter()**: to filter out rows
data <- data.frame(x = 1:5)
filtered_data <- data %>% filter(x > 2)


# 3. **select()**: to select columns
data <- data.frame(x = 1:5, y = 6:10)
selected_data <- data %>% select(x)
# to deselect use -x
selected_data <- data %>% select(-x)

# 4. **pipe operator %>%**: to make code more efficient, we'll use it throughout the course and you'll get used to it.
data %>% filter(x > 2) %>% select(x)


# 5. **summarize()** (or summarise()) and group with summarize()
data <- data.frame(x = c(1, 1, 2, 2), y = c(1, 2, 3, 4))
summary_data <- data %>% group_by(x) %>% summarize(mean_y = mean(y))


# 6. **arrange()**: to sort data frame based on one or more columns
# descending order with desc()
# top_n()
data <- data.frame(x = 5:1, y = 1:5)
sorted_data <- data %>% arrange(desc(x))
top_data <- data %>% top_n(3, x)


# 7. **using dot to access the piped data**
data %>% filter(x > 2) %>% mutate(z = x * 2) %>% .$z


# 8. **data.frame()**: to create a data frame: data.frame(col1 = c(), col2 = c(), ...) fill in columns 
# think of it as combining a bunch of columns, or vectors, of the same length
data <- data.frame(col1 = c(1, 2, 3), col2 = c("a", "b", "c"))



  
# Today's lecture
# 1. Basic plots
# 2. Importing data
# 3. Programming basics (conditional expression, and if time permits, for-loops and functions)

