library(pacman)
pacman::p_load(tidyverse, sf, mapview, rvest, httr, gtsummary, ggplot2, viridis, tidyr, knitr, stringr, gt)

here::i_am("code/02_make_map.R")

dengue_cases <- st_read("data/Simulated_Dengue_Data.shp")
states <- st_read(here::here("data/mex_admbnda_adm1_govmex_20210618.shp"))

dengue_cases$serotype <- as.factor(dengue_cases$serotype)


# Create the plot with serotype differentiation
map <- ggplot() +
  geom_sf(data = states, fill = "lightblue", color = "black") +  # Plot the states
  geom_sf(data = dengue_cases, aes(color = serotype), size = 2) +      # Map color to serotype
  scale_color_viridis_d(option = "D") +                          # Use a color palette for factors
  theme_minimal() +
  labs(title = "2023 Dengue Cases by Serotype",
       x = "Longitude",
       y = "Latitude",
       color = "Serotype")  # Legend title

ggsave("output/map.png")
