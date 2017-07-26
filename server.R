
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#



# function for converting percentage nearby value into color
# color ranges from red through yellow to green.
# nearby is the value representing a decent data nearby percentage
source("utils.R")




shinyServer(function(input, output) {
  
  output$ui <- renderUI({
    lapply(1:input$cfacts, function(j) {
      column(3,
             lapply(1:length(peacef), function(i){
               numericInput(paste0(LETTERS[j],"var",i), names(peacef)[i], 
                            median(peacef[,i], na.rm = T))
             }))
    })
  })
  
  counterfacts <- reactive({
    cfacts <- input$cfacts
    out <- vector()
    for (j in 1:length(peacef)) {
      for (i in 1:cfacts) {
        out <- c(out, input[[paste0(LETTERS[i],"var",j)]])
      }
    }
   matrix(out, nrow = cfacts)
    ##names(out) <- names(peacef)
  })
  
  x <- reactive({
    whatif(data = peacef, cfact = counterfacts())
  })
  
  output$cfact <- renderTable({counterfacts()})
  
  output$distPlot <- renderPlot({
    makeGraphic(x())
  })
  
  output$linePlot <- renderPlot({
    plot(x())})

})
