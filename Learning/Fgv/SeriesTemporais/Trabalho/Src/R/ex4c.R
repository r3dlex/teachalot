x = arima.sim(n=100, list(order=c(2,0,0), ar=c(0.3, 0.5)))
plot.ts(x)
acf(x)
pacf(x)
