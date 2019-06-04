## Exercicio 1 A
library(gmodels)
#install.packages("rpart.plot")
library(rpart.plot)

exerc1_prova <- read.csv2("Data/exerc1_prova2.csv")
exerc1_prova <- exerc1_prova[,-4]
set.seed(Sys.time())
dt_exerc1 <- rpart(STATUS~., data = exerc1_prova, method = "class")
dt_exerc1
prp(dt_exerc1, type = 2, extra = 104, fallen.leaves = T, box.col = c("yellow","grey"), cex=0.6)
printcp(dt_exerc1,digits=4)
prob <- predict(dt_exerc1, type="prob")
exerc1_prova$pbom=prob[,1]
exerc1_prova$pmau=prob[,2]

juquinha <- exerc1_prova[exerc1_prova$IDADE == 31 & exerc1_prova$UF == "SP"
                         & exerc1_prova$RESTR == "SIM" & exerc1_prova$QUANTI == "NAO" & exerc1_prova$NET == "NAO",]
juquinha


juca <- data.frame(STATUS = "MAU", IDADE = 31, UF = "SP", RESTR = "SIM", QUANTI = "NAO", NET = "NAO")
probjuca <- predict(dt_exerc1, newdata = juca, type="prob")
probjuca


# resposta: 9.9408%

## Exercicio 1 B

AUROC = roc(exerc1_prova$STATUS,exerc1_prova$pbom)
AUROC

# resposta 74.45%

## Exercicio 1 C
prob2 <- predict(dt_exerc1, type="class")
CrossTable(exerc1_prova$STATUS, prob2)

(115+347)/3000
# resposta 15.4%

## Exercicio 1 D

arvere <- rpart(exerc1_prova$STATUS~IDADE+UF+RESTR+QUANTI+NET,
                data = exerc1_prova,
                method = "class",
                control = rpart.control(minbucket = 100)
                )
arvere
printcp(arvere)
prp(arvere, type = 2, extra = 104, fallen.leaves = T, box.col = c("yellow","grey"), cex=0.6)

CUEVAS <- data.frame(STATUS = "MAU", IDADE = 31, UF = "SP", RESTR = "SIM", QUANTI = "SIM", NET = "NAO")
prob2 <- predict(arvere, newdata = CUEVAS, type="prob")
prob2

# resposta 69,82%

# Exercicio 2
install.packages("arules")
library(arules)

kidade <- discretize(exerc1_prova$IDADE, method = "frequency", categories = 6)
CrossTable(kidade, exerc1_prova$STATUS, prop.t = F, prop.c = F, prop.chisq = F)

0.692/0.308
0.773/0.227
0.837/0.163
0.791/0.209
0.872/0.128
0.855/0.145

# Como as proporções b/m são bem diferentes não fundiria nenhuma classe.

## Exercicio 3 A

exerc1_prova$STATUS <- as.factor(ifelse(exerc1_prova$STATUS == "MAU",1,0))
regressao <- glm(STATUS ~ IDADE+UF+RESTR+QUANTI+NET, data = exerc1_prova, family = binomial())
print(summary(regressao),digits = 3)
prob_reg <- predict(regressao, type = "response")

exerc1_prova$pmau_reg=prob_reg

# resposta 65.423%

## Exercicio 3 B

PEPE <- data.frame(STATUS = "MAU", IDADE = 34, UF = "SP", RESTR = "NAO", QUANTI = "NAO", NET = "NAO")
prob_pepe <- predict(regressao, newdata = PEPE, type="response")
prob_pepe

# resposta 15.014%

## Exercicio 3 C

KS <- HMeasure(exerc1_prova$STATUS, prob_reg)
summary(KS)

# resposta KS = 0.519

## Exercicio 3 D

regressao2 = step(regressao)

# Não
# Intercepto = -0.53142
