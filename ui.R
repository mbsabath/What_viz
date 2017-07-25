
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Whatif Visualization Prototype"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("cfacts",
                  "Number of Counterfactuals:",
                  min = 1,
                  max = 246,
                  value = 30)
    ),
    

    # Show a plot of the generated distribution
    tabsetPanel(
      tabPanel("Heatmap", fluidRow(
        plotOutput("distPlot")
        )),
      tabPanel("Line Graph", fluidRow(
        plotOutput("linePlot")
      ))
    )
  )
))
