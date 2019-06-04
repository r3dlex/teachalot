library(forecast)
library(magrittr)

PlotAndGetTimeSeriesPerYear <- function(data, freq, year) {
  timeSeries <- data %>%
    ts(frequency=freq, start=c(year, 1))

  timeSeries %>% 
    plot.ts

  timeSeries
}

fiespData <- read.csv("Data/fiesp.csv")

# Removes NA
fiespData$rawSteelProd[183] = 1424.2
rawSteelProdTimeSeries <- PlotAndGetTimeSeriesPerYear(data = fiespData$rawSteelProd, freq = 12, year = 1970)
arimaRawSteelProd <- auto.arima(rawSteelProdTimeSeries)
summary(arimaRawSteelProd) %>% print
forecast(arimaRawSteelProd, h = 12) %>% 
  print

salaryTimeSeries <- PlotAndGetTimeSeriesPerYear(data = fiespData$salary[277:length(fiespData$salary)], freq = 12, year = 1993)
arimaSalaryTimeSeries <- auto.arima(salaryTimeSeries)
summary(arimaSalaryTimeSeries) %>% print
forecast(arimaSalaryTimeSeries, h = 12) %>% 
  print
