# place holder for DKDL model
determine_cp <- function(input){
  # input contains all casemix items
  Q1 <- input$Q1
  Q2 <- input$Q2
  
  # construct a df record with colnames
  # then apply DK DL OB transform
  # then create party object
  # then predict node
  # then add cluster name
  
  if(is.null(Q1) | is.null(Q2)) return(-1)
  if(Q1 == 1 & Q2 == 1){return(1)}
  if(Q1 > 1 & Q2 == 1){return(2)}
  if(Q1 == 1 & Q2 > 1){return(3)}
  if(Q1 > 1 & Q2 > 1){return(4)}
}
