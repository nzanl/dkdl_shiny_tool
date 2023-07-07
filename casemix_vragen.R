casemix_vragen <- function(filename = NA){
  # Radiobuttons
  nameList <- c("Q1", "Q2")
  questionList <- c("Is er mantelzorg?", "Wat is het verwachte verloop?")
  choiceNames <- list(c("Ja", "Nee"), 
                      list(HTML("De toestand zal naar verwachting <p style='color:red;'>verbeteren.</p>"), 
                           HTML("De toestand zal naar verwachting <p style='color:red;'>gelijk blijven.</p>"), 
                           HTML("De toestand zal naar verwachting <p style='color:red;'>verslechteren.</p>")
                      ))
  choiceValues <- list(c(1:2), c(1:3))
  
  if(!is.na(filename)){
    casemix_vragenlijst <- readxl::read_excel(path = filename)
  }
  
  all_radios <- list()
  for (i in 1:length(nameList)) {
    all_radios[[i]] <- p(radioButtons(inputId = nameList[i], 
                                      label = questionList[i], 
                                      choiceNames = choiceNames[[i]],
                                      choiceValues = choiceValues[[i]], 
                                      inline = TRUE, 
                                      selected = 0))
  }
  return(all_radios)
}