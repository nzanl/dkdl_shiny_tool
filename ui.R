ui <- navbarPage(
  title = "Draagkracht Draaglast tool",
  id = "navbar",
  tabPanel(
    title = "Initiële vragen",
    value = "initieel",
    uiOutput("radios_initieel"),
    actionButton('jumpToP2', 'Ga naar Draagkracht', class = "btn-lg btn-success"),
    p("")
  ),
  tabPanel(
    title = "Draagkracht",
    value = "draagkracht",
    uiOutput("radios_draagkracht"),
    actionButton('jumpToP3', 'Ga naar Draaglast', class = "btn-lg btn-success"),
    p("")
  ),  
  tabPanel(
    title = "Draaglast",
    value = "draaglast",
    uiOutput("radios_draaglast"),
    actionButton('jumpToP4', 'Ga naar Ondersteuningsbehoefte', class = "btn-lg btn-success"),
    p("")
  ),
  tabPanel(
    title = "Ondersteuningsbehoefte",
    value = "ondersteuningsbehoefte",
    uiOutput("radios_ob"),
    actionButton('jumpToP5', 'Ga naar Cliëntprofiel', class = "btn-lg btn-success"),
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