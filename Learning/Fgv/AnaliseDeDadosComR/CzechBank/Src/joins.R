########################
#
# Joins 
#
########################

library(gmodels)
library(tidyverse)
library(plyr)

# Comparing the results in decision tree and logistic regression
#DecisionTreeXLogisticRegression <- funcion (data, field)
#{
  
#}

GetScoreForFactorVariables <- function(data, discript, strings)
{
  values <- data[, discript]
  scores <- 1:length(strings)
  names(scores) <- strings
  data$scores <- scores[values]
  
  return (data$scores)
}

GetScoreForNumericVariables <- function(data, posneg)
{
  values <- as.double(unlist(data))
  score <- as.integer(NA)
  data <- data.frame(values, score)
  
  posneg = "p"
  range1 <- between(data$values,quantile(data$values, na.rm = T)[1],quantile(data$values, na.rm = T)[2])
  range2 <- between(data$values,quantile(data$values, na.rm = T)[2],quantile(data$values, na.rm = T)[3])
  range3 <- between(data$values,quantile(data$values, na.rm = T)[3],quantile(data$values, na.rm = T)[4])
  range4 <- between(data$values,quantile(data$values, na.rm = T)[4],quantile(data$values, na.rm = T)[5])
  
  if(posneg == "p")
  {
    data$score <- ifelse(range1 == TRUE, 1,ifelse(range2 == TRUE, 2,ifelse(range3 == TRUE, 3, ifelse(range4 == TRUE, 4, NA))))
    
    return(data$score)
    
  }else if(posneg == "n")
  {
    data$score <- ifelse(range1 == TRUE, 4,ifelse(range2 == TRUE, 3,ifelse(range3 == TRUE, 2, ifelse(range4 == TRUE, 1, NA))))
    
    return(data$score)
  }else
  {
    print("Insira p ou n para obter o score desejado.")  
  }      
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
colnames(joinclientcard)[9] <- c("type_cl")
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
ConvertCharAndIntegerVariables(joinclientdistrict)


clientrating.df <- clientsdisp.df[c(1,4,6,8)]
clientrating.df$cl_district_id <- joinclientaccount$cl_district_id
clientrating.df$acnt_district_id <- joinclientaccount$acnt_district_id
clientrating.df$diff_district <- ifelse(clientrating.df$cl_district_id != clientrating.df$acnt_district_id, 1, 0)

#client district
clientrating.df$dis_avg_salary <- GetScoreForNumericVariables(joinclientdistrict$avg_salary,"p")
clientrating.df$dis_unemp_rate_95 <- GetScoreForNumericVariables(joinclientdistrict$unemploy_rate_95,"n")
clientrating.df$dis_unemp_rate_96 <- GetScoreForNumericVariables(joinclientdistrict$unemploy_rate_96,"n")
clientrating.df$dis_commit_crimes_95 <- GetScoreForNumericVariables(joinclientdistrict$n_commited_crimes_95,"n")
clientrating.df$dis_commit_crimes_96 <- GetScoreForNumericVariables(joinclientdistrict$n_commited_crimes_96,"n")


# client type - Owner - 2, DISPONENT - 1
clientrating.df$client_type <- as.numeric(revalue(joinclientdistrict$type_cl,replace = c("OWNER" = 2, "DISPONENT" = 1)))

# Card score - Gold - 3, Classic - 2, Junior - 1
clientrating.df$card <- as.numeric(revalue(joinclientcard$type_card,replace = c("gold" = 3, "classic" = 2, "junior" = 1)))

# Years that the client has the card
clientrating.df$year_card <- GetScoreForNumericVariables(GetAgeFromRefDate(joinclientcard$issued,refdate),"p")

# Account frequency
clientrating.df$acnt_frequency <- GetScoreForFactorVariables(joinclientaccount, "frequency", c("Monthly", "Weekly", "AfterTransaction"))

# Years that the client has the account
clientrating.df$year_account <- GetScoreForNumericVariables(GetAgeFromRefDate(joinclientaccount$date,refdate))

# Loans
clientrating.df$loan_status <- GetScoreForFactorVariables(joinclientacntloans, "status", c("ContractFinishedDefault", "RunningInDebt", "RunningOk","ContractFinishedOk"))

#clientrating.df$year_loan <- GetAgeFromRefDate(joinclientacntloans$date_loan,refdate) 
#clientrating.df$duration_loan <- joinclientacntloans$duration           
#year_loan <- clientrating.df$year_loan * 12
#duration <- joinclientacntloans$duration
#clientrating.df$mth_to_pay_loan <- ifelse(year_loan < duration, duration - year_loan,0)


# sum score
clientrating.df$sum_score <- rowSums(clientrating.df[,7:18], na.rm = TRUE) 

#colnames(clientrating.df)

#sapply(clientrating.df, class)

#View(clientrating.df)


hist(clientrating.df$sum_score)

boxplot(clientrating.df$sum_score~clientrating.df$gender)




