# place holder for DKDL model
determine_cp <- function(Q1, Q2){
  if(is.null(Q1) | is.null(Q2)) return(-1)
  if(Q1 == 1 & Q2 == 1){return(1)}
  if(Q1 > 1 & Q2 == 1){return(2)}
  if(Q1 == 1 & Q2 > 1){return(3)}
  if(Q1 > 1 & Q2 > 1){return(4)}
}
