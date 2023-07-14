library(shiny)

# TODO

# verpleegtechnische zorgvraag
# knop reset vragenlijst
# knoppen om terug te gaan

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)


# two file app, this file is only for testing locally
#rsconnect::deployApp('~/Werk/Github/gsverhoeven/dkdl_shiny_tool')

# shinyjs for toggle hide/show
# conditionalPanel