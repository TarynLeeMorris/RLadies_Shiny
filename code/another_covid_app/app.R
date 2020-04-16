# Taryn Morris
# Ixio Analytics
# 16 April 2020
# R-Ladies - Intro to shiny


# Load libraries
library(shiny)
library(shinyWidgets)
library(tidycovid19)
library(dplyr)
library(ggplot2)  
library(ggrepel)
library(plotly)
library(tidyverse)


#import data
data <-  readRDS("data.rds")



# Define UI for application that draws a graph
ui <- fluidPage(

    # Application title
    titlePanel("Covid-19 cumulative trends"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            pickerInput(inputId = "countries", 
                        label = "Select desired countries", 
                        choices = unique(data$country),
                        selected = "South Africa",
                        multiple = TRUE),
            
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("covidTrend")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
# Covid graph  ---------------------------------------------    
output$covidTrend <- renderPlotly({

    ggplotly(
        ggplot(data %>% filter(country == input$countries), aes(x = date, y = confirmed, colour = country))+
                geom_line() +
                geom_point() +
                ylab("Confirmed") +
                theme_classic()
        )
})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
