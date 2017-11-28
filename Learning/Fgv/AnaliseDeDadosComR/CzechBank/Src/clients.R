library(dplyr)

################# Data Description ############
#client = (5369 objects in the file CLIENT.ASC) ­ each record describes characteristics of
#a client,
#disposition = (5369 objects in the file DISP.ASC) ­ each record relates together a client
#with an account i.e. this relation describes the rights of clients to operate accounts,
#relation permanent order (6471 objects in the file ORDER.ASC) ­ each record describes
###############################################


FixedSizeStringSplit <- function(string, size){
  pat <- paste0('(?<=.{',size,'})')
  strsplit(string, pat, perl=TRUE)
}

GetDateFromBirthNumber <- function(birthnumber)
{
  return (FixedSizeStringSplit(sprintf("%d", birthnumber), 2)[[1]])
}

# birthnumber is in the format YYMMDD - if it is a woman it is DD + 50
GenderFromDate <- function(birthnumber)
{
  yymmdd <- GetDateFromBirthNumber(birthnumber)

  yy <- as.integer(yymmdd[1])
  mm <- as.integer(yymmdd[2])
  dd <- as.integer(yymmdd[3])

  return (ifelse(mm < 50,  0 , 1))
}

GetBirthDateYyMmDd <- function(birthnumber)
{
  yymmdd <- GetDateFromBirthNumber(birthnumber)

  yy <- as.integer(yymmdd[1])
  mm <- as.integer(yymmdd[2])
  mm <- ifelse(mm < 50, mm, mm - 50)
  dd <- as.integer(yymmdd[3])

  return (sprintf('19%s/%s/%s', yy, mm, dd))
}

ReadClientsDataFrame <- function()
{
  
  clients.df <- ReadDataFrameFromFilepath("client.asc")
  clients.df$gender <- sapply(clients.df$birth_number, GenderFromDate)
  clients.df$birth_date <- sapply(clients.df$birth_number, GetBirthDateYyMmDd)

  return (clients.df)
}

ReadDispositionDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("disp.asc"))
}

GetClientsDispositionDataFrame <- function()
{
  clients.df <- ReadClientsDataFrame()
  disposition.df <- ReadDispositionDataFrame()

  return (inner_join(clients.df, disposition.df))
}

ReadDistrictsDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("district.asc"))
}

