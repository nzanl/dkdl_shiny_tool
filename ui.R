ui <- navbarPage(
  title = "Draagkracht Draaglast tool",
  id = "navbar",
  tabPanel(
    title = "Initiële vragen",
    value = "initieel",
    p("Op basis van de intiële vragen wordt bepaald of het draagkracht draaglast model van toepassing is."),
    hr(),
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
  ), 
  # Bootstrap CSS 
  header = tags$style(HTML(" 
        .navbar-default .navbar-brand {color: black;}
        .navbar-default .navbar-brand:hover {color: black;}
        .navbar { background-color: white;}
        .navbar-default .navbar-nav > li > a {color:black;} 
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus {color: white; background-color: #5cb85c},
                  "))
)