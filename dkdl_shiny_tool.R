library(shiny)
library(shinyjs)

ui <- tagList(
  useShinyjs(),
  navbarPage(
    "Draagkracht Draaglast tool",
    id = "navbar",
    tabPanel(title = "Case-mix vragenlijst",
             id = "questions",
             h1("Initiële vragen"), # HTML
             uiOutput("myradios"),
             h1("DKDL vragen"),
             textOutput("txt"),
             actionButton("button", "Doe actie button")
    ),
    tabPanel(
      title = "Cliëntprofiel",
      value = "results",
      tableOutput("tableOutput"),
      h1("Het bijbehorende cliëntprofiel is"),
      textOutput("txt1")
    ),
    tabPanel(
      title = "Toelichting bij het DKDL model",
      value = "hide", # The value that should be sent when tabsetPanel reports that this tab is selected. If omitted and tabsetPanel has an id, then the title will be used.
      h1("Dit tabblad wordt vervangen door results")
    )
  )
)

server <- function(input, output, session) {
  observe({ # Create a reactive observer
    hide(selector = "#navbar li a[data-value=results]")
    show(selector = "#navbar li a[data-value=hide]")
  })
  
  output$tableOutput <- renderTable({
    if(input$button > 0){
      toggle(selector = "#navbar li a[data-value=results]")
      toggle(selector = "#navbar li a[data-value=hide]")
    }else{
      NULL
    }
  })
  
  outputOptions(output, "tableOutput", suspendWhenHidden=F)
  
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
  
  output$myradios <- renderUI(all_radios)
  
  output$txt <- renderText({
    return(paste("De gekozen antwoordopties:", input$Q1, "and", input$Q2, sep=" "))
  })
  output$txt1 <- renderText({
    return(paste("Bij deze antwoordopties horen:", input$Q1, "and", input$Q2, sep=" "))
  })
  
  observeEvent(input$button, {
    k <- input$button %% 2
    #print(k)
    if (k==1) {
      hide("myradios")
      show("txt")
    }else {
      show("myradios")
      hide("txt")
    }
  }, ignoreNULL = FALSE)
  
}

shinyApp(ui = ui, server = server)


# ui <- fluidPage(
#   radioButtons("rb", "Choose one:",
#                choiceNames = list(
#                  icon("calendar"),
#                  HTML("<p style='color:red;'>Red Text</p>"),
#                  "Normal text"
#                ),
#                choiceValues = list(
#                  "icon", "html", "text"
#                )),
#   textOutput("txt")
# )
# 
# server <- function(input, output) {
#   output$txt <- renderText({
#     paste("You chose", input$rb)
#   })
# }
# 
# shinyApp(ui, server)
# }
