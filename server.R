
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(WhatIf)
data("peacecf")
data("peacef")
names(peacecf)[8] <- "untype4"
myData <- rbind(peacecf, peacef)
set.seed(1234)
myData <- myData[sample(nrow(myData)),]


# function for converting percentage nearby value into color
# color ranges from red through yellow to green.
# nearby is the value representing a decent data nearby percentage
source("utils.R")




shinyServer(function(input, output) {
  ##Values <- reactiveValues( x = whatif(data = peacef, cfact = peacecf[1:input$cfacts,]))
  output$distPlot <- renderPlot({
    x <- whatif(data = peacef, cfact = myData[1:input$cfacts,])
    makeGraphic(x)
  })
  
  output$linePlot <- renderPlot({
    x <- whatif(data = peacef, cfact = myData[1:input$cfacts,])
    plot(x)})

})
