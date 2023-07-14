server <- function(input, output, session) {
  source("determine_cp.R", local = TRUE)
  source("generate_radio_buttons.R", local = TRUE)
  
  radios_initieel <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Initiële vragen")
  
  output$radios_initieel <- renderUI(radios_initieel) # Renders reactive HTML using the Shiny UI library.

  radios_draagkracht <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draagkracht")
  
  output$radios_draagkracht <- renderUI(radios_draagkracht) # Renders reactive HTML using the Shiny UI library.  

  radios_draaglast <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draaglast")
  
  output$radios_draaglast <- renderUI(radios_draaglast) # Renders reactive HTML using the Shiny UI library.
  
  radios_ob <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Ondersteuningsbehoefte")
  
  output$radios_ob <- renderUI(radios_ob) # Renders reactive HTML using the Shiny UI library.
  
  output$cm_txt_output <- renderText({
    shiny::req(input$Q1, input$Q2, input$Q3)
    paste("De gekozen antwoordopties leiden af naar cliëntprofiel: <br> <br> <Br> <h1> <b>", determine_cp(input), "</b> </h1")
  })

  observeEvent(input$jumpToP2, {
    if(req(input$Q1)){
      if (input$Q1 == "1") {
        insertTab(inputId = "navbar", 
                  tab = tabPanel(
                    title = "Draagkracht",
                    value = "draagkracht",
                    uiOutput("radios_draagkracht"),
                    actionButton('jumpToP3', 'Ga naar Draaglast', class = "btn-lg btn-success"),
                    p("")
                  ),
                  target = "initieel")
        insertTab(inputId = "navbar", 
                  tab = tabPanel(
                    title = "Draaglast",
                    value = "draaglast",
                    uiOutput("radios_draaglast"),
                    actionButton('jumpToP4', 'Ga naar Ondersteuningsbehoefte', class = "btn-lg btn-success"),
                    p("")
                  ),
                  target = "draagkracht")
        insertTab(inputId = "navbar", 
                  tab = tabPanel(
                    title = "Ondersteuningsbehoefte",
                    value = "ondersteuningsbehoefte",
                    uiOutput("radios_ob"),
                    actionButton('jumpToP5', 'Ga naar Cliëntprofiel', class = "btn-lg btn-success"),
                    p("")
                  ),
                  target = "draaglast")           
      }
      if(input$Q1 == "2" | is.null(input$Q1)) {
        removeTab(inputId = "navbar", target = "draagkracht")
        removeTab(inputId = "navbar", target = "draaglast")
        removeTab(inputId = "navbar", target = "ondersteuningsbehoefte")
      }
    }
    print(input$draagkracht)
    if(!is.null(input$draagkracht)){
      
    updateTabsetPanel(session, "navbar",
                      selected = "draagkracht")
    } else{
      updateTabsetPanel(session, "navbar",
                        selected = "clientprofiel")
    }
    print(input$draagkracht)
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
                      selected = "clientprofiel")
  })
  observeEvent(input$jumpToP1, {
    updateTabsetPanel(session, "navbar",
                      selected = "initieel")
  })
  
}



