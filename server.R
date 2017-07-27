
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
  
  ## Generate Custom Counterfactual Fields
  output$slider <- renderUI({
    if (input$cfactType) {} else{
      sliderInput("cfacts", "Number of Counterfactuals",
                  min = 1, max = 4, value = 1)
    }
  })
  
  output$ui <- renderUI({
    if (input$cfactType) {
      sidebarPanel(fileInput("counterfact",'Upload a Counterfactual Dataframe (.RDS)',
                accept = '.RDS'),"Note: The counterfactual dataframe must be
                numeric and have the same number of columns as the primary data. File should 
                be saved using the saveRDS() function.")
      
    } else {
    lapply(1:input$cfacts, function(j) {
      column(3,
             lapply(1:length(ShinyData()), function(i){
               numericInput(paste0(LETTERS[j],"var",i), names(ShinyData())[i], 
                            median(ShinyData()[,i], na.rm = T))
             }))
    })
    }
  })
  
  ## handle data upload, use peacef as default
  ShinyData <- reactive({
    dataFile <- input$data
    if (is.null(input$data)) {
      peacef
    } else {
      readRDS(dataFile$datapath)
    }
  })
  ## Combine Counterfactuals into a matrix or handle uploaded data
  counterfacts <- reactive({
    if (input$cfactType){
      myFile <- input$counterfact
      if(is.null(myFile)) {peacecf[1:4,]} else {
      readRDS(myFile$datapath)
      }
    } else {
    cfacts <- input$cfacts
    out <- vector()
    for (j in 1:length(ShinyData())) {
      for (i in 1:cfacts) {
        out <- c(out, input[[paste0(LETTERS[i],"var",j)]])
      }
    }
   matrix(out, nrow = cfacts)}
    ##names(out) <- names(peacef)
  })
  
  ## Run whatif
  x <- eventReactive(input$update,{
    whatif(data = ShinyData(), cfact = counterfacts())
  })
  
  output$cfact <- renderTable({counterfacts()})
  
  output$data <- renderTable({ShinyData()})
  
  output$distPlot <- renderPlot({
    makeGraphic(x())
  })
  
  output$linePlot <- renderPlot({
    plot(x())})

})
