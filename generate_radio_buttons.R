library(tidyverse)

generate_radio_buttons <- function(filename = NA, subset = NA){
  if(exists("choiceNames")) rm(choiceNames)
  
  # inlezen casemix vragenlijst
  if(!is.na(filename)){
    casemix_vragenlijst <- read.csv2(filename)
  }
  casemix_vragenlijst <- casemix_vragenlijst %>% 
    filter(QuestionGroup == subset)
  # process lijst
  nameList <- unique(casemix_vragenlijst$QuestionId)
  questionList <- unique(casemix_vragenlijst$QuestionName)
  i <- 0
  for(question in nameList){
    i <- i + 1
    #print(question)
    if(!exists("choiceNames")){
    choiceNames <- list(casemix_vragenlijst %>% 
      filter(QuestionId == question) %>% 
      pull(ChoiceName))
    } else { 
      choiceNames <- append(choiceNames, list(casemix_vragenlijst %>% 
                            filter(QuestionId == question) %>% 
                            pull(ChoiceName)))
    }
    if(!exists("choiceValues")){
      choiceValues <- list(casemix_vragenlijst %>% 
                             filter(QuestionId == question) %>% 
                             pull(ChoiceValue))
    } else {
    choiceValues <- append(choiceValues, list(casemix_vragenlijst %>% 
                                                filter(QuestionId == question) %>% 
                                                pull(ChoiceValue)))
    }
    #print(choiceValues[[i]])
  }
 
  all_radios <- list()
  for (i in 1:length(nameList)) {

    all_radios[[i]] <- p(radioButtons(inputId = nameList[i], 
                                      label = questionList[i], 
                                      choiceNames = lapply(choiceNames[[i]], HTML),
                                      choiceValues = choiceValues[[i]], 
                                      inline = FALSE, 
                                      width = "800px",
                                      selected = 0))
  }
  return(all_radios)
}