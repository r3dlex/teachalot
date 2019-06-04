library(tseries)
library(xts)
library(tidyverse)
library(magrittr)
library(forecast)
library(TTR)

kGenImgPath <- "./Gen/Image"

setwd("/home/andre/Workspace/teachalot/Learning/Fgv/SeriesTemporais/Trabalho")

GetImagePath <- function(name) {
  paste0(kGenImgPath, "/", name)
}

GeneratePdf <- function(name, ...) {
  pdf(name, width = 9, height = 6)
}

# Trata os dados de entrada
seriesDeDados <- read.csv("./Data/SeriesDeDados.csv")
seriesDeDados[, 2:13] <- sapply(
                                seriesDeDados[,2:13], function (x) {
                                  x=as.numeric(levels(x))[x] 
                                })
seriesDeDados$DATA <- as.Date(seriesDeDados$DATA, "%d/%m/%Y")
dadosSemData <- seriesDeDados[, 2:13]

################ EXERCICIO 1  #################
set.seed(1)

FuncaoTemporal1a <- function(x2, x1) {
  log(x2 / x1)
}

Funcao1a <- function(x) {
  ret <- NULL
  
  for (i in 1:length(x)) {
    ret[i] <- FuncaoTemporal1a(x[i+1], x[i])
  }
  
  return(ret)
}

matriz1a <- apply(dadosSemData, 2, Funcao1a)
matriz1a <- as.data.frame(head(matriz1a, -1))
media1a <- apply(matriz1a, 2, mean)
sd1a <- apply(matriz1a, 2, sd)
mediaDesvio1a <- rbind(media1a, sd1a)
#TODO - salvar matriz

#transforma a matriz em long format
matrizGather1b <- gather(matriz1a, "nome")

ggplot(matrizGather1b, aes(x=value)) + 
  xlim(-0.1,0.1) + 
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~nome)
ggsave("Gen/Image/dist1b.pdf", width = 9, height = 6)

# Grid com acf e pacf de cada variável
oldPar = par()

graphics.off()
GetImagePath("dist1c_acf_pac.pdf") %>% GeneratePdf(width = 9, height = 6)
par("mar")
par(mfrow = c(4,6), mar=c(3,2,3,1))

for (x in c(1:12)){
  acf(matriz1a[x], 
      main = paste("ACF", colnames(matriz1a)[x]))
  pacf(matriz1a[x],
       main = paste("PACF", colnames(matriz1a)[x]))
}

dev.off()

################ EXERCICIO 2  #################

set.seed(2)

## Letra d
dist2d <- rnorm(200, 0, 1)

GeneratePdf("./Gen/Image/dist2d_plot_ts.pdf")
plot.ts(dist2d, xlab='tempo', ylab='observacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2d_acf.pdf")
acf(dist2d, main='ACF', xlab='defasagem', ylab='autocorrelacoes')
dev.off()

pacf(dist2d, main='PACF', xlab='defasagem', ylab='autocorrelacoes')
dev.copy(GeneratePdf, "./Gen/Image/dist2d_pacf.pdf")
dev.off()

## Letra e
dist2e <- rnorm(200, 1, 5) %>%
  cumsum

GeneratePdf("./Gen/Image/dist2e_plot_ts.pdf")
plot.ts(dist2e, xlab='tempo',ylab='observacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2e_acf.pdf")
acf(dist2e, main='ACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2e_pacf.pdf")
pacf(dist2e, main='PACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

## Letra f 
dist2f <- arima.sim(n = 200, list(ar = 0.7))

GeneratePdf("./Gen/Image/dist2f_plot_ts.pdf")
plot.ts(dist2f, xlab='tempo',ylab='observacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2f_acf.pdf")
acf(dist2f, main='ACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2f_pacf.pdf")
pacf(dist2f, main='PACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

## Letra g
dist2g <- arima.sim(n = 200, list(ar = -0.8))
GeneratePdf("./Gen/Image/dist2g_plot_ts.pdf")
plot.ts(dist2g, xlab='tempo',ylab='observacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2g_acf.pdf")
acf(dist2g, main='ACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2g_pacf.pdf")
pacf(dist2g, main='PACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

## Letra  h

dist2h <- arima.sim(n = 200, list(ma = -0.6))

GeneratePdf("./Gen/Image/dist2h_plot_ts.pdf")
plot.ts(dist2h, xlab='tempo',ylab='observacoes')
dev.off() 

GeneratePdf("./Gen/Image/dist2h_acf.pdf")
acf(dist2h, main='ACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

GeneratePdf("./Gen/Image/dist2h_pacf.pdf")
pacf(dist2h, main='PACF',xlab='defasagem',ylab='autocorrelacoes')
dev.off()

################ EXERCICIO 3  #################
set.seed(3)

uri <- "http://robjhyndman.com/tsdldata/roberts/skirts.dat"
skirtDiameter <- scan(uri, skip = 5)
skirtDiameterTs <- ts(skirtDiameter, start = c(1866), frequency = 1)

GeneratePdf("./Gen/Image/dist3a_plot_ts.pdf")
plot.ts(skirtDiameterTs, main = "Série Original")
dev.off()

skirtDiameterTsSMA3 <- SMA(skirtDiameterTs, n=3)
GeneratePdf("./Gen/Image/dist3b_plot_ts_ma3.pdf")
plot.ts(skirtDiameterTsSMA3, main = "Média Móvel de 3")
dev.off()

skirtDiameterTsSMA8 <- SMA(skirtDiameterTs, n=8)
GeneratePdf("./Gen/Image/dist3b_plot_ts_ma8.pdf")
plot.ts(skirtDiameterTsSMA8, main = "Média Móvel de 8")
dev.off()

GeneratePdf("./Gen/Image/dist3c_diff_acf.pdf")
acf(diff(skirtDiameterTs))
dev.off()

GeneratePdf("./Gen/Image/dist3c_diff_pacf.pdf")
pacf(diff(skirtDiameterTs))
dev.off()

skirtDiameterTsDiffArima <- auto.arima(skirtDiameterTs)
skirtDiameterTsDiffArima %>% print


################ EXERCICIO 4  #################
set.seed(4)

PlotAndSaveArima4 <- function(x, name) {
  output <- paste0(kGenImgPath, "/", name)
  output %>% print
  
  outputPlotTs  <- paste0(output, "_plot_ts.pdf")
  outputPlotTs %>% print
  
  outputPlotTs %>% GeneratePdf
  plot.ts(x)
  dev.off()
  
  outputPlotAcf <- paste0(output, "_plot_acf.pdf")
  outputPlotAcf %>% print
  outputPlotAcf %>% GeneratePdf
  acf(x, main = "ACF")
  dev.off()
  
  outputPlotPacf <- paste0(output, "_plot_pacf.pdf")
  outputPlotPacf %>% print
  outputPlotPacf %>% GeneratePdf
  pacf(x, main = "PACF")
  dev.off()
  
  x %>% 
    auto.arima %>% 
    print
}

arima.sim(n=300, list(order=c(1,0,0), ar=c(0.7))) %>%
  PlotAndSaveArima4(name = "dist4b")

arima.sim(n=300, list(order=c(1,0,0), ar=c(-0.7))) %>%
  PlotAndSaveArima4(name = "dist4b")

arima.sim(n=300, list(order=c(2,0,0), ar=c(0.3, 0.5))) %>%
  PlotAndSaveArima4(name = "dist4c")

arima.sim(n=300, list(order=c(0,0,1), ma=c(0.6))) %>%
  PlotAndSaveArima4(name = "dist4d")

arima.sim(n=300, list(order=c(0,0,1), ma=c(-0.6))) %>%
  PlotAndSaveArima4(name = "dist4e")


################ EXERCICIO 5  #################
set.seed(5)

SeriePIBTRI <- read.csv("./Data/PIBTRI.csv")
SeriePIBTRISeries <- ts(SeriePIBTRI$PIB, frequency = 4)

GetImagePath("dist5a_plot_ts.pdf") %>% GeneratePdf
plot.ts(SeriePIBTRISeries)
dev.off()

GetImagePath("dist5b_decompose.pdf") %>% GeneratePdf
plot(decompose(SeriePIBTRISeries))
dev.off()

SeriePIBPrev = ts(SeriePIBTRI[45:95,]$PIB, frequency = 4)

y = arima(SeriePIBPrev, order = c(1,1,0))

predict(y, 2) %>% print
