library(shiny)
library(DT)
library(dplyr)
df = read.csv("dfShiny.csv")

server = function(input, output){ 
  values = reactiveValues(dfWorking = df) 
  
  observeEvent(input$deleteRows,
               {if (!is.null(input$table1_rows_selected))
                 
               {values$dfWorking = values$dfWorking[-as.numeric(input$table1_rows_selected),]}
               }
  )
  
  output$table1 = renderDataTable({datatable(values$dfWorking, escape = FALSE) %>% formatStyle(
  'percent',
  target = 'row',
  backgroundColor = styleInterval(c(0.20), c('white', 'gray'))
  ) })

  # output$table1 = renderDataTable({ values$dfWorking }, escape=FALSE)
  
}
