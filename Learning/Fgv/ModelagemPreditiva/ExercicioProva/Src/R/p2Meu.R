library(rpart) #1A, 1D
library(rpart.plot)
library(pROC) #1B
library(gmodels) #1C
library(arules) #2
library(hmeasure)


kMySeed <- 1234
kPredictBomColumn <- 1
kPredictMauColumn <- 2
kDfFoneColumn <- 4

set.seed(kMySeed)

RunCrossTable <- function(x, y)
{
  CrossTable(x, y, prop.c = F, prop.t = F, prop.chisq = F)
}

# Reads all input variables with the exception of "FONE"
data.table <- read.csv2("Data/exerc1_prova.csv")[, -kDfFoneColumn]

# Generates initial tree
dt <- rpart(
    data=data.table,
    STATUS ~ .,
    method = "class")
prp(dt, type=1, extra=106, faclen = 30)

##############
# Exercise 1A#
##############
# using STATUS = "MAU" yields no difference as it will be estimated
juquinha <- data.frame(IDADE = 31, UF = "SP", RESTR = "SIM", QUANTI = "NAO", NET = "NAO")
pjuquinha <- predict(dt, newdata = juquinha, type = "prob")
print(sprintf("Probabilidade do Juquinha ser mau = %f", pjuquinha[, kPredictMauColumn]))
# Prints complexity parameters and tree
printcp(learn.tree) #  prints complexity parameter and other values

##############
# Exercise 1B#
#############
dt.probs <- predict(dt, newdata = data.table, type = "prob")
# It is the same ROC for both, of course!
print(roc(data.table$STATUS, dt.probs[, kPredictBomColumn]))
print(roc(data.table$STATUS, dt.probs[, kPredictMauColumn]))

##############
# Exercise 1C#
##############
#teba.roc <- roc(teba.test$cancel, predict.final)
#print(HMeasure(teba.test$cancel, predict.final)$metrics)
dt.class <- predict(dt, newdata = data.table, type = "class")
ct <- RunCrossTable(dt.class, data.table$STATUS)
# Prints the cross-validation error
print(sprintf("cv = %f", (ct$t[1,2] + ct$t[2,1]) / sum(ct$t)))

##############
# Exercise 1D#
##############
dtb <- rpart(
    data = data.table,
    STATUS ~ .,
    method = "class",
    control = rpart.control(minbucket = 100)) # Folha tem que ter + de 100

cuevas <- data.frame(IDADE = 31, UF = "SP", RESTR = "SIM", QUANTI = "SIM", NET = "NAO")
pcuevas <- predict(dt, newdata = cuevas, type = "prob")
print(sprintf("Probabilidade do Cuevas ser MAU = %f", pcuevas[, kPredictMauColumn]))

#############
# Exercise 2#
#############
kidade <- discretize(data.table$IDADE, method = "frequency", categories = 6)
#predict.table <- table(idade.discrete, data.table$IDADE)
# Solves 2A and 2B
ct <- RunCrossTable(kidade, data.table$STATUS)
# Prints ratio of BOM over MAU 
print(ct$t[, kPredictBomColumn] / ct$t[, kPredictMauColumn])
# From the observations it is possible to infer that no changes are necessary in this case

##############
# Exercise 3A#
##############

fit <- glm(STATUS ~ ., family = binomial(), data = data.table)

# MAU is 1 because it is ordered after BOM
p1019 <- predict(fit, newdata = data.table[1019, ], type = "response")
print(sprintf("Probabilidade do cliente ser MAU %f", p1019))

##############
# Exercise 3B#
##############
pepe <- data.frame(IDADE = 34, UF = "SP", RESTR = "NAO", QUANTI = "NAO", NET = "NAO")
ppepe <- predict(fit, newdata = pepe, type = "response")
print(sprintf("Probabilidade do Pepe ser MAU %f", ppepe))

##############
# Exercise 3C#
##############
dt.probs <- predict(fit, newdata = data.table, type = "response")
print(HMeasure(data.table$STATUS, dt.probs)$metrics) # KS = 0.5191667

##############
# Exercise 3D#
##############
print(summary(fit)) 
print(summary(step(fit))) # Shows intercept = -0.531422
