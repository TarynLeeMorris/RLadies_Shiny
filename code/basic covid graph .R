# Taryn Morris
# Ixio Analytics
# 16 April 2020
# R-Ladies - Intro to shiny



# package for covid-19 data ... 
#https://www.r-bloggers.com/meet-tidycovid19-yet-another-covid-19-related-r-package/

# Install tidycovid package
#remotes::install_github("joachim-gassen/tidycovid19")

#load libraries
suppressPackageStartupMessages({
  library(tidycovid19)
  library(dplyr)
  library(ggplot2)  
  library(ggrepel)
  library(plotly)
})


#pull data
data <- download_jhu_csse_covid19_data()

saveRDS(data, "data.rds")

data

ggplotly(
  ggplot(data %>% filter(country == c("South Africa")), aes(x = date, y = confirmed, colour = country))+
    geom_line() +
    geom_point() +
    ylab("Confirmed") +
    theme_classic()
    )
  