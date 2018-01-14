library(magrittr) #  pipes
library(randomForest)

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

teba.df <- ReadDataFromFile()

regression.formula <- cancel ~ idade + linhas + temp_cli + renda + fatura + temp_rsd + local + tvcabo + debaut

tree.bag <- randomForest(
    regression.formula,
    data = teba.df,
    ntree = 1000,
#    mtry = 9, #  Default é m = sqrt(p)
    importance = T,
    na.action =  na.omit)

plot(tree.bag)
legend("center", c("OOB", "nao", "sim"), lty = 1, col = c("black", "green", "red"))

# Checks different variables influence over classifier
# varImpPlot(tree.bag)
random.phat <- predict(tree.bag, type = "prob")
random.yhat <- predict(tree.bag, type = "class")
CrossTable(teba.df$cancel, random.yhat, prop.t = FALSE, prop.chisq = FALSE, digit = 2)
