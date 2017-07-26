
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source('setup.R')

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Whatif Visualization Prototype"),
  # Show a plot of the generated distribution
  tabsetPanel(
    tabPanel("Counterfactual", fluidRow(
      tableOutput("cfact")
    )),
    tabPanel("Heatmap", fluidRow(
      plotOutput("distPlot")
    )),
    tabPanel("Line Graph", fluidRow(
      plotOutput("linePlot")
    ))
  ),
  fluidRow(
    sliderInput("cfacts", "Number of Counterfactuals",
                min = 1, max = 4, value = 1)
  ),
  fluidRow(
    uiOutput("ui")
  )

  # Sidebar with a slider input for number of bins
  
  # sidebarLayout(
  #   sidebarPanel(
  #     sliderInput("cfacts",
  #                 "Number of Counterfactuals:",
  #                 min = 1,
  #                 max = 246,
  #                 value = 10)
  #   ),
    


  )
)
