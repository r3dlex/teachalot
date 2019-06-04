library(tseries)
library(TTR)
library(dplyr)

kUrl1 <- "http://robjhyndman.com/tsdldata/data/nybirths.dat"
kUrl2 <- "https://robjhyndman.com/tsdldata/data/fancy.dat"

PlotAndGetTimeSeriesPerYear <- function(url, freq, year) {
  timeSeries <- scan(url) %>%
    ts(frequency=freq, start=c(year, 1))

  timeSeries %>% 
    plot.ts

  timeSeries
}

DecomposeTimeSeriesAndPlot <- function(timeSeries) {
  timeSeriesDecomposed <- timeSeries %>%
    decompose

  plot(timeSeriesDecomposed)

  timeSeriesDecomposed
}

nycBirthTimeSeries <- PlotAndGetTimeSeriesPerYear(url = kUrl1, freq = 12, year = 1946)
nycBirthTimeSeries %>% DecomposeTimeSeriesAndPlot

fancyTimeSeries <- PlotAndGetTimeSeriesPerYear(url = kUrl2, freq = 12, year = 1987)
fancyTimeSeries %>% DecomposeTimeSeriesAndPlot

ar1 <- arima.sim(model=list(ar=.8), n = 1000)
plot(ar1)
acf(ar1) %>% print
# Quantas defasagens - 3
pacf(ar1)

# https://www.ime.usp.br/~pam/ef.html
kUrl3 <- "https://www.ime.usp.br/~pam/m-ibm2609.txt"

z <- arima(ar1, order = c(3, 0, 0))
a <- predict(z, n.ahead = 3)
