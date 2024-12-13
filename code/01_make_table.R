install.packages("pacman")
library(pacman)
pacman::p_load(here, sf, gt, gtsummary, tidyverse)
#pacman::p_load(tidyverse, sf, mapview, rvest, httr, gtsummary, ggplot2, viridis, tidyr, knitr, stringr, gt, webshot2)

here::i_am("code/01_make_table.R")

states <- st_read(here::here("data/mex_admbnda_adm1_govmex_20210618.shp"))

dengue_cases <- st_read(here::here("data/Simulated_Dengue_Data.shp"))

joined_data <- st_join(states, dengue_cases, join = st_intersects)

df <- st_drop_geometry(joined_data)

df <- df %>%
  select(ADM1_ES, serotype)

colnames(df) <- c("State","Serotype")

summary_table_2 <- df %>%
  tbl_summary(by=Serotype, percent = "row") %>%
  modify_spanning_header(all_stat_cols() ~ "Serotype")

summary_table_2 %>%
  as_gt() %>%
  gt::gtsave("output/Serotype_breakdown.png")



