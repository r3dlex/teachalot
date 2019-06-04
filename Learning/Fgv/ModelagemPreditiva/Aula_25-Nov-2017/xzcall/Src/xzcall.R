library(readxl)
library(gmodels)
library(rpart)
library(rpart.plot)

callcenter.df.read  <- function(filename)
{
  xzcall <- read_excel(filename)
  callcenter.df=xzcall[,-1]

  callcenter.df$IDADE[callcenter.df$IDADE=="25 - 45"]="25a45"
  callcenter.df$IDADE[callcenter.df$IDADE=="menor que 25"]="menor25"
  callcenter.df$IDADE[callcenter.df$IDADE=="maior que 45"]="maior45"

  return (callcenter.df)
}


callcenter.df.read("./xzcall.xlsx")

# Let's build the decision tree
library(rpart)
dt=rpart(data = callcenter.df,STATUS ~ IDADE + PRIM_EMP+TESTE + EDUC)
print(dt)
prp(dt, type=2, extra=104,nn=T, fallen.leaves = F, branch.col = "red", branch.lty = 5,box.col = c("white",'green'))

# Classroom annotations
CrossTable(callcenter.df$IDADE, callcenter.df$STATUS, prop.c = F, prop.t = F, prop.chisq = F)
boxplot(callcenter.df$TESTE ~ callcenter.df$STATUS, col=rainbow(7), main="TESTE")
hist(callcenter.df$TESTE)
LTESTE=log(100 - callcenter.df$TESTE)
hist(LTESTE)

# Cross validation
set.seed(1937)
# Generates a random number and creates one 
anumber <- sample(x = 1:3368, size = 2000, replace = F)
callcenter.learn <- callcenter.df[anumber, ]
callcenter.test <- callcenter.df[-anumber,]

# Apenas para conferência de valores
callcenter.ml  <- table(callcenter.learn$STATUS)
callcenter.mt  <- table(callcenter.test$STATUS)
callcenter.mlp <- prop.table(callcenter.ml)
callcenter.mlt <- prop.table(callcenter.mt)

# If the STATUS variable was numeric, one would need to tell rpart to use the method
callcenter.dt <- rpart(data = callcenter.learn, STATUS~ IDADE + PRIM_EMP + TESTE + EDUC)
prp(callcenter.dt, type = 2, extra = 104, nn = T, fallen.leaves = T, branch.col = "red", branch.lty = 5, box.col = c("white", "green"))
print(callcenter.dt, digits = 2)
printcp(callcenter.dt)

# Let's pretend that the best number of splits is 2, so let's prune the decision tree accordingly
callcenter.dt.pruned <- prune(callcenter.dt, cp = 0.05)
prp(callcenter.dt.pruned, type = 2, extra = 104, nn = T, fallen.leaves = T, branch.col = "red", branch.lty = 5, box.col = c("white", "green"))

# Maps the probabilty prediction based on the tree back to the test data
prob <- predict(callcenter.dt.pruned, newdata = callcenter.test, type = "prob")
callcenter.test$pbom = prob[, 1]
# Probability of hiring someone who is "bad"
cut.point <- 0.70
callcenter.test$classification <- ifelse(callcenter.test$pbom > cut.point, "good", "bad")
CrossTable(callcenter.test$classification, callcenter.test$STATUS, prop.r = F, prop.t = F, prop.chisq = F)

# minsplit - look at class slides

# Displays the best found prunning point
plotcp(callcenter.dt)
