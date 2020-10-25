library(tidyverse)
theme_set(theme_bw(base_family = "Roboto"))

s1 <- read_csv("2020-6/entomo/data/S1-page-1-table-1.csv", na = "-")

s2 <- read_csv("2020-6/entomo/data/S2-page-1-table-1.csv", na = "-")

s3 <- read_csv("2020-6/entomo/data/S3-page-1-table-1.csv", na = "-")

areas_reshaped <- s2 %>%
  select(Species, Total, str_subset(names(s2), "%")) %>%
  pivot_longer(-c(Species, Total), names_to = "area", values_to = "perc") %>%
  mutate(area = str_remove(area, " area %"),
         perc = replace_na(perc, 0))

baits_reshaped <- s3 %>% 
  select(Species, Total, str_subset(names(s3), "%")) %>%
  pivot_longer(-c(Species, Total), names_to = "bait", values_to = "perc") %>%
  mutate(bait = str_remove(bait, " %"),
         perc = replace_na(perc, 0))
  

areas_reshaped %>% 
  top_n(n = 10, wt = Total) %>%
  mutate(perc = perc / 100) %>% 
  ggplot(aes(x = area, y = Species, fill = perc)) +
  # scale_x_continuous(labels = scales::percent) +
  geom_tile() +
  geom_text(aes(label = paste0((perc * 100), "%"))) +
  theme_minimal(base_family = "Roboto") +
  scale_fill_distiller(palette = "Reds", labels = scales::percent) +
  guides(fill = FALSE) +
  labs(y = NULL, x = NULL, fill = NULL)

baits_reshaped %>% 
  filter(perc != 0) %>% 
  top_n(n = 10, wt = Total) %>%
  mutate(perc = perc / 100) %>% 
  ggplot(aes(x = bait, y = Species, fill = perc)) +
  # scale_x_continuous(labels = scales::percent) +
  geom_tile() +
  geom_text(aes(label = paste0((perc * 100), "%"))) +
  theme_minimal(base_family = "Roboto") +
  scale_fill_distiller(palette = "Purples", labels = scales::percent) +
  guides(fill = FALSE) +
  labs(y = NULL, x = NULL, fill = NULL)
