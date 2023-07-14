ui <- navbarPage(
  title = "Draagkracht Draaglast tool",
  id = "navbar",
  tabPanel(
    title = "Initiële vragen",
    value = "initieel",
    uiOutput("radios_initieel"),
    actionButton('jumpToP2', 'Volgende stap', class = "btn-lg btn-success"),
    p("")
  ),
  tabPanel(
    title = "Cliëntprofiel",
    value = "clientprofiel",
    htmlOutput("cm_txt_output"),
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