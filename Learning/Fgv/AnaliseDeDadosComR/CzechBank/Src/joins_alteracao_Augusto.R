########################
#
# Joins 
#
########################

library(gmodels)
library(tidyverse)
library(plyr)

# Comparing the results in decision tree and logistic regression
DecisionTreeXLogisticRegression <- funcion (data, field)
{
  
}

# 
GetScoreForFactorVariables <- function(data, discript, strings)
{
  values <- data[, discript]
  scores <- 1:length(strings)
  names(scores) <- strings
  data$scores <- scores[values]
  
  return (data$scores)
}


ConvertCharAndIntegerVariables <- function(data){
  data[sapply(data, is.integer)] <- lapply(data[sapply(data, is.integer)], as.numeric)
  data[sapply(data, is.character)] <- lapply(data[sapply(data, is.character)], as.factor) 
  
  return(sapply(data, class))
}

# joins
joinclientdistrict <- inner_join(clientsdisp.df, districts.df, by = c("district_id","district_id"))
joinaccountdistrict <- inner_join(accounts.df, districts.df, by = c("district_id","district_id")) 
joinclientaccount <- inner_join(clientsdisp.df, accounts.df, by = c("account_id","account_id"))
joinclientcard <- left_join(joinclientdistrict, cards.df, by = c("disp_id","disp_id"))
joinclientacntloans <- left_join(joinclientaccount, loans.df,by = c("account_id","account_id"))

# renaming columns
colnames(joinclientdistrict)[3] <- c("cl_district_id")
colnames(joinclientdistrict)[9] <- c("type_cl")
colnames(joinclientcard)[26] <- c("type_card")
colnames(joinclientaccount)[3] <- "cl_district_id"
colnames(joinclientaccount)[10] <- "acnt_district_id"
colnames(joinclientacntloans)[12] <- "date_account"
colnames(joinclientacntloans)[14] <- "date_loan"


# converting
ConvertCharAndIntegerVariables(joinclientaccount)
ConvertCharAndIntegerVariables(joinaccountdistrict)
ConvertCharAndIntegerVariables(joinclientcard)
ConvertCharAndIntegerVariables(joinclientacntloans)



clientrating.df <- clientsdisp.df[c(1,4,6,8)]

# client type - Owner - 2, DISPONENT - 1
clientrating.df$client_type <- revalue(joinclientcard$type_cl, c("OWNER" = 2, "DISPONENT" = 1))

# Card score - Gold - 3, Classic - 2, Junior - 1
clientrating.df$card <- revalue(joinclientcard$type_card,replace = c("gold" = 3, "classic" = 2, "junior" = 1))

# Years that the client has the card
clientrating.df$year_card <- GetAgeFromRefDate(joinclientcard$issued,refdate)

# Account frequency
clientrating.df$acnt_frequency <- GetScoreForFactorVariables(joinclientaccount, "frequency", c("Monthly", "Weekly", "AfterTransaction"))

# Years that the client has the account
clientrating.df$year_account <- GetAgeFromRefDate(joinclientaccount$date,refdate)

# Loans
distinct(joinclientacntloans,status)

clientrating.df$loan_status <- GetScoreForFactorVariables(joinclientacntloans, "status", c("ContractFinishedDefault", "RunningInDebt", "RunningOk","ContractFinishedOk"))
clientrating.df$year_loan <- GetAgeFromRefDate(joinclientacntloans$date_loan,refdate) 
clientrating.df$duration_loan <- joinclientacntloans$duration           

year_loan <- clientrating.df$year_loan * 12
duration <- joinclientacntloans$duration

clientrating.df$mth_to_pay_loan <- ifelse(year_loan < duration, duration - year_loan,0)


View(clientrating.df)


