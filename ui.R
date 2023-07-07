ui <- tagList(
  useShinyjs(),
  navbarPage(
    title = "Draagkracht Draaglast tool",
    id = "navbar",
    tabPanel(title = "Case-mix vragenlijst",
             value = "formulier",
             #h1("Initiële vragen"),
             h1("DKDL vragen"),
             uiOutput("myradios"),
             actionButton('jumpToP2', 'Leid cliëntprofiel af')
    ),
    tabPanel(
      title = "Cliëntprofiel",
      value = "results",
      #tableOutput("tableOutput"),
      textOutput("cm_txt_output"),
      actionButton('jumpToP1', 'Ga terug naar de vragenlijst')
    ),
    tabPanel(
      title = "Toelichting bij het DKDL model",
      value = "toelichting", # The value that should be sent when tabsetPanel reports that this tab is selected. 
      h1("Toelichting"),
      p("Het draagkracht draaglast model werkt via een case-mix vragenlijst."),
      p("Na beantwoording van de vragenlijst wordt er automatisch een cliëntprofiel afgeleid.")
    )
  )
)