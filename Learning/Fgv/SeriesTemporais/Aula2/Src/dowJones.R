library(forecast)
library(magrittr)

PlotAndGetTimeSeriesPerYear <- function(data, freq, year) {
  timeSeries <- data %>%
    ts(frequency=freq, start=c(year, 1))

  timeSeries %>% 
    plot.ts

  timeSeries
}

dowJonesData <- read.csv("Data/dowJonesIndex.csv")

dowJonesTimeSeries <- PlotAndGetTimeSeriesPerYear(data = dowJonesData$index, freq = 12, year = 1922)
arimaDowJonesIndex <- auto.arima(dowJonesTimeSeries)
summary(arimaDowJonesIndex) %>% 
  print
forecast(arimaDowJonesIndex, h = 12) %>% 
  print

#salaryTimeSeries <- PlotAndGetTimeSeriesPerYear(data = fiespData$salary[277:length(fiespData$salary)], freq = 12, year = 1993)
#arimaSalaryTimeSeries <- auto.arima(salaryTimeSeries)
#summary(arimaSalaryTimeSeries) %>% print
#forecast(arimaSalaryTimeSeries, h = 12) %>% 
  #print
