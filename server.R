server <- function(input, output, session) {
  determine_cp <- function(Q1, Q2){
    if(is.null(Q1) | is.null(Q2)) return(-1)
    if(Q1 == 1 & Q2 == 1){return(1)}
    if(Q1 > 1 & Q2 == 1){return(2)}
    if(Q1 == 1 & Q2 > 1){return(3)}
    if(Q1 > 1 & Q2 > 1){return(4)}
  }
  
  observe({ # Create a reactive observer
    #hide(selector = "#navbar li a[data-value=results]")
    #show(selector = "#navbar li a[data-value=toelichting]")
  })

  output$tableOutput <- renderTable({
    if(input$button > 0){
      toggle(selector = "#navbar li a[data-value=formulier]")
      toggle(selector = "#navbar li a[data-value=results]")
    }else{
      NULL
    }
  })
  
  outputOptions(output, name = "tableOutput", 
                suspendWhenHidden = FALSE)
  
  ##################################################################################
  # Radiobuttons
  nameList <- c("Q1", "Q2")
  questionList <- c("Is er mantelzorg?", "Wat is het verwachte verloop?")
  choiceNames <- list(c("Ja", "Nee"), 
                  list(HTML("De toestand zal naar verwachting <p style='color:red;'>verbeteren.</p>"), 
                    HTML("De toestand zal naar verwachting <p style='color:red;'>gelijk blijven.</p>"), 
                    HTML("De toestand zal naar verwachting <p style='color:red;'>verslechteren.</p>")
                  ))
  choiceValues <- list(c(1:2), c(1:3))
  
  all_radios <- list()
  for (i in 1:length(nameList)) {
    all_radios[[i]] <- p(radioButtons(inputId = nameList[i], 
                                      label = questionList[i], 
                                      choiceNames = choiceNames[[i]],
                                      choiceValues = choiceValues[[i]], 
                                      inline = TRUE, 
                                      selected = 0))
  }
  
  output$myradios <- renderUI(all_radios) # Renders reactive HTML using the Shiny UI library.
  ##################################################################################
  
  output$cm_txt_output <- renderText({
    return(paste("De gekozen antwoordopties leiden af naar cliëntprofiel ", determine_cp(input$Q1, input$Q2), sep=""))
  })

  #############################################
  observeEvent(input$jumpToP2, {
    updateTabsetPanel(session, "navbar",
                      selected = "results")
  })
  
  observeEvent(input$jumpToP1, {
    updateTabsetPanel(session, "navbar",
                      selected = "formulier")
  })
  
}



