## setup.R

library(shiny)
library(WhatIf)
data("peacecf")
data("peacef")
names(peacecf)[8] <- "untype4"
myData <- rbind(peacecf, peacef)
set.seed(1234)
myData <- myData[sample(nrow(myData)),]
cfact <- matrix(c(3,1,12,79,3,13,58,0,0,541,0), ncol = 11)