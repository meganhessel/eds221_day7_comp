#clearning evnironment 
rm(list = ls)

# attach packages
library(tidyverse)
library(palmerpenguins)
library(lubridate) #help us work with dates

view(penguins)

# data wrangling refresher 
penguins %>% 
  filter(island == c("Briscoe", "Dream")) %>% 
  select(-c(year, sex)) %>% 
  mutate(body_mass_kg = body_mass_g / 1000) %>% 
  rename(location = island)

penguins %>% 
  filter(species == "Adelie") %>% 
  tidyr::drop_na(flipper_length_mm) %>% 
  tidyr::drop_na(sex) %>% 
  group_by(sex) %>% 
  summarise(mean_flip_len = mean(flipper_length_mm), 
            st_dev_flip_len = sd(flipper_length_mm), 
            ss_flip_len = n()
            )

animals <- data.frame(
  stringsAsFactors = FALSE,
   location = c("lagoon", "bluff", "creek", "oaks", "bluff"),
  species = c("bobcat", "coyote", "fox", "squirrel", "bobcat"),
  maturity = c("adult", "juvenile", "adult", "juvenile", "adult"))

sites <- data.frame(
  stringsAsFactors = FALSE,
          location = c("beach", "lagoon", "bluff", "oaks"),
    full_site_name = c("Goleta Beach","UCSB Lagoon",
                       "Ellwood Mesa","Fremont Campground"),
      jurisdiction = c("SB City", "UCSB", "SB City", "USFS")
)

# full_join 
full_join(animals, sites) # keeps all rows and adds all columns 

# left_join 
left_join(animals, sites)

# right join 
right_join(animals, sites)

# Inner_join 
inner_join(animals, sites)

# semi_join 
semi_join(animals, sites)
animals %>% 
  filter(location %in% sites$location)

# anti_join 
anti_join(animals, sites)
animals %in% 
  filter(!location %in% sites$location)


# preatice with lubridate 
my_date <- "03-13-1998"
lubridate::mdy(my_date)

my_date <- "08-Jun-1974"
lubridate::dmy(my_date)

my_date <- "19160518"
lubridate::ymd(my_date)

my_date <- "02/17/2003"
lubridate::mdy(my_date)

#working with date times 
time <- "2020-08-12 11:18"
time <- ymd_hm(time)

with_tz(time, "America/Los Angeles")
week(time)
day(time)
year(time)

# practice libridate within a data frame 

urchin_counts <- tribble(
  ~date, ~species, ~size_mm,
  "10/3/2020", "purple", 55,
  "10/4/2020", "red", 48,
  "11/17/2020", "red", 67
)

urchin_counts %>% 
  mutate(date = lubridate::mdy(date)) %>% 
  mutate(year = year(date), 
         month = month(date), 
         day = day(date))

day_1 <- lubridate::ymd("2020-01-06")
day_2 <- ymd("2020-05-18")
day_3 <- ymd("2020-05-19")

#create time interval 
time_interval <- interval(day_1, day_2)
time_length(time_interval, "week")
time_length(time_interval, "year")


# str_datect() 
# returns true or false depedning on whether the pattern is detected 
my_string <- "Teddy loves eating salmon and socks"

# does the pattern "love" exist in the string 
my_string %>% 
  str_detect("love")

my_string %>%  
  str_detect("pup")

my_string <- c("burrito", "fish taco", "taco salad")

# does the vector elements contain the pattern "fish"
my_string %>% 
  str_detect("fish")

# powerful when combined with dplyr fucntions

starwars %>% 
  filter(str_detect(name, "Skwalker"))

firewalks <- starwars %>% 
  mutate(name = str_replace(name, pattern = "skwalker", replacement = ""))

#cleaning up white space 
feedback <- c(" I ate   some   nachos", "Wednesday morning    ")

#remove the leading, trailing, and duplicating spaces 
str_squish(feedback)

str_trim(feedback)

str_to_lower(feedback)
str_to_title(feedback)
str_to_sentence(feedback)
