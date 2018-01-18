library(magrittr) #  pipes
library(gmodels) # CrossTable
library(boot) # Cross-validation tools
library(arules) # Discretize
library(hmeasure)
library(pROC)

# The answer 
kSeed <- 1234 #  42
set.seed(kSeed) #  Value used in slides

# Converts from factor to numeric
AsNumericFactor <- function(x) 
{ 
  x %>% 
  unclass %>%
  as.numeric %>%
  -1 
}

kDataDirectory <- "Data"
kDataFile <- "teba.csv"

NormalizeTeba <- function(data)
{
  data$cancel <- data$cancel %>% AsNumericFactor
  data$debaut <- data$debaut %>% AsNumericFactor
  data
}

ReadDataFromFile <- function()
{
  sprintf("%s/%s", kDataDirectory, kDataFile) %>% 
  read.csv2 %>%
  NormalizeTeba
}

GetSampleFlags <- function(data, percentage, size)
{
  sample(1:size, size * percentage, replace=F)
}

# Applies linear regression
teba.df <- ReadDataFromFile()

# Equivalent sample / createDataPartition calls
sample.flags <- GetSampleFlags(data = teba.df, percentage = 0.6, size = nrow(teba.df))
#sample.flags <- createDataPartition(teba.df$cancel, p = 0.6, list=F)
teba.learn <- teba.df[sample.flags,]
teba.test <- teba.df[-sample.flags,]

regression.formula <- cancel ~ idade + linhas + temp_cli + renda + fatura + temp_rsd + tvcabo + debaut
teba.regression <- glm(regression.formula, family = binomial(), data = teba.learn)
summary(teba.regression)

# Tries to guess a threshold value (0.6) and see what is the overall error in this case
predict.cancel <- predict(teba.regression, newdata = teba.test, type = "response")
responses <- as.factor(ifelse(predict.cancel >= 0.6, 0, 1))
CrossTable(teba.test$cancel, responses, prop.chisq=F, prop.t = F, digit = 2)

#teba.cv <- cv.glm(
    #data=teba.df, 
    #glmfit = teba.regression,
    #K = 10) #  K = number of groups to split the date

# Leave one-out cross validation (too slow!)
#teba.loocv <- cv.glm(
    #data=teba.df, 
    #glmfit = teba.regression) 

predict.calibration <- discretize(predict.cancel, method = "frequency", categories = 6)
predict.table <- table(predict.calibration, teba.test$cancel)
print(predict.table)

PrintFixedIntervals <- function(data, predict.data)
{
  #From the observations one could divide into 5 main categories
  #limits <- c(0, 0.2, 0.45, 0.55, 0.7, 1)
  fixed.calibration <- discretize(predict.data, method = "frequency", categories = 5)
  fixed.table <- table(fixed.calibration, data)
  print(fixed.table)
  CrossTable(fixed.calibration, data, prop.c = F, prop.t = F, prop.chisq = F, digit = 3)
}

#PrintFixedIntervals(teba.test$cancel, predict.cancel)

# Will show the best linear regression variables
final.regression <- step(teba.regression)
#final.formula <- cancel ~ idade + temp_cli + renda + fatura
#final.regression <- glm(final.formula, family = binomial(), data = teba.df)

predict.final <- predict(final.regression, newdata = teba.test, type = "response")
PrintFixedIntervals(teba.test$cancel, predict.final)
final.responses <- as.factor(ifelse(predict.final >= 0.6, 0, 1))
CrossTable(teba.test$cancel, final.responses, prop.chisq=F, prop.t = F, digit = 2)
# KS = Kolmogorov-Smirnov
# AUC = AUROC (Area under ROC)
print(HMeasure(teba.test$cancel, predict.final)$metrics)
# Sensitivity = True positive Rate
# Specificity = False positive Rate
#teba.roc <- roc(teba.test$cancel, predict.final)
