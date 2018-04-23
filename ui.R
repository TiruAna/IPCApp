library(shiny)
library(DT)
library(dplyr)

ui = fluidPage(
  titlePanel("Delete rows for fuzzywuzzy"),
  sidebarLayout( 
    sidebarPanel(actionButton("deleteRows", "Delete Rows"),
                 br(),
                 br(),
                 actionButton("saveTable", "Save Table")),
    #br(),
    #br(),
    #actionButton("markPrice", "Mark Price")),  
    mainPanel(dataTableOutput("table1"), tags$head(tags$script(src="test.js"))) 
  )
)