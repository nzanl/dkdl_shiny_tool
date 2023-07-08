library(tidyverse)

casemix_vragen <- function(filename = NA){
  # inlezen casemix vragenlijst
  if(!is.na(filename)){
    casemix_vragenlijst <- readxl::read_excel(path = filename)
  }

  # process lijst
  nameList <- unique(casemix_vragenlijst$QuestionId)
  questionList <- unique(casemix_vragenlijst$QuestionName)
  
  for(question in nameList){
    if(!exists("choiceNames")){
    choiceNames <- casemix_vragenlijst %>% 
      filter(QuestionId == question) %>% 
      pull(ChoiceName)
    } else { 
      choiceNames <- list(choiceNames, casemix_vragenlijst %>% 
                            filter(QuestionId == question) %>% 
                            pull(ChoiceName))
    }
    if(!exists("choiceValues")){
      choiceValues <- casemix_vragenlijst %>% filter(QuestionId == question) %>% pull(ChoiceValue)
    } else {
    choiceValues <- list(choiceValues, casemix_vragenlijst %>% filter(QuestionId == question) %>% pull(ChoiceValue))
    }
  }
 
  all_radios <- list()
  for (i in 1:length(nameList)) {
    all_radios[[i]] <- p(radioButtons(inputId = nameList[i], 
                                      label = questionList[i], 
                                      choiceNames = lapply(choiceNames[[i]], HTML),
                                      choiceValues = choiceValues[[i]], 
                                      inline = TRUE, 
                                      selected = 0))
  }
  return(all_radios)
}