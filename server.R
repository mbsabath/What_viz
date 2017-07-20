
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
val2col <- function(val, nearby = 0.1) {
  if (val < nearby) {
    return(rgb(1,val/nearby,0))
  } else if (val >= nearby && val < (2*nearby)) {
    return(rgb(1-((val-nearby)/nearby),1,0))
  } else {
    return(rgb(0,1,0))
  }
}

makeRectangles <- function(x) {
  row_length <- floor(sqrt(length(x)))
  step <- 1/(row_length + 1)
  xleft <- 0
  xright <- step
  ylow <- 0
  ytop <- step
  for (i in 1:length(x)) {
    rect(xleft,ylow,xright,ytop, col = val2col(x[i]))
    if (i %% row_length == 0) {
      xleft <- xleft + step
      xright <- xright + step
      ylow <- 0
      ytop <- step
    } else {
      ylow <- ylow + step
      ytop <- ytop + step
    }
  }
}




shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    x <- whatif(data = peacef, cfact = peacef[1:input$cfacts,])
    # generate bins based on input$bins from ui.R
    plot.new()
    makeRectangles(x$sum.stat)
  })

})
