library(dplyr)

string.fixedsplit <- function(string, size){
  pat <- paste0('(?<=.{',size,'})')
  strsplit(string, pat, perl=TRUE)
}

# birthnumber is in the format YYMMDD - if it is a woman it is DD + 50
clients.genderfromdate  <- function(birthnumber)
{
  astring <- string.fixedsplit(sprintf("%d", birthnumber), 2)
  yy <- as.integer(astring[[1]][1])
  mm <- as.integer(astring[[1]][2])
  dd <- as.integer(astring[[1]][3])

  return (ifelse(mm < 50,  0 , 1))
}
