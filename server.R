server <- function(input, output, session) {
  
  source("dkdl_model.R", local = TRUE)
  source("casemix_vragen.R", local = TRUE)
  
  radios_initieel <- casemix_vragen(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Initiële vragen")
  
  output$radios_initieel <- renderUI(radios_initieel) # Renders reactive HTML using the Shiny UI library.

  radios_draagkracht <- casemix_vragen(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draagkracht")
  
  output$radios_draagkracht <- renderUI(radios_draagkracht) # Renders reactive HTML using the Shiny UI library.  

  radios_draaglast <- casemix_vragen(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draaglast")
  
  output$radios_draaglast <- renderUI(radios_draaglast) # Renders reactive HTML using the Shiny UI library.
  
  radios_ob <- casemix_vragen(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Ondersteuningsbehoefte")
  
  output$radios_ob <- renderUI(radios_ob) # Renders reactive HTML using the Shiny UI library.
  
  output$cm_txt_output <- renderText({
    # hier eerst check functie aanroepen: zijn alle benodigde vragen beantwoord?
    if(!(determine_cp(input) %in% c(-1, NULL))){
      paste("De gekozen antwoordopties leiden af naar cliëntprofiel <br> <b>", determine_cp(input), "</b>")}
    else {paste("Nog niet alle vragen zijn beantwoord")}
  })

  observeEvent(input$jumpToP2, {
    updateTabsetPanel(session, "navbar",
                      selected = "draagkracht")
  })
  observeEvent(input$jumpToP3, {
    updateTabsetPanel(session, "navbar",
                      selected = "draaglast")
  })
  observeEvent(input$jumpToP4, {
    updateTabsetPanel(session, "navbar",
                      selected = "ondersteuningsbehoefte")
  })
  observeEvent(input$jumpToP5, {
    updateTabsetPanel(session, "navbar",
                      selected = "results")
  })
  observeEvent(input$jumpToP1, {
    updateTabsetPanel(session, "navbar",
                      selected = "initieel")
  })
  
}



