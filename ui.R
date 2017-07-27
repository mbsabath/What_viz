
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
    tabPanel("Heatmap", fluidRow(
      plotOutput("distPlot")
    )),
    tabPanel("Line Graph", fluidRow(
      plotOutput("linePlot")
    )),
    tabPanel("Upload Data",fluidRow(
      sidebarPanel(
        fileInput("data",label = "Upload Data", accept = ".RDS"),
        "Upload an R data frame to use as the factual data with whatif. The data
        should be saved using the saveRDS() function. If no data is uploaded, this
        visualization will be based off the peacef data included in the whatif package."
      )
    )
             ),
    tabPanel("Counterfactual", fluidRow(
      tableOutput("cfact")
    ))
  ),
  hr(),
  fluidRow(
    sidebarPanel(
    radioButtons("cfactType",label = "Counterfactual Input",
                 choices = list("Upload Dataframe" = T, "Manual Entry" = F),
                 selected = T),
    actionButton("update", "Update Graph"))
  ),
    uiOutput("slider")
  ,
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
