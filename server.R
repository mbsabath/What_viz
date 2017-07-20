
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(WhatIf)
data("peacecf")
data("peacef")


# function for converting percentage nearby value into color
# color ranges from red through yellow to green.
# nearby is the value representing a decent data nearby percentage
source("utils.R")
source("setup.R")



shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    x <- whatif(data = peacef, cfact = peacecf[1:input$cfacts,])
    # generate bins based on input$bins from ui.R
    plot.new()
    makeRectangles(x$sum.stat)
  })
  
  ##output$text <- renderText({summary(x)})

})
