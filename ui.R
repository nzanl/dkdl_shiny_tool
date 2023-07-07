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
             textOutput("cm_txt_output"),
             actionButton("button", "Doe actie button")
    ),
    tabPanel(
      title = "Cliëntprofiel",
      value = "results",
      tableOutput("tableOutput"),
      h1("Het bijbehorende cliëntprofiel is"),
      textOutput("cp_txt_output")
    ),
    tabPanel(
      title = "Toelichting bij het DKDL model",
      value = "hide", # The value that should be sent when tabsetPanel reports that this tab is selected. If omitted and tabsetPanel has an id, then the title will be used.
      h1("Toelichting"),
      p("Het draagkracht draaglast model werkt via een case-mix vragenlijst. Na beantwoording van de vragenlijst wordt er automatisch een cliëntprofiel afgeleid.")
    )
  )
)

