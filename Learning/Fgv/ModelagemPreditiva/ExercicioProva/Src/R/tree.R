library(magrittr) #  pipes
library(caret) # Data partition
library(gmodels) # CrossTable
library(rpart) # Decision Tree functions
library(rpart.plot) # Decision Tree plot

# The answer 
#set.seed(42) #  Example uses caret and set.seed(1234) instead
set.seed(1234) #  Value used in slides

# Converts from factor to numeric
AsNumericFactor <- function(x) 
{ 
  x %>% 
  unclass %>%
  as.numeric %>%
  -1 
}

data.directory <- "Data"
data.file <- "teba.csv"

NormalizeTeba <- function(data)
{
  data$cancel <- AsNumericFactor(data$cancel)
  data
}

ReadDataFromFile <- function()
{
  sprintf("%s/%s", data.directory, data.file) %>% 
  read.csv2 #%>%
  #NormalizeTeba
}

GetSampleFlags <- function(data, percentage, size)
{
  sample(1:size, size * percentage, replace=F)
}

teba.df <- ReadDataFromFile()
# Equivalent sample / createDataPartition calls
sample.flags <- GetSampleFlags(data = teba.df, percentage = 0.6, size = nrow(teba.df))
#sample.flags <- createDataPartition(teba.df$cancel, p = 0.6, list=F)
teba.learn <- teba.df[sample.flags,]
teba.test <- teba.df[-sample.flags,]

# Generates initial tree
learn.tree <- rpart(
    data=teba.learn,
    cancel ~ idade + linhas + temp_cli + renda + fatura + temp_rsd + local + tvcabo + debaut,
    method = "class")
prp(learn.tree, type=1, extra=106, faclen = 30)

phat.predict <- predict(learn.tree, newdata = teba.test, type = "prob")
yhat.predict <- predict(learn.tree, newdata= teba.test, type = "class")

CrossTable(teba.test$cancel, yhat.predict)

# Pruning
printcp(learn.tree) #  prints complexity parameter and other values
# Minimum xerror
prune.cp <- 0.010381
pruned.tree <- prune(learn.tree, cp = prune.cp)

# Pré-poda
# minsplit = menor tamanho de no para particao
# minbucket = menor tamanho de uma folha (default = round(minsplit / 3))
# xval = numero de cross validações
other.tree <- rpart(
    data=teba.learn,
    cancel ~ idade + linhas + temp_cli + renda + fatura + temp_rsd + local + tvcabo + debaut,
    method = "class",
    control = rpart.control(cp = prune.cp, minsplit = 60, xval = 150)) #  controle da pré-poda
