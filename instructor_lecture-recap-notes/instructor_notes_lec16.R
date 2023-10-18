#### Recap last lec  ####

# Maps 
library(maps)
# 1. **Case Study: Georgia Counties COVID-19 Cases**
# map data 
GeorgiaCounty <- map_data("county", "georgia")
head(GeorgiaCounty)
# covid cases data
url <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
cases <- read_csv(url)
head(cases)
dates <- c(ymd("2020-07-02", "2020-07-17"))
georgia_cases <- cases %>% filter(state == "Georgia", date %in% dates)
dim(georgia_cases)
# population data 
pop_data <- read_csv("/Users/dongdongli/Desktop/BST219/03_data_visualization/county_pop.csv")
dim(pop_data)
pop_data <- pop_data %>% dplyr::select(county_name, population)
# merge/join the data
data_full <- left_join(georgia_cases, pop_data, by = c("county" = "county_name"))
dim(data_full)
head(data_full)
# now we're reday to calculate the rate
data_full <- data_full %>% mutate(rate = 100000*(cases/population))
head(data_full)
# merge /join with the map data
georgia_map <- data_full %>% mutate(county = str_to_lower(county)) %>%
  left_join(GeorgiaCounty, by = c("county" = "subregion"))

dim(georgia_map)
head(georgia_map)

# data cleaning (remove spaces in the county name for both Georgia county and data_full)
GeorgiaCounty <- GeorgiaCounty %>%
  mutate(subregion = str_replace(subregion, " ", ""))

georgia_map <- data_full %>% mutate(county = str_to_lower(county)) %>%
  left_join(GeorgiaCounty, by = c("county" = "subregion"))

head(georgia_map)

data_full <- data_full %>%
  mutate(county = str_replace(county, " ", ""))

georgia_map <- data_full %>% mutate(county = str_to_lower(county)) %>%
  left_join(GeorgiaCounty, by = c("county" = "subregion"))


# plot
# create labels/categories for legend
library(ggrepel)
georgia_map <- georgia_map %>% 
  mutate(manual_fill = cut(rate, breaks = c(0, 620, 1070, 1622, 2960, Inf),
                           labels = c("1-620", "621-1,070", "1,071-1,622", 
                                      "1,623-2,960", ">2,960"),
                           right = TRUE))
head(georgia_map)
# specify desired colors for legend / categories
pal <- c("lightskyblue2", "steelblue2", "dodgerblue3", "dodgerblue4", "red")



july_2_labels <- georgia_map %>%
  filter(date == "2020-07-02", rate > 2960) %>%
  group_by(county) %>%
  summarize(lat = mean(lat),
            long = mean(long))

july_17_labels <- georgia_map %>%
  filter(date == "2020-07-17", rate > 2960) %>%
  group_by(county) %>%
  summarize(lat = mean(lat),
            long = mean(long))


p1 <- georgia_map %>% filter(date == "2020-07-02") %>%
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(fill = manual_fill, group = group), color = "black")  +
  scale_fill_manual(values = pal) +
  coord_fixed(1.3) +
  geom_text_repel(data = july_2_labels, aes(long, lat, label = county), color = "orange") +
  theme(legend.position = "none",
        panel.grid.major = element_blank(), 
        panel.background = element_blank(),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  ggtitle("July 2, 2020")

p2 <- georgia_map %>% filter(date == "2020-07-17") %>%
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(fill = manual_fill, group = group), color = "black")  +
  scale_fill_manual(name = "Cases per 100,000", values = pal) +
  coord_fixed(1.3) +
  geom_text_repel(data = july_17_labels, aes(long, lat, label = county), color = "orange") +
  theme(panel.grid.major = element_blank(), 
        panel.background = element_blank(),
        axis.title = element_blank(), 
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  ggtitle("July 17, 2020")

library(egg)
ggarrange(p1, p2, nrow = 1)


library(patchwork)
p1 + p2

# 2. **tidy data**
library(dslabs)
library(tidyverse)
data("gapminder")
tidy_data <- gapminder %>% 
  filter(country %in% c("South Korea", "Germany")) %>%
  dplyr::select(country, year, fertility)
head(tidy_data)
tidy_data %>% ggplot(aes(year, fertility, color = country)) +
  geom_point() # cleaned data in a tidy format for ggplot

filename <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/fertility-two-countries-example.csv"
wide_data <- read_csv(filename)
wide_data %>% head()
wide_data %>% View() # wide data in the original format 



# HW2
# 1. **Q1: rate calculation**
# 2. **Q5: "across states"** plot for each year of all states
# 3. **Q6** 
# 4. **Q8** use load("") to load the rDATA dataset
# 5. **Q9** there are other diseases in the dataframe `us_contagious_disease`

# Today's lecture
# 1. advanced data wrangling
# 2. no lab this week; lab next week Oct 27 to practice on advanced data wrangling
# 3. HW2 released 9/25; due in Oct 22 (+ 2 late days)
# 4. HW3 to be released this Thursday / Friday, due Nov 5th (helpful to prepare for midterm)
# 4. mid term in early/mid November
# 5. final project: form a team of 3-5; fill out a project preference form (to be released later this week)
