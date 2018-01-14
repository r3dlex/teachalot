library(magrittr) #  pipes
library(gmodels) # CrossTable
library(neuralnet) # neuralnet with multiple layers
library(arules) # discretize

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
  data$tvcabo <- data$tvcabo %>% AsNumericFactor
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
normal.df <- teba.df[,-1][,-7] #  Removes id and local

# Normalization
max.values <- apply(normal.df, 2, max) 
min.values <- apply(normal.df, 2, min)
normal.df <- as.data.frame(scale(normal.df, center = min.values, scale = max.values - min.values))

# Equivalent sample / createDataPartition calls
sample.flags <- GetSampleFlags(data = teba.df, percentage = 0.9, size = nrow(teba.df))
#sample.flags <- createDataPartition(teba.df$cancel, p = 0.6, list=F)
net.learn <- normal.df[sample.flags,]
net.test <- normal.df[-sample.flags,]
compute.test <- net.test[, -9] #  Test set without the cancel column
learn.names <- names(net.learn)
net.formula <- as.formula(paste("cancel ~", paste(learn.names[!learn.names %in% "cancel"], collapse = " + ")))

if (!exists("net"))
{
  net <- neuralnet(
      net.formula,
      data = net.learn, 
      hidden = c(5,2), 
      lifesign = "minimal") #  Minimal verbosity of the output
}

# Let's validate
net.test$netscore <- compute(net, compute.test)$net.result
print(HMeasure(net.test$cancel, net.test$netscore)$metrics)
# Prints correlations
teste <- discretize(net.test$netscore, method = "frequency", categories = 5)
CrossTable(teste, net.test$cancel, prop.t = F, prop.c = F, prop.chisq = F)

