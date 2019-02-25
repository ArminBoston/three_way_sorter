library(shiny)

source("chooser.R")
setwd("~/Documents/Cherry_picking_macro/cherry_picking_app/")

#Read in primerplates and primertubes for all users and all sessions
primerPlates <<- read.csv("primerplates.csv", sep=",", header=T, stringsAsFactors=F)
primerTubes <<- read.csv("primertubes.csv", sep=",", header=F, stringsAsFactors=F)[,1]


######################################## UI ##############################################
ui <- fluidPage(
  titlePanel("Three-way sorter"),
  
  #Show batch number and file input boxes
  fileInput(inputId="inFile", label="Upload one file with items to be sorted", multiple=FALSE, accept=NULL, width=NULL, buttonLabel="Browse", placeholder="No file selected"),

  #Show Sorter gadget
  uiOutput("itemSorter"),
  
  #Show action button
  tags$h6(""),
  uiOutput("submit"),
  
  #tableOutput("test"),
  verbatimTextOutput("chosenList")
  
  #verbatimTextOutput("selection"),
  #tableOutput("primertubeTable")
)

####################################### SERVER ###########################################

server <- function(input, output){
  #Read in a file with items to be sorted
  items <- reactive({
    req(input$inFile)
    file <- input$inFile
    if(is.null(file)){return(NULL)}
    read.csv(file$datapath, sep=",", header=F, stringsAsFactors=F)
  })
  
  #Initiate Sorter gadget
  output$itemSorter <- renderUI({
    df <- items()
    chooserInput("mychooser", "Sort your inputs among the three boxes by selecting items and clicking arrows. When you are done, click the button below to sort.", 
                 "Group 1", "Group 2", "Group 3", 
                 df[,1], c(), c(), size1=23, size2=10, multiple=TRUE)
  })
  
  #Upon data input into Sorter, an action button appears
  output$submit <- renderUI({
    if (! is.null(input$mychooser)){
      actionButton(inputId="submitButton", label="Click to sort")
    }
  })
  
  #By clicking above action button, sort items into three lists
  sortedItems <- eventReactive(input$submitButton, {
    chosenList <- input$mychooser
    
    
    return(chosenList)
    
  })
  
  output$chosenList <- renderPrint({sortedItems()})
  
}

shinyApp(ui = ui, server = server)