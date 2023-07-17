server <- function(input, output, session) {
  observe({
    shinyjs::hide("jumpToP2")
    
    
    if(!is.null(input$Q1) | 
       (!is.null(input$Q1) & !is.null(input$Q2)) | 
       (!is.null(input$Q1) & !is.null(input$Q2) & !is.null(input$Q3))) {
      output$cp_initieel_txt <- renderText({paste("<h1> ", determine_cp(input), "</h1> <br>")})
    }
    if((!is.null(input$Q1) & !is.null(input$Q2) & !is.null(input$Q3))){
      if((as.integer(input$Q1) + as.integer(input$Q2) + as.integer(input$Q3)) == 3){
        shinyjs::show("jumpToP2")
      }
    }
  })
  observeEvent(input$Q12, {shinyjs::toggle("Q13")
    })
  
  source("determine_cp.R", local = TRUE)
  source("generate_radio_buttons.R", local = TRUE)
  
  output$cp_initieel_txt <- renderText({paste("Nog geen initieel profiel")})
  
  radios_initieel <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Initiële vragen")
  
  output$radios_initieel <- renderUI(radios_initieel)

  radios_draagkracht <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draagkracht")
  
  output$radios_draagkracht <- renderUI(radios_draagkracht) 

  radios_draaglast <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Draaglast")
  
  output$radios_draaglast <- renderUI(radios_draaglast) 
  
  radios_ob <- generate_radio_buttons(filename = "casemix_vragenlijst_full.csv", 
                                    subset = "Ondersteuningsbehoefte")
  
  output$radios_ob <- renderUI(radios_ob) # Renders reactive HTML using the Shiny UI library.
  
  output$cm_txt_output <- renderText({
    shiny::req(input$Q1, input$Q2, input$Q3)
    paste("De gekozen antwoordopties leiden af naar cliëntprofiel: <br> <br> <Br> <h1> <b>", determine_cp(input), "</b> </h1")
  })

  observeEvent(input$jumpToP2, {
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
                    strong("Verpleegtechnische zorgvraag"),
                    checkboxInput("Q12", "De cliënt heeft een verpleegtechnische zorgvraag", FALSE),
                    checkboxGroupInput("Q13", label = NULL,
                                       c("Zwachtelen (bijv. compressief zwachtelen)" = "VR_technisch_zwachtelen",
                                         "Complexe wond(en) (na circa 3 weken nog geen wondsluiting plaatsgevonden/verwacht)" = "VR_technisch_complexewonden",
                                         "Sonde (bijv. sondevoeding toedienen)" = "VR_technisch_sonde",
                                         "Eenmalige- of verblijfskatheter (bijv. blaaskatheterisatie uitvoeren, blaasspoeling)" = "VR_technisch_eenmaligeofverblijfskatheter",
                                         "Overige blaas- en nierkatheterisatie (bijv. suprapubische katheterisatie, nefrostoma)" = "VR_technisch_overigeblaasennierkatheterisatie",
                                         "Darmstoma (bijv. stomamateriaal verwisselen)" = "VR_technisch_darmstoma",
                                         "Darmspoeling (bijv. structureel klysma toedienen, darmspoeling)" = "VR_technisch_darmspoeling",
                                         "Injecties (bijv. subcutaan of intramusculair injecteren)" = "VR_technisch_injecties"
                                       )),
                    actionButton('jumpToP5', 'Ga naar Cliëntprofiel', class = "btn-lg btn-success"),
                    p("")
                  ),
                  target = "draaglast")           

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
                      selected = "clientprofiel")
  })
  observeEvent(input$jumpToP1, {
    session$reload()
  })
  
}



