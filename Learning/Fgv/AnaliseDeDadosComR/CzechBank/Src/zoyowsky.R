#######################################
#
# Augusto
#
#######################################

detach("package:plyr", unload=TRUE) 
library(dplyr)

ViewDataZoyowsky <- function(instruction)
{
  check <- instruction
  
  return (View(check))
}

##############################################
# 1 - Data analysis of accounts.df = Zoyowsky
##############################################

# Checking for duplicate data (This has no duplicate data)
ViewDataZoyowsky(filter(summarise(group_by(accounts.df,account_id),N = n()), N > 1))

ViewDataZoyowsky(arrange(summarise(group_by(accounts.df,account_id,district_id),N = n()),account_id,district_id))


# Districts with more accounts (The districts with more than 100000 inhabitants have more accounts)
ViewDataZoyowsky(arrange(summarise(group_by(accounts.df, district_id),amount_accounts = n()), desc(amount_accounts)))

# Frequency of accounts (Follow in order: Monthly, Weekly and AfterTransaction with more frequencys)
ViewDataZoyowsky(arrange(summarise(group_by(accounts.df,frequency),amount_frequencys = n()), desc(amount_frequencys)))

# Number of oldest accounts per year
ViewDataZoyowsky(summarise(group_by(accounts.df,year = substr(accounts.df$date,1,4)), N = n()))


#############################################
# 2 - Data analysis of cards.df = Zoyowsky
#############################################

# Checking for duplicate data (This has no duplicate data)
ViewDataZoyowsky(filter(summarise(group_by(cards.df,card_id),N = n()), N > 1))
ViewDataZoyowsky(filter(summarise(group_by(cards.df, card_id, disp_id), N = n()), N > 1))
ViewDataZoyowsky(filter(summarise(group_by(cards.df, disp_id), N = n()), N > 1))


# Types of cards (Follow in order: Classic, Junior, Gold with more frequencys)
ViewDataZoyowsky(summarise(group_by(cards.df, type), N = n()))

# What districts have the cards type = gold
ViewDataZoyowsky(
  arrange(
    summarise(
      group_by(
        inner_join(
          filter(cards.df, type == "gold"),clientsdisp.df, by=c("disp_id","disp_id"))
        ,district_id), 
      N = n()), 
    desc(N)))

# Number of oldest cards per year
ViewDataZoyowsky(summarise(group_by(cards.df,year = substr(cards.df$issued,1,4)), N = n()))


#############################################
# 3 - clientsdisp,df
#############################################

# Checking for duplicate data (This has no duplicate data)
ViewDataZoyowsky(filter(summarise(group_by(clientsdisp.df,client_id),N = n()), N > 1))

# Year to birth date
ViewDataZoyowsky(clientsdisp.df %>% count(substr(birth_date,1,4), sort= T))

ViewDataZoyowsky(clientsdisp.df %>% count(age, sort = F))

# There's have duplicate districts in clientdisp.df
ViewDataZoyowsky(arrange(filter(summarise(group_by(clientsdisp.df,district_id),N = n()), N > 1),desc(N)))

View(arrange(filter(summarise(group_by(filter(clientsdisp.df,type == "OWNER"),district_id),N = n()), N > 1),desc(N)))
View(arrange(filter(summarise(group_by(filter(clientsdisp.df,type == "DISPONENT"),district_id),N = n()), N > 1),desc(N)))

ViewDataZoyowsky(arrange(summarise(group_by(accounts.df, district_id),amount_accounts = n()), desc(amount_accounts)))

ViewDataZoyowsky(arrange(summarise(group_by(accounts.df,district_id),amount_accounts = n()), desc(amount_accounts)))
client_accounts <- filter(clientsdisp.df,type == "OWNER") %>% count(district_id, sort = T)
View(client_accounts)

arrange(filter(clientsdisp.df,type == "OWNER"), district_id, account_id)

# Checking if the clients of type DISPONENT ordered a loan. (There's no DISPONENT order)
x <- filter(clientsdisp.df %>% count(district_id,account_id, sort = T), n == 1)

disponent_loan <- inner_join(x,filter(clientsdisp.df, type=="DISPONENT"), by = c("account_id","account_id"))

ViewDataZoyowsky(inner_join(disponent_loan, loans.df, by = c("account_id","account_id")))

View(right_join(accounts.df[,1:2], filter(clientsdisp.df[,3 & 7],type == "OWNER"), by = c("account_id", "account_id")))



