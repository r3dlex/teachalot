library(plyr)
library(dplyr)

source.directory <- "Src"
data.directory <- "Data"

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
  return (read.csv2(GetDataFilepath(filename)))
}

RunSrcFromPath <- function(filename)
{
  source(GetSrcFilepath(filename))
}

# Splits the string into same size parts
FixedSizeStringSplit <- function(string, size){
  pat <- paste0('(?<=.{',size,'})')
  strsplit(string, pat, perl=TRUE)
}

GetDateFromBirthNumber <- function(birthnumber)
{
  return (FixedSizeStringSplit(sprintf("%d", birthnumber), 2)[[1]])
}

GetBirthDateYyMmDd <- function(birthnumber)
{
  yymmdd <- GetDateFromBirthNumber(birthnumber)

  yy <- as.integer(yymmdd[1])
  mm <- as.integer(yymmdd[2])
  dd <- as.integer(yymmdd[3])

  return (sprintf('19%s/%s/%s', yy, mm, dd))
}


# Sets working directory to this dir
#setwd.scriptdir <- function()
#{
  #this.dir <- dirname(parent.frame(2)$ofile)
  #setwd(sprintf("%s/..", this.dir))
#}

#setwd.scriptdir()

RunSrcFromPath("clients.R")
RunSrcFromPath("accounts.R")

clientsdisp.df <- GetClientsDispositionDataFrame()
districts.df <- ReadDistrictsDataFrame()
accounts.df <- ReadAccountsDataFrame()
transactions.df <- ReadTransactionsDataFrame()
loans.df <- ReadLoansDataFrame()
cards.df <- ReadCreditCardsDataFrame()
orders.df <- ReadPermanentOrdersDataFrame()

#TODO continue from here
