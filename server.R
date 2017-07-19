
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(WhatIf)
data("peacecf")
data("peacef")

val2col <- function(val) {
  if (val < 0.1) {
    return(rgb(1,val/0.1,0))
  } else if (val >= 0.1 && val < 0.2) {
    return(rgb(1-((val-0.1)/0.1),1,0))
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
