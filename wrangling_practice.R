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
