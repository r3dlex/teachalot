x = arima.sim(n=100, list(order=c(1,0,0), ar=c(0.7)))
plot.ts(x)
acf(x)
pacf(x)
