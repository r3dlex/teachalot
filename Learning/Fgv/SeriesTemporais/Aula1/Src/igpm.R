library(tseries)
library(TTR)
library(dplyr)

igpm <- read.csv("Data/igpm.csv")

PlotAndGetTimeSeriesPerYear <- function(data, freq, year) {
  timeSeries <- data %>%
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

igpmTimeSeries <- PlotAndGetTimeSeriesPerYear(igpm, 12, 2002)
igpmVector <- igpm$igpm
acf(igpmVector)
pacf(igpmVector)
regressionModel <- arima(igpmVector, order = c(1, 0, 0))
paste0("Regression Model", regressionModel) %>% print
predict(regressionModel, n.ahead = 1) %>% print
