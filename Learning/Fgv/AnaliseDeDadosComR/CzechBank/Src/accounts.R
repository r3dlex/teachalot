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

GetFrequencyValuesEn <- function()
{
  return (list(MONTHLY = "Monthly", WEEKLY = "Weekly", TRANSACTION = "AfterTransaction"))
}


GetFrequencyValuesCz <- function()
{
  return (list(MONTHLY = "POPLATEK MESICNE", WEEKLY = "POPLATEK TYDNE", TRANSACTION = "POPLATEK PO OBRATU"))
}


ReadAccountsDataFrame <- function()
{
  accounts.df <- (ReadDataFrameFromFilepath("account.asc"))

  # Normalizes date values
  accounts.df$date <- sapply(accounts.df$date, GetBirthDateYyMmDd)

  # Normalizes statement frequency values
  fv.cz <- GetFrequencyValuesCz()
  fv.en <- GetFrequencyValuesEn()

  accounts.df$frequency <- mapvalues(accounts.df$frequency, 
            from = c(fv.cz$MONTHLY, fv.cz$WEEKLY, fv.cz$TRANSACTION),
            to = c(fv.en$MONTHLY, fv.en$WEEKLY, fv.en$TRANSACTION))

  return (accounts.df)
}

GetTypeValuesCz <- function()
{
  return (list(CREDIT = "PRIJEM", DEBIT = "VYDAJ", CHOICE = "VYBER"))
}

GetTypeValuesEn <- function()
{
  # Debit is called withdrawal on the pdf but debit is a more common name
  return (list(CREDIT = "Credit", DEBIT = "Debit", CHOICE = "Choice")) 
}

GetOperationValuesCz <- function()
{
  return (list(CARDDEBIT = "VYBER KARTOU", CASHCREDIT = "VKLAD", CASHDEBIT = "VYBER", 
               OTHERBANKCREDIT = "PREVOD Z UCTU", OTHERBANKDEBIT = "PREVOD NA UCET"))
}

GetOperationValuesEn <- function()
{
  # remittance to another bank = sum of money sent to other institution
  # collection = credit from another institution
  return (list(CARDDEBIT = "CardDebit", CASHCREDIT = "CashCredit", CASHDEBIT = "CashDebit", 
               OTHERBANKCREDIT = "OtherBankCredit", OTHERBANKDEBIT = "OtherBankDebit"))
}

ReadTransactionsDataFrame <- function()
{
  trans.df <- ReadDataFrameFromFilepath("trans.asc")

  # Normalizes operation values
  op.cz <- GetOperationValuesCz()
  op.en <- GetOperationValuesEn()

  trans.df$operation <- mapvalues(trans.df$operation, 
            from = c(op.cz$CARDDEBIT, op.cz$CASHCREDIT, op.cz$CASHDEBIT, op.cz$OTHERBANKCREDIT, op.cz$OTHERBANKDEBIT),
            to = c(op.en$CARDDEBIT, op.en$CASHCREDIT, op.en$CASHDEBIT, op.en$OTHERBANKCREDIT, op.en$OTHERBANKDEBIT))

  # Normalizes date values
  trans.df$date <- sapply(trans.df$date, GetBirthDateYyMmDd)

  tp.cz <- GetTypeValuesCz()
  tp.en <- GetTypeValuesEn()

  trans.df$type <- mapvalues(trans.df$type, 
            from = c(tp.cz$CREDIT, tp.cz$DEBIT, tp.cz$CHOICE),
            to = c(tp.en$CREDIT, tp.en$DEBIT, tp.en$CHOICE))

  ks.cz <- GetKsymbolValuesCz()
  ks.en <- GetKsymbolValuesEn()

  trans.df$k_symbol <- mapvalues(trans.df$k_symbol, 
            from = c(ks.cz$INSURANCE, ks.cz$HOUSEHOLD, ks.cz$LOAN, ks.cz$PENSION, ks.cz$STATEMENT, ks.cz$SANCTION, ks.cz$INTEREST),
            to = c(ks.en$INSURANCE, ks.en$HOUSEHOLD, ks.en$LOAN, ks.en$PENSION, ks.en$STATEMENT, ks.en$SANCTION, ks.en$INTEREST))

  return (trans.df)
}

GetLoanStatusEn <- function()
{
  return (list(FINISHEDOK = "ContractFinishedOk", FINISHEDDEFAULT = "ContractFinishedDefault", RUNNINGOK = "RunningOk", RUNNINGDEBT = "RunningInDebt"))
}

GetLoanStatusLetters <- function()
{
  return (list(FINISHEDOK = "A", FINISHEDDEFAULT = "B", RUNNINGOK = "C", RUNNINGDEBT = "D"))
}

ReadLoansDataFrame <- function()
{
  loans.df <- (ReadDataFrameFromFilepath("loan.asc"))

  # Normalizes date values
  loans.df$date <- sapply(loans.df$date, GetBirthDateYyMmDd)

  ls.en <- GetLoanStatusEn()
  ls.lt <- GetLoanStatusLetters()

  loans.df$status <- mapvalues(loans.df$status, 
            from = c(ls.lt$FINISHEDOK, ls.lt$FINISHEDDEFAULT, ls.lt$RUNNINGOK, ls.lt$RUNNINGDEBT),
            to = c(ls.en$FINISHEDOK, ls.en$FINISHEDDEFAULT, ls.en$RUNNINGOK, ls.en$RUNNINGDEBT))

  return (loans.df)
}

# k_symbol is a column in permanent order and also in transactions
GetKsymbolValuesEn <- function()
{
  return (list(INSURANCE = "Insurance", HOUSEHOLD = "Household", LEASING = "Leasing", LOAN = "Loan", PENSION = "Pension", STATEMENT = "StatementForPayment", SANCTION = "SanctionNegativeBalance", INTEREST = "InterestCredit"))
}

GetKsymbolValuesCz <- function()
{
  return (list(INSURANCE = "POJISTNE", HOUSEHOLD = "SIPO", LEASING = "LEASING", LOAN = "UVER", PENSION = "DUCHOD", STATEMENT = "SLUZBY", SANCTION = "SANKC. UROK", INTEREST = "UROK"))
}

ReadPermanentOrdersDataFrame <- function()
{
  orders.df <- (ReadDataFrameFromFilepath("order.asc"))

  ks.cz <- GetKsymbolValuesCz()
  ks.en <- GetKsymbolValuesEn()

  orders.df$k_symbol <- mapvalues(orders.df$k_symbol, 
            from = c(ks.cz$INSURANCE, ks.cz$HOUSEHOLD, ks.cz$LEASING, ks.cz$LOAN),
            to = c(ks.en$INSURANCE, ks.en$HOUSEHOLD, ks.en$LEASING, ks.en$LOAN))

  return (orders.df)
}

ReadCreditCardsDataFrame <- function()
{
  cards.df <- (ReadDataFrameFromFilepath("card.asc"))

  # Normalizes date values
  cards.df$issued <- sapply(cards.df$issued, GetBirthDateYyMmDd)

  return (cards.df)
}
