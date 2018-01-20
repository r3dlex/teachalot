############
#Exercise 2#
############

data.table <- read.csv2("Data/dilei.csv")[, -1]

data.table$ALVO <- ifelse(data.table$STATUS == "mau", 1, 0)
fit <- glm(STATUS ~ TIPORESID + PRIM_EMP + TESTE + EDUC, family = binomial(), data = data.table)

# X1012
#     FUNCIONÁRIO STATUS TIPORESID PRIM_EMP TESTE   EDUC      ALVO
#12       X1012    bom    propria     não    77     secundário    0
fx1012 <- data.frame(STATUS = "bom", TIPORESID = "propria", PRIM_EMP = "não", TESTE = 77, EDUC = "secundário")
pfx1012 <- predict(fit, newdata = fx1012, type = "response")
r.fit <- step(fit)
# STATUS ~ PRIM_EMP + TESTE + EDUC

tpar <- matrix(
  c(1100, 1240, 1450, 1600, 730, 610, 390, 240),
  nrow = 4)

timpar <- matrix(
  c(100, 240, 450, 600, 1730, 1610, 1390, 1240),
  nrow = 4)

row.sums <- apply(timpar, 1, function(x) x[1] + x[2])

gbpercentage <- c()

tfreq <- tpar
for (i in 1:nrow(tpar))
{
  tfreq[i, ] <- tpar[i, ] / row.sums[i]
}
