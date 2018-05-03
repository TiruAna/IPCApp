library(shiny)
library(DT)
library(dplyr)

ui = fluidPage(
  titlePanel("IPCApp"),
  sidebarLayout( 
    sidebarPanel(actionButton("deleteRows", "Delete Rows"),
                 br(),
                 br(),
                 actionButton("saveTable", "Save Table"),
                 width = 1.5),
    mainPanel(dataTableOutput("table1"), tags$head(tags$script(src="test.js"))) 
  )
)
