server <- function(input, output, session) {
  
  source("dkdl_model.R", local = TRUE)
  source("casemix_vragen.R", local = TRUE)
  
  all_radios <- casemix_vragen(filename = "casemix_vragenlijst_full.csv")
  output$myradios <- renderUI(all_radios) # Renders reactive HTML using the Shiny UI library.
  
  output$cm_txt_output <- renderText({
    return(if(determine_cp(input$Q1, input$Q2) != -1){
      paste("De gekozen antwoordopties leiden af naar cliëntprofiel ", determine_cp(input$Q1, input$Q2), sep="")}
    else {paste("Nog niet alle vragen zijn beantwoord")})
  })

  observeEvent(input$jumpToP2, {
    updateTabsetPanel(session, "navbar",
                      selected = "results")
  })
  
  observeEvent(input$jumpToP1, {
    updateTabsetPanel(session, "navbar",
                      selected = "formulier")
  })
  
}



