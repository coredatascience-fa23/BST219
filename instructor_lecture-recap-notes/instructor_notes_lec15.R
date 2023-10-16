#### Recap last lec  ####

# Data viz principles 
# 1. **type of charts**

# 2. **starting from zero or not**

# 3. **do not distort values**

# 4. **order by a meaningful value**

# 5. **think of color blind**

# 6. **3-d information**
library(ggplot2)
df <- data.frame(
  x = factor(rep(1:10, each = 10)),
  y = factor(rep(1:10, 10)),
  z = runif(100)
)

df %>% ggplot(aes(x = x, y = y)) + 
  geom_tile(aes(fill = z)) + 
  theme_minimal() + 
  scale_fill_gradient(low = "white", high = "steelblue")


library(corrplot)
data(mtcars)
M = cor(mtcars)
corrplot(M)


# 7. **know your audience**

# Today's lecture
# 1. maps
# 2. no lab this week
# 3. HW2 released 9/25; due in Oct 22. 
# 4. mid term in end October/early November
# 5. final project: form a team of 3-5; fill out a proeject preference form (released next week)
