library(forecast)
library(magrittr)
library(tseries)
library(TTR)

PlotAndGetTimeSeriesPerYear <- function(data, freq, year) {
  timeSeries <- data %>%
    ts(frequency=freq, start=c(year, 1))

  timeSeries %>% 
    plot.ts

  timeSeries
}

#IGPM
igpm <- read.csv("Data/igpm.csv")
igpmTimeSeries <- PlotAndGetTimeSeriesPerYear(data = igpm$igpm, freq = 12, year = 2002)
arimaIgpm <- auto.arima(igpmTimeSeries)
summary(arimaIgpm) %>% print

arimaIgpmPredict <- predict(arimaIgpm, n.ahead = 12) 

arimaIgpmPredict %>%
  paste0('Arima IGPM') %>%
  print

# GDP
gdp <- read.csv("Data/gdpBrazil.csv")
gdpTimeSeries <- PlotAndGetTimeSeriesPerYear(data = gdp$gdp, freq = 1, year = 1948)
arimaGdp <- auto.arima(gdpTimeSeries) 
summary(arimaGdp) %>% print

arimaGdpPredict <- predict(arimaGdp, n.ahead = 12) 

arimaGdpPredict %>%
  paste0('Arima GDP') %>%
  print
