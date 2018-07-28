setwd("C:/Users/vinicio_si/Documents/Analises de Séries Temporais/Trabalho01")
SerieDados = read.csv2("Serie_Dados.csv")

SerieDados[,2:13] = sapply(SerieDados[,2:13], function (x){x=as.numeric(levels(x))[x] } )
SerieDados$DATA = as.Date(SerieDados$DATA, "%d/%m/%Y")

# install.packages("tseries")
library(tseries)

# valeSeries = ts(SerieDados$VALE5)

# install.packages("xts")
library(xts)
# valeSeries = xts(SerieDados$VALE5, SerieDados$DATA)
# plot.ts(valeSeries)

# logValeSeries = log(valeSeries)
# plot.ts(logValeSeries)

for (x in c(2:13)){
  print(paste("plot.ts(", paste(colnames(SerieDados)[x], "Series", sep = ""), ")", sep = ""))
  print(paste("plot.ts(", paste(colnames(SerieDados)[x], "LogSeries", sep = ""), ")", sep = ""))
  assign(
    paste(colnames(SerieDados)[x], "Series", sep = "")
    , xts(SerieDados[,x], SerieDados$DATA)
  )
  assign(
    paste(colnames(SerieDados)[x], "LogSeries", sep = "")
    , log(get(paste(colnames(SerieDados)[x], "Series", sep = "")))
  )
}

library(ggplot2)
library(cowplot)

BaseHist = ggplot(data = SerieDados) +
            ylab("Quantidade") +
            xlab("Valor")

VALE5Hist = BaseHist + geom_histogram(aes(VALE5)) + ggtitle(paste("VALE5 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$VALE5), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$VALE5), 2)))
GOLL4Hist = BaseHist + geom_histogram(aes(GOLL4)) + ggtitle(paste("GOLL4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$GOLL4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$GOLL4), 2)))
AMBV4Hist = BaseHist + geom_histogram(aes(AMBV4)) + ggtitle(paste("AMBV4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$AMBV4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$AMBV4), 2)))
ITUB4Hist = BaseHist + geom_histogram(aes(ITUB4)) + ggtitle(paste("ITUB4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$ITUB4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$ITUB4), 2)))
BBDC4Hist = BaseHist + geom_histogram(aes(BBDC4)) + ggtitle(paste("BBDC4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$BBDC4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$BBDC4), 2)))
BVMF3Hist = BaseHist + geom_histogram(aes(BVMF3)) + ggtitle(paste("BVMF3 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$BVMF3), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$BVMF3), 2)))
RAPT4Hist = BaseHist + geom_histogram(aes(RAPT4)) + ggtitle(paste("RAPT4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$RAPT4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$RAPT4), 2)))
MYPK3Hist = BaseHist + geom_histogram(aes(MYPK3)) + ggtitle(paste("MYPK3 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$MYPK3), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$MYPK3), 2)))
GOAU4Hist = BaseHist + geom_histogram(aes(GOAU4)) + ggtitle(paste("GOAU4 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$GOAU4), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$GOAU4), 2)))
LLXL3Hist = BaseHist + geom_histogram(aes(LLXL3)) + ggtitle(paste("LLXL3 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$LLXL3), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$LLXL3), 2)))
CSAN3Hist = BaseHist + geom_histogram(aes(CSAN3)) + ggtitle(paste("CSAN3 - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$CSAN3), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$CSAN3), 2)))
DÓLARHist = BaseHist + geom_histogram(aes(DÓLAR)) + ggtitle(paste("DÓLAR - "
                                                                  , "Sd:"
                                                                  , round(sd(SerieDados$DÓLAR), 2)
                                                                  , "Média:"
                                                                  , round(mean(SerieDados$DÓLAR), 2)))

plot_grid(VALE5Hist, GOLL4Hist, AMBV4Hist,
          ITUB4Hist, BBDC4Hist, BVMF3Hist,
          RAPT4Hist, MYPK3Hist, GOAU4Hist,
          LLXL3Hist, CSAN3Hist, DÓLARHist,
          ncol = 3, nrow = 4)

oldPar = par()

graphics.off()
par("mar")
par(mfrow = c(4,6), mar=c(3,2,3,1))

acf(VALE5Series, main = "teste")
pacf(VALE5Series)

for (x in c(2:13)){
  acf(get(paste(colnames(SerieDados)[x], "Series", sep = "")), 
      main = paste("ACF", colnames(SerieDados)[x]))
  pacf(get(paste(colnames(SerieDados)[x], "Series", sep = "")),
       main = paste("PACF", colnames(SerieDados)[x]))
}


par(oldPar)


##2

sAleatoria = rnorm(200,0,0.1)
plot.ts(sAleatoria,xlab='tempo',ylab='observacoes')
acf(sAleatoria,main='ACF',xlab='defasagem',ylab='autocorrelacoes')
pacf(sAleatoria,main='PACF',xlab='defasagem',ylab='autocorrelacoes')

sAleatoria = rnorm(200,1,5)
sAleatoria = cumsum(sAleatoria)
plot.ts(sAleatoria,xlab='tempo',ylab='observacoes')
acf(sAleatoria,main='ACF',xlab='defasagem',ylab='autocorrelacoes')
pacf(sAleatoria,main='PACF',xlab='defasagem',ylab='autocorrelacoes')

sAleatoria = arima.sim(n = 200, list(ar = 0.7))
plot.ts(sAleatoria,xlab='tempo',ylab='observacoes')
acf(sAleatoria,main='ACF',xlab='defasagem',ylab='autocorrelacoes')
pacf(sAleatoria,main='PACF',xlab='defasagem',ylab='autocorrelacoes')

sAleatoria = arima.sim(n = 200, list(ma = -0.6))
plot.ts(sAleatoria,xlab='tempo',ylab='observacoes')
acf(sAleatoria,main='ACF',xlab='defasagem',ylab='autocorrelacoes')
pacf(sAleatoria,main='PACF',xlab='defasagem',ylab='autocorrelacoes')

arima.sim()


library(forecast)

skirtDiameter = scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat", skip = 5)
skirtDiameter

skirtDiameterSerie = ts(skirtDiameter, start = c(1866), frequency = 1)
skirtDiameterSerie

plot.ts(skirtDiameterSerie, main = "Série Original")


library("TTR")
skirtDiameterSerieSMA3 = SMA(skirtDiameterSerie, n=3)
plot.ts(skirtDiameterSerieSMA3, main = "Média Móvel de 3")

skirtDiameterSerieSMA8 = SMA(skirtDiameterSerie, n=8)
plot.ts(skirtDiameterSerieSMA8, main = "Média Móvel de 8")


acf(diff(skirtDiameterSerie))
pacf(diff(skirtDiameterSerie))

auto.arima(skirtDiameterSerie)

x = arima.sim(n=1000, list(order=c(1,0,0), ar=c(0.7)))
x = arima.sim(n=100, list(order=c(2,0,0), ar=c(0.3, 0.5)))
x = arima.sim(n=100, list(order=c(0,0,1), ma=c(-0.6)))

plot.ts(x)
acf(x)
pacf(x)

auto.arima(x)

##PIB

SeriePIBTRI = read.csv2("PIBTRI.csv")
SeriePIBTRISeries = ts(SeriePIBTRI$PIB, frequency = 4)

SeriePIBTRISeries

plot.ts(SeriePIBTRISeries)

plot(decompose(SeriePIBTRISeries))

SeriePIBPrev = ts(SeriePIBTRI[45:95,]$PIB, frequency = 4)

y = arima(SeriePIBPrev, order = c(1,1,0))

predict(y, 2)
