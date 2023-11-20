nza_blauw <- "#27348B"

ui <- navbarPage(
  shinyjs::useShinyjs(),
  title = "Draagkracht Draaglast tool",
  id = "navbar",
  tabPanel(
    title = "Initiële vragen",
    value = "initieel",
    p("Op basis van de intiële vragen wordt bepaald of het draagkracht draaglast model van toepassing is."),
    p("Op de ", a(href = "https://www.nza.nl/onderwerpen/jaarverslag/nieuws/2023/07/03/client-staat-centraal-in-nieuwe-vorm-van-bekostiging-wijkverpleging",
                 "website van de NZa", .noWS = "outside"), " vindt u meer informatie over dit model."),
    hr(),
    uiOutput("radios_initieel"),
    hr(),
    p("Op basis van de gekozen antwoorden valt de cliënt in profiel:"),
    htmlOutput("cp_initieel_txt"),
    actionButton('jumpToP2', 'ga naar DKDL', class = "btn-lg btn-success"),
    p("")
  ),
  tabPanel(
    title = "Cliëntprofiel",
    value = "clientprofiel",
    htmlOutput("cm_txt_output"),
    actionButton('jumpToP1', 'Klik hier om opnieuw te beginnen', class = "btn-lg btn-success")
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
        #cp_initieel_txt {font-size:20px;
               color:red;
               display:block; }
        .btn, .btn-lg, .btn-lg:hover, .btn-lg:active {background-color: #27348B !important;}
        .navbar-default .navbar-brand {color: black;}
        .navbar-default .navbar-brand:hover {color: black;}
        .navbar { background-color: white;}
        .navbar-default .navbar-nav > li > a {color:black;}
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus {color: white; background-color: #27348B},
                  ")
        )
  )