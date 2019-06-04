library(dplyr)
library(plyr)
library(data.table)
library(stringi)

source.directory <- "Src"
data.directory <- "Data"
refdate <- "1999/09/15"

GetDataFilepath <- function(filename)
{
  return (sprintf("%s/%s", data.directory, filename))
}

GetSrcFilepath <- function(filename)
{
  return (sprintf("%s/%s", source.directory, filename))
}

ReadDataFrameFromFilepath <- function(filename)
{
  #read.csv2 is super slow for no reason so not using it
  #return (read.csv2(GetDataFilepath(filename)))
  return (fread(GetDataFilepath(filename), header=T, sep=";"))
}

RunSrcFromPath <- function(filename)
{
  source(GetSrcFilepath(filename))
}

GetDateFromBirthNumber <- function(birthnumber)
{
  return (stri_extract_all(birthnumber, regex="\\d{2}")[[1]])
}

GetBirthDateYyMmDd <- function(birthnumber)
{
  yymmdd <- GetDateFromBirthNumber(birthnumber)
  
  yy <- yymmdd[1]
  mm <- yymmdd[2]
  dd <- yymmdd[3]
  
  return (sprintf('19%s/%s/%s', yy, mm, dd))
}

##########################
#
# Starts the script itself
#
#########################

RunSrcFromPath("clients.R")
RunSrcFromPath("accounts.R")

clientsdisp.df <- GetClientsDispositionDataFrame()
districts.df <- ReadDistrictsDataFrame()
accounts.df <- ReadAccountsDataFrame()

# Only reloads transactions if truly necessary for it is a heavy part of the dataset
if (!exists("transactions.df")) 
{
  transactions.df <- ReadTransactionsDataFrame()
}

loans.df <- ReadLoansDataFrame()
cards.df <- ReadCreditCardsDataFrame()
orders.df <- ReadPermanentOrdersDataFrame()
