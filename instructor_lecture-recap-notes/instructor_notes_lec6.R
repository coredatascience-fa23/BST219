#### Recap last week ####

# Sorting Vectors

# 1. **sort()**: Sorts a vector in ascending or descending order.
x <- c(3, 1, 4, 1, 5, 9, 2, 6, 5)
sorted_x <- sort(x)  # Sorts in ascending order
sorted_x_desc <- sort(x, decreasing = TRUE)  # Sorts in descending order

x <- c(3, NA, 1, 4, 5, 6)
sorted_x <- sort(x, na.last = T) # specifies where NA values should be placed

# 2. **order()**: The order() function in R is often used for sorting, 
# but it doesn't directly sort the vector. 
# Instead, it returns the indices that would sort the vector. 
# You can then use these indices to rearrange the vector 
# (or other data structures like data frames and matrices) in a sorted manner.
x <- c(3, 1, 4, 1, 5, 9, 2, 6, 5)
index <- order(x)
sorted_x <- x[index]


# 3. **rank()**: The rank() function in R provides the ranks of the elements in a vector, 
# with the smallest element being assigned the rank of 1. 
# It doesn't sort the vector, but it gives you an idea of the relative positions of the elements 
# if they were to be sorted. 
# The function is particularly useful for statistical analyses where you need to know 
# the rank of each element within a dataset.

x <- c(3, 1, 4, 1, 5, 9, 2, 6, 5)
ranks <- rank(x)

ranks <- rank(x, ties.method = "min") #handling ties
# ties.method: Specifies how to deal with tied values. Options include:
# "average": (default) The average rank of the tied values.
# "first": Ranks are assigned in the order they appear in the data.
# "last": Opposite of "first".
# "random": Randomly assigned ranks among tied values.
# "max": The maximum rank among the tied values.
# "min": The minimum rank among the tied values.




# Vector Arithmetic 

# 1. **Scalar Operations**: You can also perform arithmetic operations with a scalar (single number) and a vector. 
# The scalar is applied to each element of the vector. 
a <- c(1, 2, 3)
b <- c(4, 5, 6)

result <- a + 1  # c(2, 3, 4)
result <- a * 2  # c(2, 4, 6)


# 2. **Common Arithmetic Operations**: Addition, Subtraction, Multiplication, Division
# Exponentiation
# Logical operations
a <- c(1, 2, 3)
b <- c(4, 5, 6)

a + b
a - b 
a * b
a / b

a ^ b

a <- c(TRUE, FALSE, TRUE)
b <- c(FALSE, FALSE, TRUE)

result_and <- a & b  # c(FALSE, FALSE, TRUE)
result_or <- a | b  # c(TRUE, FALSE, TRUE)
result_not <- !a  # c(FALSE, TRUE, FALSE)



# Vector Indexing

# 1. Positional indexing: use numeric indeices to subset elements
x <- c(1, 2, 3, 4, 5)
x[2]  # Returns 2


# 2. Logical indexing: Use a logical vector to subset elements.
x > 2
x[x  > 2]

# 3. Negative Indexing: Use negative indices to exclude elements.
x[-2] 

# Today's lecture
# 0. Finish up 06-indexing: which(), match(), %in% 
# 1. Indexing Assessments
# 2. Basic data wrangling using dplyr
# 3. (if time permits; otherwise in labs) Labs and Homeworks: pull(download); commit+push (upload)



