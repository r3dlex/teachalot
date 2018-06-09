library(tseries)

births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
birthsTimeSeries <- ts(births, frequency=12, start=c(1946,1))
plot.ts(birthsTimeSeries)
