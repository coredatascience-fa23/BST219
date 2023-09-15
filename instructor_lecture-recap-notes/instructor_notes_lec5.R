#### Recap last week ####

# Atomic data types
# 1. **Numeric**: Decimal numbers like `5.5`, `2.9`.
a <- 5.5
b <- 2
class(a)
class(b)
str(a)
str(b)

# 2. **Integer**: Whole numbers like `2L`, `10L`. The `L` indicates it's an integer.
a <- 5L
b <- 2L
class(a)
class(b)

a <- 5
class(a)
a_int <- as.integer(a)
class(a_int)

# 3. **Logical**: Boolean values, `TRUE` or `FALSE`.
a <- 3==5
a
class(a)
b <- 4 < 5
b
class(b)
c <- is.na(3)
c
class(c)

class(NA)

# 4. **Character**: Strings like `"hello"`, `"world"`.
a <- "hello"
class(a)

b <- "NA"
class(b)

c <- "3"; class(c)


# 5. conversion / coercion
a_num <- as.numeric(a)
a_num
b_num <- as.numeric(b)
b_num
b_log <- as.logical(b)
b_log
c_num <- as.numeric(c)
c_num
c_int <- as.integer(c)
c_int

class(NA)

d <- c(NA, 2, 3)
d 
class(d) #coercion


# Data structure
# 1. **Vector**: A one-dimensional array of the same type of elements. 
a <- c(1.5, 2.5, 3.5); class(a)

# 2. **Data Frame**: A two-dimensional table where each column can have a different type.
library(dslabs); data(murders)
class(murders) 
str(murders)
head(murders)

# 3. **List**: A collection of elements that can be of different types and structures
a <- list(a1 = 1:3, a2="f", a3=c(TRUE, FALSE))
class(a)
a
a$a1
a[[1]]


# 4. **Factor**: Used to store categorical data and can be ordered or unordered. 
murders$region

# Others
# 1. **NA**: Represents missing data.
a <- NA
class(a)

a <- NA_integer_
a
class(a)

a <- NA_character_
a
class(a)

# 2. **NaN**: Stands for "Not a Number". Used to represent the result of undefined mathematical operations.
result <- sqrt(-1)
result
result <- 0/0
result

# 3.**Inf**: Represents infinity.
a <- Inf
a
class(a)
length(a)
# 4. **NULL**: Represents the absence of value or undefined.
a <- NULL
class(a)
length(a)


# Vectors
# 1. Creation: c(); seq() or shorthand; rep(); random generators (optional)
numeric_vector <- c(1, 2, 3, 4, 5)
character_vector <- c("a", "b", "c")
logical_vector <- c(TRUE, FALSE, TRUE)

seq_vector <- seq(from = 1, to = 10, by = 2)
1:10

rep_vector <- rep(1, 5)

rnorm(5)

# 2. Subsetting: positional indexing; conditional indexing 
x <- c(10, 20, 30, 40, 50)
# positional indexing
first_elem <- x[1]
first_elem
some_elems <- x[c(1, 3)]
some_elems

# conditional indexing (will look at more later today)
x > 20
condition <- x > 20 #create a condition
condition
subset_x <- x[condition] #subset using logical vector

subset_x <- x[x > 20] #alternatively, You can directly use conditional statements within the square brackets to subset vectors.
subset_x

# Today's lecture
# 1. sorting: sort(), order(), rank()
# 2. vector arithmetic: element-wise operation, two vectors operation
# 3. more on indexing: subsetting with conditions/logicals, 
# 4. intro: traditional ways vs. modern ways of data wrangling 


