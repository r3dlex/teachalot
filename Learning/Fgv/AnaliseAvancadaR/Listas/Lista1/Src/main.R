library(magrittr) # Pipe
library(hmeasure) #HMeasure 
library(ResourceSelection) # hoslem.test

PrintGlmBinomialLogit <- function(formula, data.df)
{
  glm(formula, family = binomial(link = "logit"), data = data.df) %>%
    summary %>%
    print
}

# Questao 3
hbat400 <- read.csv("Data/HbatClima.csv")

fit.min.hbat400 <- glm(evasao ~ 1,family = binomial(link = "logit"), data = hbat400)

scope.formula <- ~
  JS1 + JS2 + JS3 + JS4 + JS5 + 
  OC1 + OC2 + OC3 + OC4 + 
  EP1 + EP2 + EP3 + EP4 + 
  AC1 + AC2 + AC3 + AC4 + 
  SI1 + SI2 + SI3 + SI4

step.hbat400 <- step(fit.min.hbat400,
                    direction = "both",
                    scope = scope.formula)

print(summary(step.hbat400), digits = 2)

# Questao 4 e 5
test.formulas <- c(evasao ~ SI1, evasao ~ SI2, evasao ~ SI3, evasao ~  SI4)
sapply(test.formulas, PrintGlmBinomialLogit, data.df = hbat400)

print("=============Correlation = SI1 + SI2 + SI3 + SI4==============")
print(cor(hbat400[,c("SI1", "SI2", "SI3", "SI4")]), digits = 2)
print("===============================================================")

#Questao 6
sixth.formula <- evasao ~ SI1 + SI2 + SI3 + SI4
sixth.data  <- hbat400[, c("evasao", "SI1", "SI2", "SI3", "SI4")]
sixth.pca <- princomp(sixth.data, cor = TRUE) # prcomp(sixth.data, scale = TRUE)
sixth.pca1 <- sixth.pca$scores[,1]
sixth.fit <- glm(sixth.data$evasao ~ sixth.pca1, 
                 family = binomial(link = "logit"), 
                 data = sixth.data)

sixth.predict <- predict(sixth.fit, newdata = sixth.data, type = "response")
print("=============SIXTH==============")
print(HMeasure(hbat400$evasao, sixth.predict)$metrics, digits = 2)
print(hoslem.test(sixth.data$evasao, fitted(sixth.fit)), digits = 2)
print("=============SIXTH==============")

third.fit <- step.hbat400
third.data <- hbat400[, c("evasao", "SI4", "SI1", "JS5")]
third.predict <- predict(third.fit, newdata = third.data, type = "response")
print("=============THIRD==============")
print(HMeasure(hbat400$evasao, third.predict)$metrics, digits = 2)
print(hoslem.test(third.data$evasao, fitted(third.fit)), digits = 2)
print("=============THIRD==============")
