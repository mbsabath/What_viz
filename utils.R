## utils.R
## Helper Functions for the Shiny App

library(reshape2)
library(ggplot2)
library(gridExtra)

getColor <- function(val, nearby = 0.1) {
  if (val < nearby) {
    return(rgb(1,val/nearby,0))
  } else if (val >= nearby && val < (2*nearby)) {
    return(rgb(1-((val-nearby)/nearby),1,0))
  } else {
    return(rgb(0,1,0))
  }
}

makeRectangles <- function(x) {
  row_length <- round(sqrt(length(x)))
  step <- 1/(row_length + 1)
  xleft <- 0
  xright <- step/2
  ylow <- 0
  ytop <- step
  for (i in 1:length(x)) {
    rect(xleft,ylow,xright,ytop, col = getColor(x[i], nearby = 0.025), border = 0)
    if (i %% row_length == 0) {
      xleft <- xleft + step/2
      xright <- xright + step/2
      ylow <- 0
      ytop <- step
    } else {
      ylow <- ylow + step
      ytop <- ytop + step
    }
  }
}


## Code to generate heatmap from whatif data
WhatifHeatMap <- function(what_out) {
  data.m <- melt(what_out$cum.freq)
  out <- ggplot(data.m, aes(Var2,Var1))
  out <- out + geom_tile(aes(fill = value))
  out <- out + scale_fill_gradient(low = "black", high = "green")
  out <- out + ggtitle("Heatmap of Cumulative\nFrequencies")
  out <- out + ylab("Counterfactuals")
  out <- out + xlab("Gower Distance")
  return(out)
}

inHullMap <- function(what_out) {
  data <- data.frame(1:length(what_out$in.hull))
  data$in.hull <- what_out$in.hull
  data$hull <- ""
  names(data) <- c("cfact", "in.hull", "hull")
  data$type[data$in.hull] <- "Interpolation" 
  data$type[!data$in.hull] <- "Extrapolation" 
  out <- ggplot(data = data, aes(hull, cfact))
  out <- out + geom_tile(aes(fill = type))
  out <- out + scale_fill_manual(name = "Counterfactual\nType",
                                 values = c("Extrapolation" = "red", 
                                            "Interpolation" = "steelblue"))
  out <- out + xlab("")
  out <- out + ylab("Counterfactual")
  out <- out + ggtitle("Type of Model\nDependence")

  
  return(out)
  
}

makeGraphic <- function(what_out) {
  heatmap <- WhatifHeatMap(what_out)
  inHull <- inHullMap(what_out)
  grid.arrange(heatmap, inHull, ncol = 2)
  
}