################# Data Description ############
#account = (4500 objects in the file ACCOUNT.ASC) ­ each record describes static
#characteristics of an account,
#permanent order = (6471 objects in the file ORDER.ASC) ­ each record describes
#characteristics of a payment order,
#transaction = (1056320 objects in the file TRANS.ASC) ­ each record describes one
#transaction on an account,
#loan = (682 objects in the file LOAN.ASC) ­ each record describes a loan granted for a
#given account,
###############################################

ReadAccountsDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("account.asc"))
}

ReadTransactionsDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("trans.asc"))
}

ReadLoansDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("loan.asc"))
}

ReadPermanentOrdersDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("order.asc"))
}

ReadCreditCardsDataFrame <- function()
{
  return (ReadDataFrameFromFilepath("card.asc"))
}
