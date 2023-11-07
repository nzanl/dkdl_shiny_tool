library(shiny)

# TODO
# checkbox group pas tonen na klikken vth
# knoppen om terug te gaan naar vorig tabblad
# toelichting pop ups

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)


# two file app, this file is only for testing locally
#rsconnect::deployApp('~/Werk/Github/nzanl/dkdl_shiny_tool')
# dep: shinyjs, partykit
# install rsconnect
# log in op shinyapps.io met werk login

