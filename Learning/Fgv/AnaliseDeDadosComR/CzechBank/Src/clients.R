library(dplyr)

################# Data Description ############
#client = (5369 objects in the file CLIENT.ASC) ? each record describes characteristics of
#a client,
#disposition = (5369 objects in the file DISP.ASC) ? each record relates together a client
#with an account i.e. this relation describes the rights of clients to operate accounts,
#relation permanent order (6471 objects in the file ORDER.ASC) ? each record describes
###############################################


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

GetAgeFromRefDate <- function(birth_date, refdate) {
  
  require(lubridate)
  
  period <- as.period(interval(birth_date, refdate),
                      unit = "year")
  
  return(period$year)
  
}

ReadClientsDataFrame <- function()
{
  
  clients.df <- ReadDataFrameFromFilepath("client.asc")
  clients.df$gender <- sapply(clients.df$birth_number, GenderFromDate)
  clients.df$birth_date <- sapply(clients.df$birth_number, GetBirthDateYyMmDd)
  clients.df$age <- GetAgeFromRefDate(clientsdisp.df$birth_date,refdate) #Date when the PKDD'99 happened 
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
  districts.df <- ReadDataFrameFromFilepath("district.asc")
  
  #Normalizes columns names of districts.df
  colnames(districts.df) <- c("district_id","district_name","region","n_inhabitants","municip_less_499","municip_between_500_1999","municip_between_2000_9999","municip_more_10000", "n_cities","ratio_urban_inhab","avg_salary","unemploy_rate_95","unemploy_rate_96","n_entrepreneurs_1000_inhab","n_commited_crimes_95","n_commited_crimes_96")
  
  return (districts.df)
}
