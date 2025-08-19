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

