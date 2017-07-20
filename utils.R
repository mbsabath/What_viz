## utils.R
## Helper Functions for the Shiny App

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
