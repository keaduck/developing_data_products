# Developing Data Products
# Week 4 project
# Shiny App: Prius Explorer
# Kea Duckenfield
# 30 May 2018

# Load libraries

library(shiny)
library(ggplot2)

# Load data
prius_data <- read.csv("data/prius_data.csv")

# ui section of the shiny app

ui <- fluidPage(
  h1("Exploring Prius fuel efficiency"),
  h2("What factors might be involved?"),
  h4("In my family, there was an idea that the color of the dashboard display affected the fuel efficiency of our 2004 Prius 2. Other ideas were that the driver and time of year matters. We even wondered whether the amount of fuel used between fill-ups could make a difference. What do you think?"),
  h5("Note that you can plot the independent variables against each other to look for covariation between them!"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("MPG", "MPG displayed" = "display.MPG", "Mileage", "Month", "Dashboard display color" = "Color", "Gallons added on fill-up" = "gallons", "Driver" = "filler"),
                  selected = "MPG"), 
      selectInput(inputId = "x", 
                  label = "X-axis:", 
                  choices = c("Mileage", "Month", "Dashboard display color" = "Color", "Gallons added on fill-up" = "gallons", "Driver" = "filler", "MPG displayed" = "display.MPG"), 
                  selected = "Color")
      ), 
      mainPanel(
        plotOutput(outputId = "scatterplot"),
        textOutput("selected_var"))))

# server section of the shiny app

server <- function(input, output) {
  output$scatterplot <- renderPlot({
    ggplot(data = prius_data, aes_string(x = input$x, y = input$y)) + 
      geom_point()
  })
  output$selected_var <- renderText({
    paste(input$y, " as a function of ", input$x)
  })
  }

# Run the application 
shinyApp(ui = ui, server = server)

