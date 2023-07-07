library(shiny)
library(shinyjs)

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)