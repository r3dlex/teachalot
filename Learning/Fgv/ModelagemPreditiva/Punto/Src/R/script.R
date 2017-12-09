library(arules)
library(gmodels)
library(hmeasure)
library(pROC)
library(rpart)
library(neuralnet)

source.directory <- "Src"
data.directory <- "Data"
gen.directory <- "Gen"
image.directory <- sprintf("%s/%s", gen.directory, "Img")
gentable.directory <- sprintf("%s/%s", gen.directory, "Table")

GenerateDirectory <- function(dirname)
{
  dir.create(file.path(".", dirname), showWarnings = FALSE)
}

GenerateDirectories <- function()
{
  sapply(c(gen.directory, image.directory, gentable.directory), GenerateDirectory)
}

GetDataFilepath <- function(filename)
{
  return (sprintf("%s/%s", data.directory, filename))
}

GetSrcFilepath <- function(filename)
{
  return (sprintf("%s/%s", source.directory, filename))
}

GetImgFilepath <- function(filename)
{
  return (sprintf("%s/%s", image.directory, filename))
}

ReadPuntoDataFrame <- function()
{
  punto.df <- read.csv2("Data/Punto.csv")
  # WARNING
  # Removes the client column as it is unnecessary for this calculus
  punto.df <- punto.df[, -1]

  # Converts to characters - necessary for neural networks
  punto.df$RESID <- as.character(punto.df$RESID)
  punto.df$SEXO <- as.character(punto.df$SEXO)

  return (punto.df)
}

GenerateDirectories()

RunLinearRegression <- function(punto.df)
{
  # Creates some discrete repreesentations from the given datasets
  punto.df$Krenda <- discretize(punto.df$RENDA, method = "frequency", categories = 5)
  punto.df$StatusTur <- ifelse(punto.df$STATUS == "turismo", 1, 0)

  flag <- sample(1:1000, 500, replace=F)
  learn.df <- punto.df[flag, ]
  test.df <- punto.df[-flag, ]

  # Regression
  fit <- glm(data = learn.df, STATUS ~ RENDA + ESCOL + RESID + SEXO, family = binomial())
  summary(fit)

  # Select proper variables
  fit2 <- step(fit)
  print(summary(fit2), digits=3)

  ## Expected result is
  ## z = -0.144 + 0.005 * RENDA + 0.480 * ESCOL - 0.435 * RESID2 + 0.3 * RESID3
  test.df$Ptur  <- predict(fit2, newdata = test.df, type = "response")
  test.df$Kptur <- discretize(test.df$Ptur, method = "frequency", categories = 5)

  # Let's check if the predicted estimates are correct
  CrossTable(test.df$Kptur, test.df$STATUS, prop.c = F, prop.t = F, prop.chisq = F)

  # WARNING
  # Kolmogorov-Smirnov (KS) - not precise enough (Laredo) - small differences in the output does not means anything
  # Let's never use it commercially
  # Uses hmodels

  # TP = True Positive (Sensitivity), FP = False Positive (1 - Specificity in the plot)

  # roc (AUROC) -> Area under curve (auc) on R
  # H - Prof. Hand
  reg.measure <- HMeasure(test.df$STATUS, test.df$Ptur)
  a <- roc(test.df$STATUS, test.df$Ptur)
  plot(a)

  # comparando com arvore
  dtree <- rpart(data = learn.df, STATUS ~ RENDA + ESCOL + RESID + SEXO)
  ppx  <- predict(dtree, newdata = test.df, type = "prob")
  dtree.measure <- HMeasure(test.df$STATUS, ppx)
}

# Neural nets
RunNeuralNetworks <- function(punto.orig.df)
{
  punto.orig.df <- ReadPuntoDataFrame()
  punto.orig.df$RESID  <- as.character(punto.orig.df$RESID)
  punto.orig.df$SEXO <- as.character(punto.orig.df$SEXO)
  pmodel.df <- model.matrix(data = punto.orig.df, ~.)
  pmodel.df <- as.data.frame(pmodel.df)[, -1]

  indices <- sample(1:1000, 500, replace = F)
  modelmin <- apply(pmodel.df, 2, min)
  modelmax <- apply(pmodel.df, 2, max)
  pmodel.final.df <- as.data.frame(scale(pmodel.df, center = modelmin, scale = modelmax - modelmin))
  # Learn and test sets
  learn.rn.df  <- pmodel.final.df[indices, ]
  test.rn.df <- pmodel.final.df[-indices, ]
  # hidden = number of layers
  model.nn <- neuralnet(data = learn.rn.df, STATUSturismo ~ RENDA + ESCOL + RESID2 + RESID3 + SEXO1, hidden = 1)
  plot(model.nn)
  test.rn.df$Score <- compute(model.nn, test.rn.df[, -1])$net.result
  # Test the effectiveness of the neural net
  HMeasure(test.rn.df$STATUSturismo, test.rn.df$Score)$metrics
  # Tests joao
  joao  <- data.frame(RENDA =.357, ESCOL = 0.853, RESID2=1, RESID3 = 0, SEXO1= 0)
  print(compute(model.nn, joao)$net.result)
  # Prints correlations
  teste <- discretize(test.rn.df$Score, method = "frequency", categories = 5)
  print(CrossTable(teste, test.rn.df$STATUSturismo, prop.t = F, prop.c = F, prop.chisq = F))
}

# Used by Laredo in class
set.seed(2000)
RunLinearRegression(ReadPuntoDataFrame())
set.seed(324)
RunNeuralNetworks(ReadPuntoDataFrame())
