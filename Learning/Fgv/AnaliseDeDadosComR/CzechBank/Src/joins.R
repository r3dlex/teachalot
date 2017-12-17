########################
#
# Joins 
#
########################

library(gmodels)
library(tidyverse)
library(car)

# Comparing the results in decision tree and logistic regression
DecisionTreeXLogisticRegression <- funcion (data, field)
{
  
}

joinclientdistrict <- inner_join(clientsdisp.df, districts.df, by = c("district_id","district_id"))
joinaccountdistrict <- inner_join(accounts.df, districts.df, by = c("district_id","district_id")) 
colnames(joinclientdistrict)[3] <- c("cl_district_id")
colnames(joinclientdistrict)[9] <- c("type_cl")
joinclientcard <- left_join(joinclientdistrict, cards.df, by = c("disp_id","disp_id"))
colnames(joinclientcard)[26] <- c("type_card")


# Converting all intergers and character variables
joinclientcard[sapply(joinclientcard, is.integer)] <- lapply(joinclientcard[sapply(joinclientcard, is.integer)], as.numeric)
joinclientcard[sapply(joinclientcard, is.character)] <- lapply(joinclientcard[sapply(joinclientcard, is.character)], as.factor)

ViewDataZoyowsky(joinclientcard)

clientrating.df <- clientsdisp.df[1]
library(plyr)

rows <- row(distinct(clientsdisp.df,type))

x <- arrange(data.frame(rows),desc(rows))
x$type <- distinct(clientsdisp.df, type)$type
x$result <- paste(paste('"', x$type,'"', sep = ""), x$rows, sep = " = ")

View(c(x$result))

z <- (x$result)

# client type
clientrating.df <- revalue(joinclientcard$type_cl, c(z))

# Card score - Gold - 3, Classic - 2, Junior - 1

clientrating.df$card <- revalue(joinclientcard$type_card, z)

GetScoreForFactorVariables <- function(data, discript, strings)
{
  values <- data[, discript]
  scores <- 1:length(strings)
  names(scores) <- strings
  data$scores <- scores[values]
  
  return (data)
}

GetScoreForFactorVariables <- function(data, discript, strings)
{
  values <- data[, discript]
  scores <- 1:length(strings)
  names(scores) <- strings
  data$scores <- scores[values]
  
  return (data)
}

clientsdisp.df <- GetScoreForFactorVariables(clientsdisp.df, "type", c("DISPONENT", "OWNER"))
cards.df <- GetScoreForFactorVariables(cards.df, "type", c("junior", "classic", "gold"))
accounts.df <- GetScoreForFactorVariables(accounts.df, "frequency", c("Monthly", "Weekly", "AfterTransaction"))
