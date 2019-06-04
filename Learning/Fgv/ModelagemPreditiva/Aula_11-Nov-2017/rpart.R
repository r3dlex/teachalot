data <- read.csv2("data.csv")
data2 <- data[, !(names(data) %in% c("funcionario"))]
data2.mask.bom <- data2$status == "bom"
library(rpart)
dt <- rpart(data = xx, status~idade+prim_emp+teste+educ)
library(rpart.plot)
prp(dt, type=2, extra=104, nn=T, fallen.leaves = T, branch.col = "red", branch.lty = 5, box.col = c("white", "green"))
