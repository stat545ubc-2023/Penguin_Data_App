#Load packages for app
library(shiny)
library(palmerpenguins)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(DT)
library(shinythemes)

# Change names of colunms 
rad_opt <- c("Flipper Length (mm)" = "flipper_length_mm", "Bill Length (mm)" = "bill_length_mm", "Body Mass (g)" = "body_mass_g")

#Define UI
ui <- fluidPage(theme = shinytheme("sandstone"),
  titlePanel("Penguin Data Set Adventure"),
  
  sidebarLayout(position = "right",
                sidebarPanel(
  # Feature 1. I added a drop down input selection, this is useful as it allows the user to select a species they would like to see in table or graph.
                  selectInput("speciesInput", "Select Penguin Species:",
                              choices = unique(penguins$species)),
  # Feature 2. I added radio button selection, this is useful as it allows the user to select from three different size related variables to visualize in graphs.
                  radioButtons("boxplotVariable",
                               "Select Size Variable:",
                               choices = (rad_opt),
                               selected = "flipper_length_mm"),
  # Feature 3. I added radio button selection based on year, this is helpful as it allows the user to view data collected in a specified year.
                  radioButtons("yearButtons",
                               "Choose a year:",
                               choices = unique(penguins$year)),
                  width = 3
                ),
                mainPanel(
                  tabsetPanel(
                    tabPanel("Table",h3("Penguin Data Table"), p("The data table below can be sorted by using the penguin species options and the year options in the right panel. Futher search options inlcude the tables top right hand search bar, and the drop down menu allowing for selection of the number of data entries you would like to see. Arrows beside the colunm names allow for reordering of the selected data."), DTOutput("table")),
                    tabPanel("Plot", h3 ("Bill Size Scatterplot"), p("This scatterplot can be used to explore the bill size of penguins. Search by penguin species in the right hand drop down panel or by year using the panels radio buttons."), plotOutput("scatterPlot")),
                    tabPanel("Histogram", h3("Bill Depth Histogram"), p("The histogram graph below is compatible with the penguin species dropdown menu, located at the top of the right panel. Select a penguin species and observe differnce in the frequency of different bill depths. This Histogram is also compatible with year choice radio buttons, if you would like to see how the penguins bill depths changed over years sampled (how Darwininan!)"), plotOutput("histogram")),
                    tabPanel("Boxplot", h3("Size Variable Boxplot"), p("The boxplot below shows size variable distributions each of the three islands - Dream, Biscoe and Torgerson. Choose a size variable from the right hand panel along with a year to explore."), plotOutput("boxplot"))
                  ),
                  width = 9
                )
  )
)

# Define Server
server <- function(input, output) {
  filtered_data <- reactive({
    filter(penguins, 
           species == input$speciesInput,
           year == as.integer(input$yearButtons))
  })
  
  filtered_data2 <- reactive({
    filter(penguins, year == as.integer(input$yearButtons))
  })
  
# Table
  output$table <- renderDT({
    datatable(filtered_data())
  })
  
# Scatterplot
  output$scatterPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = bill_length_mm, y = bill_depth_mm, color = sex)) +
      geom_point(size = 3) +
      ggtitle("Bill Size by Pengiun species") +
      xlab("Bill Length (mm)") +
      ylab("Bill Depth (mm)") +
      scale_colour_manual(values = c("male" = "mediumseagreen", "female" = "lightpink1"))
  })
  
# Histogram
  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes(x = bill_depth_mm, fill = species, colour = species)) +
      geom_histogram(binwidth = 1, position = "identity", alpha = 0.5) +
      ggtitle("Distribution Pengiun Bill Depth") +
      xlab("Bill Depth (mm)") +
      ylab("Frequency") + 
      scale_fill_manual(values = c("Adelie" = "yellow", "Gentoo" = "blue", "Chinstrap" = "green"))
  })
  
# Boxplot
  output$boxplot <- renderPlot({
    ggplot(filtered_data2(), aes(x = island, y = .data[[input$boxplotVariable]], fill = island)) +
      geom_boxplot(alpha = 0.3) +
      scale_fill_brewer(palette = "Dark2") +
      ggtitle("Penguin Size Variables by Island") +
      xlab("Island") +
      ylab(names(rad_opt[rad_opt==input$boxplotVariable]))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
