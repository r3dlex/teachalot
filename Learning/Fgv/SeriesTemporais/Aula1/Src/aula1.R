library(dplyr)

# Add parameters for calculation
AddNewRowForInad <- function(data, n) {
  data[n, ] <- data[n - 1, ]
  data[n, ]$bp5 <- data[n - 1, ]$bp4
  data[n, ]$bp3 <- data[n - 1, ]$bp2
  data[n, ]$bp2 <- data[n - 1, ]$bp1
  data[n, ]$bp1 <- data[n - 1, ]$bp

  data[n, ]$bpc3 <- data[n - 1, ]$bpc2
  data[n, ]$bpc2 <- data[n - 1, ]$bpc1
  data[n, ]$bpc1 <- data[n - 1, ]$bpc

  data[n, ]$bpd4 <- data[n - 1, ]$bpd3
  data[n, ]$bpd2 <- data[n - 1, ]$bpd1
  data[n, ]$bpd1 <- data[n - 1, ]$bpd

  data
}
 
#Exercicio inicial
vendas <- c(14, 16, 19, 22, 24)
vendasn <- c(16, 19, 22, 24, 26)
modeloVvendas <- lm (vendasn ~ vendas, data = data.frame(vendas, vendasn))


x1 <- c(16, 19, 22, 25)
x2 <- c(14, 16, 19, 22)
y <- c(19, 22, 24, 26)
modeloY <- lm(y ~ x1 + x2, data = data.frame(x1, x2, y))

inadimplentes  <- read.csv("Data/inadimplencia.csv")

inadimplentes$bpc
inadimplentesShift1 <- inadimplentes  %>% mutate_all(.funs = funs(lag), n = 1)
inadimplentesShift2 <- inadimplentes  %>% mutate_all(.funs = funs(lag), n = 2)
inadimplentesShift3 <- inadimplentes  %>% mutate_all(.funs = funs(lag), n = 3)
inadimplentesShift4 <- inadimplentes  %>% mutate_all(.funs = funs(lag), n = 4)
inadimplentesShift5 <- inadimplentes  %>% mutate_all(.funs = funs(lag), n = 5)

inadimplentes$bpc1 <- inadimplentesShift1$bpc
inadimplentes$bpc2 <- inadimplentesShift2$bpc
inadimplentes$bpc3 <- inadimplentesShift3$bpc

inadimplentes$bpd1 <- inadimplentesShift1$bpd
inadimplentes$bpd2 <- inadimplentesShift2$bpd
inadimplentes$bpd4 <- inadimplentesShift4$bpd

inadimplentes$bp1 <- inadimplentesShift1$bp
inadimplentes$bp2 <- inadimplentesShift2$bp
inadimplentes$bp3 <- inadimplentesShift3$bp
inadimplentes$bp5 <- inadimplentesShift5$bp

#inadimplentesRegressao <- write.csv(inadimplentes, file = "Data/inadimplentes_pre.csv")
write.csv(inadimplentesRegressao, file = "Data/inadimplentes_processado.csv")

modeloBpc <- lm(bpc ~ bpc1 + bpc2 + bpc3, data = inadimplentes[4:nrow(inadimplentes), ])
modeloBpd <- lm(bpd ~ bpd2 + bpd4, data = inadimplentes[5:nrow(inadimplentes), ])
modeloBp <- lm(bp ~ bp1 + bp3 + bp5, data = inadimplentes[6:nrow(inadimplentes), ])
modeloBpp <- lm(bp ~ bpc1 + bpd1, data = inadimplentes[2:nrow(inadimplentes), ])

inadFull <- AddNewRowForInad(inadimplentes, 62)

#BPC
paste0("BPC(62)", predict(modeloBpc, newdata = inadFull[62, ])) %>% print
#BPD
paste0("BPD(62)", predict(modeloBpd, newdata = inadFull[62, ])) %>% print
#BP
paste0("BP(62)", predict(modeloBp, newdata = inadFull[62, ])) %>% print
#BP = BPCt_-1 + BPDt_-1
paste0("BPP(62)", predict(modeloBp, newdata = inadFull[62, ])) %>% print



