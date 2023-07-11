ui <- navbarPage(
  title = "Draagkracht Draaglast tool",
  id = "navbar",
  tabPanel(
    title = "Case-mix vragenlijst",
    value = "formulier",
    uiOutput("myradios"),
    actionButton('jumpToP2', 'Leid cliëntprofiel af', class = "btn-lg btn-success"),
    p("")
  ),
  tabPanel(
    title = "Cliëntprofiel",
    value = "results",
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